import pandas as pd
import torch
from torch.utils.data import Dataset
from sklearn.model_selection import train_test_split
from sklearn.metrics import r2_score
from transformers import (
    AutoTokenizer,
    AutoModelForSequenceClassification,
    Trainer,
    TrainingArguments,
)
import argparse
import os
from transformers import EarlyStoppingCallback
import math
import transformers

def load_fasta_sequences(file_path):
    df = pd.read_csv(file_path)
    if 'sequence' not in df.columns or 'label' not in df.columns:
        raise ValueError(f"'sequence' and 'label' columns not found in {file_path}")
    print(f"Loaded {len(df)} sequences from {file_path}")
    return df['sequence'].tolist(), df['label'].tolist()

def load_fasta_sequences_when_plant_genomic_database(fasta_path):
        sequences = []
        labels = []
        with open(fasta_path, "r") as f:
            current_seq = []
            current_label = None
            for line in f:
                line = line.strip()
                if line.startswith(">"):
                    if current_seq and current_label is not None:
                        sequences.append("".join(current_seq))
                        labels.append(current_label)
                        current_seq = []
                    try:
                        current_label = float(line.split("|")[1])
                    except (IndexError, ValueError):
                        current_label = None  # Skip if label malformed
                else:
                    current_seq.append(line.upper())
            # Catch the last entry
            if current_seq and current_label is not None:
                sequences.append("".join(current_seq))
                labels.append(current_label)
        return sequences, labels

def tokenize_non_overlapping(seq):
        # Non-overlapping 6-mers
        k=6
        return [seq[i:i+k] for i in range(0, len(seq), k) if len(seq[i:i+k]) == k]

class SequenceRegressionDataset(Dataset):
        def __init__(self, sequences, labels, tokenizer, non_overlapping_kmers, max_length=1024):
            self.sequences = sequences
            self.labels = labels
            self.tokenizer = tokenizer
            self.max_length = max_length
            self.non_overlapping_kmers = non_overlapping_kmers

        def __len__(self):
            return len(self.sequences)

        def __getitem__(self, idx):
            seq = self.sequences[idx]
            label = self.labels[idx]
            if self.non_overlapping_kmers:
                kmers = tokenize_non_overlapping(seq)

                tokens = self.tokenizer(
                    kmers,
                    is_split_into_words=True,
                    padding="max_length",
                    truncation=True,
                    max_length=self.max_length,
                    return_tensors="pt",)

            else:
                tokens = self.tokenizer(
                    seq,
                    truncation=True,
                    padding="max_length",
                    max_length=self.max_length,
                    return_tensors="pt",
                )

            return {
                "input_ids": tokens["input_ids"].squeeze(0),
                "attention_mask": tokens["attention_mask"].squeeze(0),
                "labels": torch.tensor(label, dtype=torch.float),
            }
        
def compute_metrics(eval_pred):
        preds, labels = eval_pred
        preds = preds.squeeze()
        return {"r2": r2_score(labels, preds)}

