import os
from dataclasses import dataclass, field
from typing import Optional, Dict, Sequence, Tuple, List
import pandas as pd
import torch
import transformers
from transformers import EarlyStoppingCallback, set_seed 
import sklearn
import numpy as np
from torch.utils.data import Dataset
from sklearn.metrics import mean_squared_error, mean_absolute_error, r2_score
import matplotlib.pyplot as plt
import os
import csv
import copy
import json
import logging
from dataclasses import dataclass, field
from typing import Optional, Dict, Sequence, Tuple, List
import pandas as pd
import torch
import transformers
import sklearn
import numpy as np
from torch.utils.data import Dataset
from sklearn.metrics import mean_squared_error, mean_absolute_error, r2_score

from transformers import AutoModelForSequenceClassification, AutoTokenizer
from peft import PeftModel

from peft import (
    LoraConfig,
    get_peft_model
)

@dataclass
class ModelArguments:
    model_name_or_path: Optional[str] = field(default="facebook/opt-125m")
    use_lora: bool = field(default=False, metadata={"help": "whether to use LoRA"})
    lora_r: int = field(default=8, metadata={"help": "hidden dimension for LoRA"})
    lora_alpha: int = field(default=32, metadata={"help": "alpha for LoRA"})
    lora_dropout: float = field(default=0.05, metadata={"help": "dropout rate for LoRA"})
    lora_target_modules: str = field(default="query,value", metadata={"help": "where to perform LoRA"})


@dataclass
class DataArguments:
    data_path: str = field(default=None, metadata={"help": "Path to the training data."})
    kmer: int = field(default=-1, metadata={"help": "k-mer for input sequence. -1 means not using k-mer."})


@dataclass
class TrainingArguments(transformers.TrainingArguments):
    cache_dir: Optional[str] = field(default=None)
    run_name: str = field(default="run")
    optim: str = field(default="adamw_torch")
    model_max_length: int = field(default=512, metadata={"help": "Maximum sequence length."})
    gradient_accumulation_steps: int = field(default=1)
    per_device_train_batch_size: int = field(default=1)
    per_device_eval_batch_size: int = field(default=1)
    num_train_epochs: int = field(default=1)
    fp16: bool = field(default=False)
    logging_steps: int = field(default=100)
    save_steps: int = field(default=100)
    eval_steps: int = field(default=100)
    evaluation_strategy: str = field(default="steps"),
    warmup_steps: int = field(default=50)
    weight_decay: float = field(default=0.01)
    learning_rate: float = field(default=1e-4)
    save_total_limit: int = field(default=3)
    load_best_model_at_end: bool = field(default=True) 
    output_dir: str = field(default="output")
    find_unused_parameters: bool = field(default=False)
    checkpointing: bool = field(default=False)
    dataloader_pin_memory: bool = field(default=False)
    eval_and_save_results: bool = field(default=True)
    save_model: bool = field(default=False)
    seed: int = field(default=42)
    base_model: str = field(default="")
    adapter_model: str = field(default="")
    

def safe_save_model_for_hf_trainer(trainer: transformers.Trainer, output_dir: str):
    """Collects the state dict and dump to disk."""
    state_dict = trainer.model.state_dict()
    if trainer.args.should_save:
        cpu_state_dict = {key: value.cpu() for key, value in state_dict.items()}
        del state_dict
        trainer._save(output_dir, state_dict=cpu_state_dict)  # noqa


def get_alter_of_dna_sequence(sequence: str):
    MAP = {"A": "T", "T": "A", "C": "G", "G": "C"}
    # return "".join([MAP[c] for c in reversed(sequence)])
    return "".join([MAP[c] for c in sequence])


def generate_kmer_str(sequence: str, k: int) -> str:
    """Generate k-mer string from DNA sequence."""
    return " ".join([sequence[i:i+k] for i in range(len(sequence) - k + 1)])


