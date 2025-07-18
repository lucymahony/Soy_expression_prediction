import pandas as pd
import torch
from torch.utils.data import Dataset
from sklearn.metrics import r2_score

import numpy as np
from sklearn.model_selection import KFold
import random
import time 
import os

from transformers import TrainingArguments, Trainer, EarlyStoppingCallback
import os


def load_fasta_sequences(file_path, max_nt_length=6000):
    """
    Max length 6000 is required for agroNT  compatibility.
    """
    df = pd.read_csv(file_path)
    if 'sequence' not in df.columns or 'label' not in df.columns:
        raise ValueError(f"'sequence' and 'label' columns not found in {file_path}")
    
    sequences = []
    labels = []
    truncated_count = 0

    for seq, label in zip(df['sequence'], df['label']):
        if len(seq) > max_nt_length:
            truncated_count += 1
            seq = seq[:max_nt_length]
        sequences.append(seq)
        labels.append(label)
    
    print(f"Loaded {len(sequences)} sequences from {file_path}")
    if truncated_count > 0:
        print(f"Truncated {truncated_count} sequences longer than {max_nt_length} nt")
    return sequences, labels


def tokenize_non_overlapping(seq, k=6):
    return [seq[i:i+k] for i in range(0, len(seq), k) if len(seq[i:i+k]) == k]


class SequenceRegressionDataset(Dataset):
    def __init__(self, sequences, labels, tokenizer, use_kmers=False, max_length=1024):
        self.sequences = sequences
        self.labels = labels
        self.tokenizer = tokenizer
        self.max_length = max_length
        self.use_kmers = use_kmers

    def __len__(self):
        return len(self.sequences)

    def __getitem__(self, idx):
        seq = self.sequences[idx]
        label = self.labels[idx]

        if self.use_kmers:
            kmers = tokenize_non_overlapping(seq)
            tokens = self.tokenizer(
                kmers,
                is_split_into_words=True,
                padding="max_length",
                truncation=True,
                max_length=self.max_length,
                return_tensors="pt")
        else:
            tokens = self.tokenizer(
                seq,
                padding="max_length",
                truncation=True,
                max_length=self.max_length,
                return_tensors="pt")

        return {
            "input_ids": tokens["input_ids"].squeeze(0),
            "attention_mask": tokens["attention_mask"].squeeze(0),
            "labels": torch.tensor(label, dtype=torch.float),
        }

def find_longest_sequence(*sequence_lists):
    all_seqs = [seq for sublist in sequence_lists for seq in sublist]
    max_len = max(len(seq) for seq in all_seqs)
    print(f"Longest sequence length: {max_len}")
    return max_len

def compute_metrics(eval_pred):
    preds, labels = eval_pred
    preds = preds.squeeze()
    return {"r2": r2_score(labels, preds)}


def build_training_arguments(args, output_dir_suffix=""):
    output_path = os.path.join(args.output_dir, output_dir_suffix) if output_dir_suffix else args.output_dir
    return TrainingArguments(
        output_dir=output_path,
        overwrite_output_dir=True,
        do_train=True,
        do_eval=True,
        eval_strategy="epoch",
        per_device_train_batch_size=args.batch_size,
        per_device_eval_batch_size=args.batch_size,
        learning_rate=args.learning_rate,
        num_train_epochs=args.num_train_epochs,
        weight_decay=args.weight_decay,
        logging_dir=args.logging_dir,
        logging_strategy="epoch",
        save_strategy="epoch",
        save_total_limit=2,
        seed=42,
        fp16=True,
        metric_for_best_model="r2",
        greater_is_better=True,
        load_best_model_at_end=True
    )

def build_trainer(model, training_args, train_dataset, val_dataset, compute_metrics_fn, early_stopping=True):
    callbacks = [EarlyStoppingCallback(early_stopping_patience=3)] if early_stopping else []
    return Trainer(
        model=model,
        args=training_args,
        train_dataset=train_dataset,
        eval_dataset=val_dataset,
        compute_metrics=compute_metrics_fn,
        callbacks=callbacks,
    )

def set_global_seed(seed: int = 42):
    torch.manual_seed(seed)
    torch.cuda.manual_seed_all(seed)
    np.random.seed(seed)
    random.seed(seed)

def cross_validate(model_init_fn, sequences, labels, tokenizer, args, k_folds=5, use_kmers=False, max_length=1024, early_stopping=True, seed=42):
    """
    Note make sure a new model instance is passed in. 
    """

    set_global_seed(seed)
    kf = KFold(n_splits=k_folds, shuffle=True, random_state=seed)
    all_metrics = []
    log_dir = args.logging_dir
    os.makedirs(log_dir, exist_ok=True)
    log_path = os.path.join(log_dir, "cv_fold_metrics.log")
    with open(log_path, "w") as f:
        f.write("fold\tr2\truntime_sec\tgpu_mem_mb\n")

    for fold, (train_idx, val_idx) in enumerate(kf.split(sequences)):
        print(f"\n--- Fold {fold + 1}/{k_folds} ---")

        train_seqs = [sequences[i] for i in train_idx]
        train_labels = [labels[i] for i in train_idx]
        val_seqs = [sequences[i] for i in val_idx]
        val_labels = [labels[i] for i in val_idx]

        train_dataset = SequenceRegressionDataset(train_seqs, train_labels, tokenizer, use_kmers, max_length)
        val_dataset = SequenceRegressionDataset(val_seqs, val_labels, tokenizer, use_kmers, max_length)

        fold_args = build_training_arguments(args, output_dir_suffix=f"fold_{fold + 1}")
        model = model_init_fn()

        trainer = build_trainer(model, fold_args, train_dataset, val_dataset, compute_metrics, early_stopping)

        torch.cuda.reset_peak_memory_stats()
        start_time = time.time()
        trainer.train()

        elapsed = time.time() - start_time
        mem_mb = torch.cuda.max_memory_allocated() / 1024**2  # MiB


        metrics = trainer.evaluate()
        r2 = metrics.get("eval_r2", float("nan"))
        all_metrics.append(metrics)
        print(f"Fold {fold + 1} R²: {metrics['eval_r2']:.4f}")
        print(f"Fold {fold + 1} R²: {r2:.4f}, time: {elapsed:.1f}s, GPU mem: {mem_mb:.0f} MiB")

        with open(log_path, "a") as f:
            f.write(f"{fold+1}\t{r2:.4f}\t{elapsed:.1f}\t{mem_mb:.0f}\n")


    r2_scores = [m['eval_r2'] for m in all_metrics]
    print(f"\nMean R² over {k_folds} folds: {np.mean(r2_scores):.4f} ± {np.std(r2_scores):.4f}")
    return all_metrics