def find_longest_sequence(train_seqs, val_seqs, test_seqs):
    all_seqs = train_seqs + val_seqs + test_seqs
    file_labels = ["train"] * len(train_seqs) + ["val"] * len(val_seqs) + ["test"] * len(test_seqs)
    
    max_len = 0
    longest_seq = ""
    source_file = ""

    for seq, label in zip(all_seqs, file_labels):
        if len(seq) > max_len:
            max_len = len(seq)
            longest_seq = seq
            source_file = label

    print(f"\nLongest sequence is from the {source_file} set")
    print(f"Length: {max_len}")

    return max_len 

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--train_fasta_file', type=str, required=True)
    parser.add_argument('--validate_fasta_file', type=str, required=True)
    parser.add_argument('--test_fasta_file', type=str, required=True)
    parser.add_argument('--learning_rate', type=float, default=5e-5)
    parser.add_argument('--batch_size', type=int, default=8)
    parser.add_argument('--num_train_epochs', type=int, default=3)
    parser.add_argument('--output_dir', type=str, default='./agroNT_regression')
    parser.add_argument('--model_name', type=str, default='InstaDeepAI/agro-nucleotide-transformer-1b')
    parser.add_argument('--non_overlapping_kmers', action='store_true')
    parsed_args = parser.parse_args()

    print(f'Script running with the following parameters:\n'
          f'Train file: {parsed_args.train_fasta_file}\n'
          f'Valid file: {parsed_args.validate_fasta_file}\n'
          f'Test file: {parsed_args.test_fasta_file}\n (only for calculating longest sequence ...)\n'
          f'Learning Rate: {parsed_args.learning_rate}\n'
          f'Batch Size: {parsed_args.batch_size}\n'
          f'Number of Training Epochs: {parsed_args.num_train_epochs}\n'
          f'Output Directory: {parsed_args.output_dir}\n'
          f'Model Name: {parsed_args.model_name}\n')

    train_seqs, train_labels = load_fasta_sequences(parsed_args.train_fasta_file)
    val_seqs, val_labels = load_fasta_sequences(parsed_args.validate_fasta_file)
    test_seqs, test_labels = load_fasta_sequences(parsed_args.test_fasta_file)
    max_length = math.ceil((find_longest_sequence(train_seqs, val_seqs, test_seqs) + 1) // 6) if parsed_args.non_overlapping_kmers else 1024
    print(f"Max length for sequences: {max_length}")

    tokenizer = AutoTokenizer.from_pretrained(parsed_args.model_name, trust_remote_code=True)

    train_dataset = SequenceRegressionDataset(train_seqs, train_labels, tokenizer, parsed_args.non_overlapping_kmers, max_length=max_length)
    val_dataset = SequenceRegressionDataset(val_seqs, val_labels, tokenizer, parsed_args.non_overlapping_kmers, max_length=max_length)

    model = AutoModelForSequenceClassification.from_pretrained(
        parsed_args.model_name,
        num_labels=1,
        problem_type="regression",
        trust_remote_code=True)
    
    training_args = TrainingArguments(
        output_dir=parsed_args.output_dir,
        overwrite_output_dir=True,
        do_train=True,
        do_eval=True,
        eval_strategy="epoch", 
        per_device_train_batch_size=parsed_args.batch_size,
        per_device_eval_batch_size=parsed_args.batch_size,
        learning_rate=parsed_args.learning_rate,
        num_train_epochs=parsed_args.num_train_epochs,
        weight_decay=0.01,
        logging_dir="./logs",
        logging_strategy="epoch",         
        logging_steps=500,
        save_strategy="epoch",           
        save_steps=500,
        save_total_limit=3,
        seed=42,
        fp16=True,                        
        metric_for_best_model="r2",
        greater_is_better=True,
        load_best_model_at_end=True,
        logging_first_step=False)

    trainer = Trainer(
        model=model,
        args=training_args,
        train_dataset=train_dataset,
        eval_dataset=val_dataset,
        compute_metrics=compute_metrics,
        callbacks=[EarlyStoppingCallback(early_stopping_patience=3)],
    )

    trainer.train()

    metrics = trainer.evaluate()
    print(f"Validation R²: {metrics['eval_r2']:.4f}")

    best_checkpoint = trainer.state.best_model_checkpoint
    if best_checkpoint is not None:
        print(f"\nSaving best model from: {best_checkpoint}")
        best_model = AutoModelForSequenceClassification.from_pretrained(best_checkpoint)
        save_dir = os.path.join(parsed_args.output_dir, f"best_model_lr{parsed_args.learning_rate}_bs{parsed_args.batch_size}")
        best_model.save_pretrained(save_dir)
        print(f"Best model saved to: {save_dir}")
    else:
        print("No best checkpoint found; skipping model export.")
