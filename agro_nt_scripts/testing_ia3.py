import os
import torch
import argparse
import pandas as pd
import math
from sklearn.metrics import r2_score
from torch.utils.data import Dataset
from transformers import (
    AutoTokenizer,
    AutoModelForSequenceClassification,
    Trainer,
    TrainingArguments,
    EarlyStoppingCallback
)
from peft import IA3Config, get_peft_model, TaskType

# ---------- Data Loading ----------

def load_fasta_sequences(file_path, max_nt_length=6000):
    df = pd.read_csv(file_path)
    if 'sequence' not in df.columns or 'label' not in df.columns:
        raise ValueError(f"'sequence' and 'label' columns not found in {file_path}")
    
    sequences = []
    truncated_count = 0
    for seq in df['sequence']:
        if len(seq) > max_nt_length:
            truncated_count += 1
            seq = seq[:max_nt_length]
        sequences.append(seq)
    
    print(f"Loaded {len(sequences)} sequences from {file_path}")
    if truncated_count > 0:
        print(f"Truncated {truncated_count} sequences longer than {max_nt_length} nt")
    return sequences, df['label'].tolist()

def tokenize_non_overlapping(seq):
    k = 6
    return [seq[i:i+k] for i in range(0, len(seq), k) if len(seq[i:i+k]) == k]

# ---------- Dataset ----------

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
            tokens = self.tokenizer(kmers, is_split_into_words=True, padding="max_length", truncation=True,
                                    max_length=self.max_length, return_tensors="pt")
        else:
            tokens = self.tokenizer(seq, truncation=True, padding="max_length",
                                    max_length=self.max_length, return_tensors="pt")
        return {
            "input_ids": tokens["input_ids"].squeeze(0),
            "attention_mask": tokens["attention_mask"].squeeze(0),
            "labels": torch.tensor(label, dtype=torch.float),
        }

# ---------- Metrics ----------

def compute_metrics(eval_pred):
    preds, labels = eval_pred
    preds = preds.squeeze()
    return {"r2": r2_score(labels, preds)}

# ---------- Helper ----------

def find_longest_sequence(train_seqs, val_seqs, test_seqs):
    all_seqs = train_seqs + val_seqs + test_seqs
    max_len = max(len(seq) for seq in all_seqs)
    print(f"\nLongest sequence length: {max_len}")
    return max_len

# ---------- Main ----------

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
    parser.add_argument('--use_ia3', action='store_true', help='Enable IA3 fine-tuning via PEFT')
    args = parser.parse_args()

    print("\n========== CONFIG ==========")
    print(vars(args))
    print("============================\n")

    train_seqs, train_labels = load_fasta_sequences(args.train_fasta_file)
    val_seqs, val_labels = load_fasta_sequences(args.validate_fasta_file)
    test_seqs, test_labels = load_fasta_sequences(args.test_fasta_file)

    max_length = math.ceil((find_longest_sequence(train_seqs, val_seqs, test_seqs) + 1) / 6) \
        if args.non_overlapping_kmers else 1024
    print(f"Max token length: {max_length}")

    tokenizer = AutoTokenizer.from_pretrained(args.model_name, trust_remote_code=True)
    train_dataset = SequenceRegressionDataset(train_seqs, train_labels, tokenizer, args.non_overlapping_kmers, max_length)
    val_dataset = SequenceRegressionDataset(val_seqs, val_labels, tokenizer, args.non_overlapping_kmers, max_length)

    base_model = AutoModelForSequenceClassification.from_pretrained(
        args.model_name,
        num_labels=1,
        problem_type="regression",
        trust_remote_code=True
    )

    if args.use_ia3:
        ia3_config = IA3Config(
            task_type=TaskType.SEQ_CLS,
            target_modules=["query", "key", "value", "intermediate.dense", "output.dense"],
            feedforward_modules=["intermediate.dense", "output.dense"],)

        print("\nIA3 configuration:")
        print(ia3_config)

        #print("\nModel submodules:")
        #for name, module in base_model.named_modules():
        #    print(name)
        model = get_peft_model(base_model, ia3_config)
        model.print_trainable_parameters()
    else:
        model = base_model

    training_args = TrainingArguments(
        output_dir=args.output_dir,
        overwrite_output_dir=True,
        do_train=True,
        do_eval=True,
        eval_strategy="epoch",
        per_device_train_batch_size=args.batch_size,
        per_device_eval_batch_size=args.batch_size,
        learning_rate=args.learning_rate,
        num_train_epochs=args.num_train_epochs,
        weight_decay=0.01,
        logging_dir="./logs",
        logging_strategy="epoch",
        save_strategy="epoch",
        save_total_limit=2,
        seed=42,
        fp16=True,
        metric_for_best_model="r2",
        greater_is_better=True,
        load_best_model_at_end=True
    )

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
    print(f"\nFinal validation R²: {metrics['eval_r2']:.4f}")

    best_checkpoint = trainer.state.best_model_checkpoint
    if best_checkpoint:
        print(f"\nSaving best model from: {best_checkpoint}")
        model.save_pretrained(os.path.join(
            args.output_dir,
            f"best_model_lr{args.learning_rate}_bs{args.batch_size}"
        ))
    else:
        print("No best checkpoint found, skipping save.")

