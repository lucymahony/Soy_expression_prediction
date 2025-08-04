import os
import math
import argparse
from transformers import AutoTokenizer, AutoModelForSequenceClassification
from peft import IA3Config, get_peft_model, TaskType
from utils import (
    load_fasta_sequences,
    find_longest_sequence,
    SequenceRegressionDataset,
    compute_metrics,
    build_training_arguments,
    build_trainer,
    cross_validate,
)
from agront_train_ia3 import model_initialise_ia3
import matplotlib.pyplot as plt
from peft import PeftModel
import pandas as pd
from sklearn.metrics import r2_score


def load_peft_model(model_path, base_model_name):
    """Load  PEFT adapter weights -EITHER Lora or IA3"""
    print(f"Loading base model from: {base_model_name}")
    model = AutoModelForSequenceClassification.from_pretrained(
        base_model_name,
        num_labels=1,
        trust_remote_code=True
    )
    print(f"Loading from: {model_path}")
    model = PeftModel.from_pretrained(model, model_path)
    return model



def save_predictions(trainer, eval_dataset, output_dir):
    """Save model predictions and actual values."""
    predictions = trainer.predict(eval_dataset)
    preds = predictions.predictions.flatten()
    labels = predictions.label_ids.flatten()
    r2 = r2_score(labels, preds)
    print(f'R2 = {r2}')
    df = pd.DataFrame({"Actual": labels, "Predicted": preds})
    df.to_csv(os.path.join(output_dir, "predictions.csv"), index=False)
    return preds, labels

def plot_predictions_vs_actual(preds, labels, output_dir):
    """Scatter plot of predicted vs actual."""
    plt.figure(figsize=(7, 6))
    plt.scatter(labels, preds,  color='#8a3ffc')
    plt.plot([min(labels), max(labels)], [min(labels), max(labels)], color='#da1e28', linestyle='--')
    plt.xlabel('Actual Values')
    plt.ylabel('Predicted Values')
    plt.title('Predicted vs Actual Values')

    plt.tight_layout()
    plt.savefig(os.path.join(output_dir, "prediction_plot.png"), dpi=300)
    print(f"Saved plot to: {output_dir}/prediction_plot.png")

def parse_args():
    parser = argparse.ArgumentParser(description="Run predictions with fine-tuned  model")
    parser.add_argument("--base_model", type=str, required=True, help="Path to base pretrained AgroNT model")
    parser.add_argument("--trained_model", type=str, required=True, help="Path to fine-tuned adapter directory -either lora or ia3")
    parser.add_argument("--validate_fasta_file", type=str, required=True, help="Path to validate_fasta_file ")
    parser.add_argument("--train_fasta_file", type=str, required=True)
    parser.add_argument("--test_fasta_file", type=str, required=True)
    parser.add_argument("--output_dir", type=str, required=True, help="Where to save predictions and plots")
    parser.add_argument('--non_overlapping_kmers', type=str, choices=['true', 'false'], default='true', help='Use non-overlapping k-mers (true or false). Default is true.')
    parser.add_argument('--batch_size', type=int, default=8, help='Batch size for inference')
    parser.add_argument('--learning_rate', type=float, default=3e-4)
    parser.add_argument('--num_train_epochs', type=int, default=3)
    parser.add_argument('--weight_decay', type=float, default=0.1)
    parser.add_argument('--logging_dir')
    return parser.parse_args()

def main():
    args = parse_args()
    train_seqs, train_labels = load_fasta_sequences(args.train_fasta_file)
    val_seqs, val_labels = load_fasta_sequences(args.validate_fasta_file)
    test_seqs, test_labels = load_fasta_sequences(args.test_fasta_file)
    max_length = math.ceil((find_longest_sequence(train_seqs, val_seqs, test_seqs) + 1) / 6) \
        if args.non_overlapping_kmers == 'true' else 1024
    print(f"Max token length: {max_length}")
    tokenizer = AutoTokenizer.from_pretrained(args.base_model, trust_remote_code=True)
    test_dataset = SequenceRegressionDataset(
        test_seqs,
        test_labels,
        tokenizer,
        args.non_overlapping_kmers == 'true',
        max_length
    )
    # Load model (PEFT = LoRA or IA3)
    model = load_peft_model(model_path=args.trained_model, base_model_name=args.base_model)
    
    training_args = build_training_arguments(args)
    train_dataset = SequenceRegressionDataset(
        train_seqs,
        train_labels,
        tokenizer,
        args.non_overlapping_kmers == 'true',
        max_length
    )

    # Build trainer
    trainer = build_trainer(model, training_args, train_dataset, test_dataset, compute_metrics)

    # Run predictions on the test set
    preds, labels = save_predictions(trainer, test_dataset, args.output_dir)
    plot_predictions_vs_actual(preds, labels, args.output_dir)

if __name__ == "__main__":
    main()
        