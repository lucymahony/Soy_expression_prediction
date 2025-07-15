import os
import csv
import json
import logging
from dataclasses import dataclass, field
from typing import Optional, Dict, List, Sequence
import pandas as pd
import torch
import transformers
from torch.utils.data import Dataset
from transformers import Trainer, TrainingArguments, EarlyStoppingCallback, set_seed
from peft import IA3Config, get_peft_model
from sklearn.metrics import mean_squared_error, mean_absolute_error, r2_score
import numpy as np
from transformers.trainer_utils import IntervalStrategy 



@dataclass
class ModelArguments:
    model_name_or_path: Optional[str] = field(default="facebook/opt-125m")
    use_ia3: bool = field(default=True, metadata={"help": "Use IA3 fine-tuning"})


@dataclass
class DataArguments:
    data_path: str = field(default=None, metadata={"help": "Path to training data."})
    kmer: int = field(default=-1, metadata={"help": "k-mer for input sequence (-1 for no k-mer)."})


@dataclass
class CustomTrainingArguments(TrainingArguments):
    evaluation_strategy: IntervalStrategy = field(default=IntervalStrategy.STEPS) 
    cache_dir: Optional[str] = field(default=None)
    run_name: str = field(default="run")
    per_device_train_batch_size: int = field(default=1)
    per_device_eval_batch_size: int = field(default=1)
    num_train_epochs: int = field(default=4)
    gradient_accumulation_steps: int = field(default=5)
    eval_steps: int = field(default=50)
    logging_steps: int = field(default=50)
    save_steps: int = field(default=50)
    save_total_limit: int = field(default=3)
    load_best_model_at_end: bool = field(default=True)
    learning_rate: float = field(default=3e-4)
    warmup_steps: int = field(default=5)
    weight_decay: float = field(default=0.01)
    output_dir: str = field(default="output")
    save_model: bool = field(default=False)
    log_csv_path: str = field(default="log.csv")


def compute_metrics(eval_pred):
    """ Compute regression metrics including relative MSE and relative MAE """
    logits, labels = eval_pred
    logits = logits.flatten()
    labels = labels.flatten()

    mse = mean_squared_error(labels, logits)
    mae = mean_absolute_error(labels, logits)
    r2 = r2_score(labels, logits)
    rmse = np.sqrt(mse)

    variance_labels = np.var(labels)
    mean_abs_labels = np.mean(np.abs(labels))

    relative_mse = mse / variance_labels if variance_labels != 0 else float("inf")
    relative_mae = mae / mean_abs_labels if mean_abs_labels != 0 else float("inf")

    return {
        "mse": mse,
        "mae": mae,
        "r2": r2,
        "rmse": rmse,
        "relative_mse": relative_mse,
        "relative_mae": relative_mae
    }


class SupervisedDataset(Dataset):
    """ Custom dataset for supervised fine-tuning """

    def __init__(self, data_path: str, tokenizer: transformers.PreTrainedTokenizer, kmer: int = -1):
        super(SupervisedDataset, self).__init__()

        with open(data_path, "r") as f:
            data = list(csv.reader(f))[1:]

        texts = [d[0] for d in data]
        labels = [float(d[1]) for d in data]

        output = tokenizer(
            texts, return_tensors="pt", padding="longest", max_length=tokenizer.model_max_length, truncation=True
        )

        self.input_ids = output["input_ids"]
        self.attention_mask = output["attention_mask"]
        self.labels = labels

    def __len__(self):
        return len(self.input_ids)

    def __getitem__(self, i) -> Dict[str, torch.Tensor]:
        return dict(input_ids=self.input_ids[i], labels=self.labels[i])


