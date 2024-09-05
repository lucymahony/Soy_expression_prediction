# This script is mine and loads a pretrained AgroNT model and plots predicted y values against true y values for the validation dataset (dev.csv) that the model was trained with. 

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
from train_ia3_regression import SupervisedDataset, DataCollatorForSupervisedDataset, ModelArguments, DataArguments, TrainingArguments, compute_metrics

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

def plot_predictions_vs_actual(preds, labels):
    """Plot predicted values against actual values."""
    plt.figure(figsize=(10, 6))
    plt.scatter(labels, preds, alpha=0.5, color='blue')
    plt.plot([min(labels), max(labels)], [min(labels), max(labels)], color='red', linestyle='--')
    plt.xlabel('Actual Values')
    plt.ylabel('Predicted Values')
    plt.title('Predicted vs Actual Values')
    plt.grid(True)
    plt.show()


def load_trained_model(model_path, model_args, training_args):
    """Load a trained model from a specified path."""
    print(f"Loading model from {model_path}...")
    model = transformers.AutoModelForSequenceClassification.from_pretrained(
        model_path,
        cache_dir=training_args.cache_dir,
        num_labels=1,  # Assuming regression with 1 output
        trust_remote_code=True,
    )
    return model


def train_or_load_model():
    parser = transformers.HfArgumentParser((ModelArguments, DataArguments, TrainingArguments))
    model_args, data_args, training_args = parser.parse_args_into_dataclasses()

    # Define tokenizer
    tokenizer = transformers.AutoTokenizer.from_pretrained(
        model_args.model_name_or_path,
        cache_dir=training_args.cache_dir,
        model_max_length=training_args.model_max_length,
        padding_side="right",
        use_fast=True,
        trust_remote_code=True,
    )

    # Define datasets and data collator
    train_dataset = SupervisedDataset(tokenizer=tokenizer, 
                                      data_path=os.path.join(data_args.data_path, "train.csv"), 
                                      kmer=data_args.kmer)
    val_dataset = SupervisedDataset(tokenizer=tokenizer, 
                                     data_path=os.path.join(data_args.data_path, "dev.csv"), 
                                     kmer=data_args.kmer)
    data_collator = DataCollatorForSupervisedDataset(tokenizer=tokenizer)

    # Check if a pre-trained model exists
    model_path = training_args.output_dir  # Assuming the model is saved in the output_dir
    if os.path.exists(model_path) and os.listdir(model_path):
        model = load_trained_model(model_path, model_args, training_args)
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
    #plot_predictions_vs_actual(preds, labels)

if __name__ == "__main__":
    train_or_load_model()