def load_or_generate_kmer(data_path: str, texts: List[str], k: int) -> List[str]:
    """Load or generate k-mer string for each DNA sequence."""
    kmer_path = data_path.replace(".csv", f"_{k}mer.json")
    if os.path.exists(kmer_path):
        logging.warning(f"Loading k-mer from {kmer_path}...")
        with open(kmer_path, "r") as f:
            kmer = json.load(f)
    else:        
        logging.warning(f"Generating k-mer...")
        kmer = [generate_kmer_str(text, k) for text in texts]
        with open(kmer_path, "w") as f:
            logging.warning(f"Saving k-mer to {kmer_path}...")
            json.dump(kmer, f)
        
    return kmer

class SupervisedDataset(Dataset):
    def __init__(self, 
                 data_path: str, 
                 tokenizer: transformers.PreTrainedTokenizer, 
                 kmer: int = -1):

        super(SupervisedDataset, self).__init__()

        # load data from the disk
        with open(data_path, "r") as f:
            data = list(csv.reader(f))[1:]
        if len(data[0]) == 2:
            # data is in the format of [text, label]
            logging.warning("Perform single sequence classification...")
            texts = [d[0] for d in data]
            labels = [float(d[1]) for d in data] # I have removed the int(d[1]) for regression? 
        elif len(data[0]) == 3:
            # data is in the format of [text1, text2, label]
            logging.warning("Perform sequence-pair classification...")
            texts = [[d[0], d[1]] for d in data]
            labels = [int(d[2]) for d in data]
        else:
            raise ValueError("Data format not supported.")
        
        if kmer != -1:
            # only write file on the first process
            if torch.distributed.get_rank() not in [0, -1]:
                torch.distributed.barrier()

            logging.warning(f"Using {kmer}-mer as input...")
            texts = load_or_generate_kmer(data_path, texts, kmer)

            if torch.distributed.get_rank() == 0:
                torch.distributed.barrier()

        output = tokenizer(
            texts,
            return_tensors="pt",
            padding="longest",
            max_length=tokenizer.model_max_length,
            truncation=True,
        )

        self.input_ids = output["input_ids"]
        self.attention_mask = output["attention_mask"]
        self.labels = labels
        self.num_labels = len(set(labels))

    def __len__(self):
        return len(self.input_ids)

    def __getitem__(self, i) -> Dict[str, torch.Tensor]:
        return dict(input_ids=self.input_ids[i], labels=self.labels[i])


@dataclass
class DataCollatorForSupervisedDataset(object):
    """Collate examples for supervised fine-tuning."""

    tokenizer: transformers.PreTrainedTokenizer

    def __call__(self, instances: Sequence[Dict]) -> Dict[str, torch.Tensor]:
        input_ids, labels = tuple([instance[key] for instance in instances] for key in ("input_ids", "labels"))
        input_ids = torch.nn.utils.rnn.pad_sequence(
            input_ids, batch_first=True, padding_value=self.tokenizer.pad_token_id
        )
        labels = torch.Tensor(labels).float() # Changed from labels = torch.Tensor(labels).long() to labels = torch.Tensor(labels).float() because of https://github.com/MAGICS-LAB/DNABERT_2/issues/79 
        return dict(
            input_ids=input_ids,
            labels=labels,
            attention_mask=input_ids.ne(self.tokenizer.pad_token_id),
        )

def compute_metrics(eval_pred):
    logits, labels = eval_pred
    # Commented out code was orriginal. 
    #if isinstance(logits, tuple):  # Unpack logits if it's a tuple
    #    logits = logits[0]
    #return calculate_metric_with_sklearn(logits, labels)
    logits = logits.flatten()  # Flatten logits for regression
    labels = labels.flatten()  # Flatten labels for regression
    mse = mean_squared_error(labels, logits)
    mae = mean_absolute_error(labels, logits)
    r2 = r2_score(labels, logits)
    rmse = np.sqrt(mse)
    return {
        "mse": mse,
        "mae": mae,
        "r2": r2,
        "rmse": rmse
    }

