# agro_nt_scripts/train_with_ia3.py

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

def model_initialise_ia3(model_name):
    base_model = AutoModelForSequenceClassification.from_pretrained(
        model_name,
        num_labels=1,
        problem_type="regression",
        trust_remote_code=True
    )

    ia3_config = IA3Config(
        task_type=TaskType.SEQ_CLS,
        target_modules=["query", "key", "value", "intermediate.dense", "output.dense"],
        feedforward_modules=["intermediate.dense", "output.dense"],
    )
    print("\nIA3 configuration:")
    print(ia3_config)

    model = get_peft_model(base_model, ia3_config)
    model.print_trainable_parameters()
    return model

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--train_fasta_file', type=str, required=True)
    parser.add_argument('--validate_fasta_file', type=str, required=True)
    parser.add_argument('--test_fasta_file', type=str, required=True)
    parser.add_argument('--learning_rate', type=float, default=3e-6)
    parser.add_argument('--batch_size', type=int, default=8)
    parser.add_argument('--num_train_epochs', type=int, default=3)
    parser.add_argument('--output_dir', type=str, default='./agroNT_regression')
    parser.add_argument('--model_name', type=str, default='InstaDeepAI/agro-nucleotide-transformer-1b')
    parser.add_argument('--non_overlapping_kmers', type=str, choices=['true', 'false'], default='true', help='Use non-overlapping k-mers (true or false). Default is true.')
    parser.add_argument('--logging_dir', type=str, default='/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/logs')
    parser.add_argument('--k_folds', type=int, default=1, help="Number of folds for cross-validation. Default is 1 (no CV)")
    parser.add_argument('--weight_decay',type=float, default=0)
    args = parser.parse_args()
    args.non_overlapping_kmers = args.non_overlapping_kmers.lower() == 'true' # convert to bool
    if args.non_overlapping_kmers:
        print('Using non-overlapping Kmers')
    else:
        print('Overlapping Kmers')

    print("\n========== CONFIG ==========")
    print(vars(args))
    print("============================\n")

    train_seqs, train_labels = load_fasta_sequences(args.train_fasta_file)
    val_seqs, val_labels = load_fasta_sequences(args.validate_fasta_file)
    test_seqs, _ = load_fasta_sequences(args.test_fasta_file)

    max_length = math.ceil((find_longest_sequence(train_seqs, val_seqs, test_seqs) + 1) / 6) \
        if args.non_overlapping_kmers else 1024
    print(f"Max token length: {max_length}")

    tokenizer = AutoTokenizer.from_pretrained(args.model_name, trust_remote_code=True)

    
    if args.k_folds > 1:
        cross_validate(
            model_init_fn=lambda: model_initialise_ia3(args.model_name),
            sequences=train_seqs,
            labels=train_labels,
            tokenizer=tokenizer,
            args=args,
            k_folds=args.k_folds,
            use_kmers=args.non_overlapping_kmers,
            max_length=max_length,
        )
    else:

        train_dataset = SequenceRegressionDataset(train_seqs, train_labels, tokenizer, args.non_overlapping_kmers, max_length)
        val_dataset = SequenceRegressionDataset(val_seqs, val_labels, tokenizer, args.non_overlapping_kmers, max_length)


        model = model_initialise_ia3(args.model_name)
        training_args = build_training_arguments(args)
        trainer = build_trainer(model, training_args, train_dataset, val_dataset, compute_metrics)

        trainer.train()
        metrics = trainer.evaluate()
        print(f"\nFinal validation R²: {metrics['eval_r2']:.4f}")

        best_checkpoint = trainer.state.best_model_checkpoint
        

        if best_checkpoint:
            final_model_path=os.path.join(args.output_dir, f"best_model_lr{args.learning_rate}_bs{args.batch_size}")
            print(f"\nSaving best model from: {best_checkpoint}")
            model.save_pretrained(final_model_path)
            # Merge adapter with base model and save full model
            print("Merging adapter weights into base model...")
            final_model_path_merged=os.path.join(final_model_path, 'merged_to_full')
            merged_model = model.merge_and_unload()
            merged_model.save_pretrained(final_model_path_merged)
            tokenizer.save_pretrained(final_model_path_merged)
            print(f"Saved full model to {final_model_path_merged}")
        else:
            print("No best checkpoint found, skipping save.")