class DataCollatorForSupervisedDataset:
    """ Collate examples for supervised fine-tuning """

    def __init__(self, tokenizer):
        self.tokenizer = tokenizer

    def __call__(self, instances: Sequence[Dict]) -> Dict[str, torch.Tensor]:
        input_ids, labels = tuple([instance[key] for instance in instances] for key in ("input_ids", "labels"))
        input_ids = torch.nn.utils.rnn.pad_sequence(input_ids, batch_first=True, padding_value=self.tokenizer.pad_token_id)
        labels = torch.Tensor(labels).float()
        return dict(input_ids=input_ids, labels=labels, attention_mask=input_ids.ne(self.tokenizer.pad_token_id))


def train():
    parser = transformers.HfArgumentParser((ModelArguments, DataArguments, CustomTrainingArguments))
    model_args, data_args, training_args = parser.parse_args_into_dataclasses()

    print(f"Evaluation Strategy (Before Conversion): {training_args.evaluation_strategy} (Type: {type(training_args.evaluation_strategy)})")

    training_args.evaluation_strategy = str(training_args.evaluation_strategy)

    print(f"Evaluation Strategy (After Conversion): {training_args.evaluation_strategy} (Type: {type(training_args.evaluation_strategy)})")

    tokenizer = transformers.AutoTokenizer.from_pretrained(model_args.model_name_or_path, use_fast=True, trust_remote_code=True)

    train_dataset = SupervisedDataset(tokenizer=tokenizer, data_path=os.path.join(data_args.data_path, "train.csv"))
    val_dataset = SupervisedDataset(tokenizer=tokenizer, data_path=os.path.join(data_args.data_path, "dev.csv"))
    test_dataset = SupervisedDataset(tokenizer=tokenizer, data_path=os.path.join(data_args.data_path, "test.csv"))

    data_collator = DataCollatorForSupervisedDataset(tokenizer)

    model = transformers.AutoModelForSequenceClassification.from_pretrained(
        model_args.model_name_or_path, num_labels=1, trust_remote_code=True
    )

    if model_args.use_ia3:
        ia3_config = IA3Config(
            target_modules=[
                "esm.encoder.layer.38.attention.self.query",
                "esm.encoder.layer.38.attention.self.key",
                "esm.encoder.layer.38.attention.self.value",
                "esm.encoder.layer.39.attention.self.query",
                "esm.encoder.layer.39.attention.self.key",
                "esm.encoder.layer.39.attention.self.value",
                
                "esm.encoder.layer.38.intermediate.dense",
                "esm.encoder.layer.38.output.dense",
                "esm.encoder.layer.39.intermediate.dense",
                "esm.encoder.layer.39.output.dense"],
            feedforward_modules=[ 
                "esm.encoder.layer.38.intermediate.dense",
                "esm.encoder.layer.38.output.dense",
                "esm.encoder.layer.39.intermediate.dense",
                "esm.encoder.layer.39.output.dense"],
            task_type="SEQ_CLS")
        model = get_peft_model(model, ia3_config)
        model.print_trainable_parameters()

    trainer = Trainer(
        model=model,
        tokenizer=tokenizer,
        args=training_args,
        compute_metrics=compute_metrics,
        train_dataset=train_dataset,
        eval_dataset=val_dataset,
        data_collator=data_collator,
    )

    trainer.train()

    if training_args.save_model:
        trainer.save_model(training_args.output_dir)

    if training_args.output_dir:
        results = trainer.evaluate(eval_dataset=test_dataset)
        with open(os.path.join(training_args.output_dir, "eval_results.json"), "w") as f:
            json.dump(results, f)

def print_model_layers():

    print('Printing model layers for choice with IA3 ')
    parser = transformers.HfArgumentParser((ModelArguments, DataArguments, CustomTrainingArguments))
    model_args, data_args, training_args = parser.parse_args_into_dataclasses()
    model = transformers.AutoModelForSequenceClassification.from_pretrained(
        model_args.model_name_or_path, num_labels=1, trust_remote_code=True)
    
    for name, module in model.named_modules():
        print(name)

if __name__ == "__main__":
    print_model_layers()
    exit()
    train()