def model_init():
    # load model
    model = transformers.AutoModelForSequenceClassification.from_pretrained(
        model_args.model_name_or_path,
        cache_dir=training_args.cache_dir,
        num_labels=train_dataset.num_labels,
        trust_remote_code=True,
    )        
    return model



def save_predictions(trainer, eval_dataset, output_dir):
    """Save model predictions and actual values."""
    # Get predictions
    predictions = trainer.predict(eval_dataset)
    preds = predictions.predictions.flatten()  # Flatten for regression
    labels = predictions.label_ids.flatten()  # Flatten labels
    # Save predictions and actual values to CSV
    results_df = pd.DataFrame({'Actual': labels, 'Predicted': preds})
    results_path = os.path.join(output_dir, "predictions.csv")
    results_df.to_csv(results_path, index=False)
    print(f"Predictions saved to {results_path}")
    return preds, labels

def plot_predictions_vs_actual(preds, labels, output_file_name):
    """Plot predicted values against actual values."""
    plt.figure(figsize=(10, 6))
    plt.scatter(labels, preds, alpha=0.5, color='blue')
    plt.plot([min(labels), max(labels)], [min(labels), max(labels)], color='red', linestyle='--')
    plt.xlabel('Actual Values')
    plt.ylabel('Predicted Values')
    plt.title('Predicted vs Actual Values')
    plt.grid(True)
    plt.savefig(output_file_name, dpi=900)


def load_trained_model(base_model_path, adapter_model_path, model_args, training_args):
    """Load a trained model from a specified path."""
    print(f"Loading model from {base_model_path} with {adapter_model_path}...")
    model = transformers.AutoModelForSequenceClassification.from_pretrained(
        base_model_path,
        cache_dir=training_args.cache_dir,
        num_labels=1,  # Assuming regression with 1 output
        trust_remote_code=True,
    )
    base_model = AutoModelForSequenceClassification.from_pretrained(
        base_model_path,
        num_labels=1,  # regression
        trust_remote_code=True)
    model = PeftModel.from_pretrained(
        base_model,
        adapter_model_path)
    return model 



def train_or_load_model():
    parser = transformers.HfArgumentParser((ModelArguments, DataArguments, TrainingArguments))
    model_args, data_args, training_args = parser.parse_args_into_dataclasses()

    # Define tokenizer
    tokenizer = transformers.AutoTokenizer.from_pretrained(
        training_args.base_model,  # <-- use the base model path!
        cache_dir=training_args.cache_dir,
        model_max_length=training_args.model_max_length,
        padding_side="right",
        use_fast=True,
        trust_remote_code=True,)


    # Define datasets and data collator
    train_dataset = SupervisedDataset(tokenizer=tokenizer, 
                                      data_path=os.path.join(data_args.data_path, "train.csv"), 
                                      kmer=data_args.kmer)
    val_dataset = SupervisedDataset(tokenizer=tokenizer, 
                                     data_path=os.path.join(data_args.data_path, "dev.csv"), 
                                     kmer=data_args.kmer)
    data_collator = DataCollatorForSupervisedDataset(tokenizer=tokenizer)

    # Check if a pre-trained model exists
    base_model_path = training_args.base_model  
    adapter_model_path = training_args.adapter_model
    if os.path.exists(base_model_path) and os.path.exists(adapter_model_path):
        model = load_trained_model(base_model_path, adapter_model_path, model_args, training_args)
    else:
        # If no pre-trained model exists, initialize a new model
        print('Error no pretrained model found')
        exit()
        
    # Evaluate the model and plot predictions
    trainer = transformers.Trainer(
        model=model,
        tokenizer=tokenizer,
        args=training_args,
        compute_metrics=compute_metrics,
        eval_dataset=val_dataset,
        data_collator=data_collator
    )

    # Save predictions and plot results
    preds, labels = save_predictions(trainer, val_dataset, training_args.output_dir)
    print(f'Predictions saved to {training_args.output_dir}')
    #plot_predictions_vs_actual(preds, labels)

if __name__ == "__main__":
    print('Training script beginning')
    train_or_load_model()