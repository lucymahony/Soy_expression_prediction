import os
import json
import pandas as pd
import numpy as np
import torch
from torch.utils.data import Dataset
from dataclasses import dataclass, field
from typing import Optional
from transformers import (
    AutoModel, AutoTokenizer, TrainingArguments, Trainer,
    EarlyStoppingCallback, HfArgumentParser
)
from sklearn.metrics import mean_squared_error, r2_score
from peft import LoraConfig, get_peft_model
import torch.nn as nn

@dataclass
class ModelArguments:
    model_name_or_path: str = field(metadata={"help": "Path to pretrained AgroNT model"})
    use_lora: bool = field(default=True)
    lora_r: int = field(default=8)
    lora_alpha: int = field(default=16)
    lora_dropout: float = field(default=0.1)
    lora_target_modules : str = field(default="query,value", metadata={"help": "where to perform LoRA"})


@dataclass
class DataArguments:
    data_path: str = field(metadata={"help": "Directory containing train.csv, dev.csv, and test.csv"})



@dataclass
class ExtendedTrainingArguments(TrainingArguments):
    run_name: Optional[str] = field(default="run")
    model_max_length: int = field(default=1024)
    # For early stopping to work correctly
    evaluation_strategy: str = field(default="epoch")
    save_strategy: str = field(default="epoch")
    load_best_model_at_end: bool = field(default=True)
    metric_for_best_model: str = field(default="eval_loss")
    greater_is_better: bool = field(default=False)



class AgroNTRegression(nn.Module):
    def __init__(self, model_name, use_lora=False, lora_config=None):
        super().__init__()
        model = AutoModel.from_pretrained(model_name, output_hidden_states=True)
        if use_lora and lora_config:
            model = get_peft_model(model, lora_config)

        self.backbone = model
        hidden_size = model.base_model.config.hidden_size if hasattr(model, "base_model") else model.config.hidden_size
        self.reg_head = nn.Linear(hidden_size, 1)
        self.config = model.base_model.config if hasattr(model, "base_model") else model.config

    def forward(self, input_ids=None, attention_mask=None, labels=None, **kwargs):
        # Filter out unsupported keys
        outputs = self.backbone(input_ids=input_ids, attention_mask=attention_mask)
        cls_emb = outputs.hidden_states[-1][:, 0, :]
        preds = self.reg_head(cls_emb).squeeze(-1)

        loss = nn.functional.mse_loss(preds, labels) if labels is not None else None
        return {"loss": loss, "logits": preds}

class SupervisedAgroNTDataset(Dataset):
    def __init__(self, csv_path, tokenizer, max_length):
        df = pd.read_csv(csv_path)
        # sequence,label
        self.labels = df["label"].values.astype(np.float32)
        sequences = df["sequence"].tolist()
        encodings = tokenizer(sequences, truncation=True, padding="max_length", max_length=max_length)
        self.input_ids = encodings["input_ids"]
        self.attention_mask = encodings["attention_mask"]

    def __len__(self):
        return len(self.labels)

    def __getitem__(self, idx):
        return {
            "input_ids": torch.tensor(self.input_ids[idx]),
            "attention_mask": torch.tensor(self.attention_mask[idx]),
            "labels": torch.tensor(self.labels[idx]),
        }


def compute_metrics(eval_pred):
    preds, labels = eval_pred
    preds = preds.flatten()
    labels = labels.flatten()
    mse = mean_squared_error(labels, preds)
    rmse = np.sqrt(mse)
    r2 = r2_score(labels, preds)
    return {"mse": mse, "rmse": rmse, "r2": r2}


def main():
    parser = HfArgumentParser((ModelArguments, DataArguments, ExtendedTrainingArguments))
    model_args, data_args, training_args = parser.parse_args_into_dataclasses()
    

    tokenizer = AutoTokenizer.from_pretrained(model_args.model_name_or_path)

    train_path = os.path.join(data_args.data_path, "train.csv")
    val_path = os.path.join(data_args.data_path, "dev.csv")
    test_path = os.path.join(data_args.data_path, "test.csv")

    train_ds = SupervisedAgroNTDataset(train_path, tokenizer, training_args.model_max_length)
    val_ds = SupervisedAgroNTDataset(val_path, tokenizer, training_args.model_max_length)
    test_ds = SupervisedAgroNTDataset(test_path, tokenizer, training_args.model_max_length)

    # configure LoRA
    lora_config = LoraConfig(
            r=model_args.lora_r,
            lora_alpha=model_args.lora_alpha,
            target_modules=list(model_args.lora_target_modules.split(",")),
            lora_dropout=model_args.lora_dropout,
            bias="none",
            task_type="SEQ_CLS",
            inference_mode=False,
        )
    
    model = AgroNTRegression(model_args.model_name_or_path, use_lora=model_args.use_lora, lora_config=lora_config)
    model = get_peft_model(model, lora_config)
    model.print_trainable_parameters()

    trainer = Trainer(
        model=model,
        args=training_args,
        tokenizer=tokenizer,
        train_dataset=train_ds,
        eval_dataset=val_ds,
        compute_metrics=compute_metrics,
        callbacks=[EarlyStoppingCallback(early_stopping_patience=3)],
    )

    trainer.train()

    pd.DataFrame(trainer.state.log_history).to_csv(os.path.join(training_args.output_dir, "training_log.csv"), index=False)

    preds = trainer.predict(test_ds)
    test_df = pd.read_csv(test_path)
    test_df["predicted_expression"] = preds.predictions.flatten()
    test_df.to_csv(os.path.join(training_args.output_dir, "test_predictions.csv"), index=False)


if __name__ == "__main__":
    print('Starting train_lora_regression script')
    main()

