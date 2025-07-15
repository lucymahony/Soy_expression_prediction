# Optimized global_analysis_of_TFBS.py
import argparse
from extracting_final_layer_attention import load_model_and_tokenizer, map_attention_to_bases
import matplotlib.pyplot as plt
import numpy as np
from collections import Counter
from scipy.stats import binomtest
import torch
from torch.utils.data import Dataset, DataLoader
from tqdm import tqdm
import os

print("Script started", flush=True)

# === Argument Parser ===
def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--model', type=str, default='', help='Path to the model directory')
    parser.add_argument('--base_model', type=str, default='/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b', help='Tokenizer base model')
    parser.add_argument('--output_path', type=str, default='', help='Path to save results CSV')
    parser.add_argument('--output_dir', type=str, default='seq_outputs', help='Directory to save per-sequence CSVs')
    parser.add_argument('--kmer', type=int, default=6, help='k-mer size (default: 6)')
    parser.add_argument('--sequence_file', type=str, help='Plain sequence file')
    parser.add_argument('--sequence_fasta_file', type=str, help='FASTA format sequence file')
    parser.add_argument('--batch_size', type=int, default=32, help='Batch size for processing')
    return parser.parse_args()

# === Dataset and Tokenization ===
def read_fasta(file_path):
    sequences = []
    with open(file_path, 'r') as f:
        current_seq = ""
        for line in f:
            line = line.strip()
            if line.startswith(">"):
                if current_seq:
                    sequences.append(current_seq.upper())
                    current_seq = ""
            else:
                current_seq += line
        if current_seq:
            sequences.append(current_seq.upper())
    return sequences

def sanitize_filename(seq):
    return "seq_" + str(abs(hash(seq))) + ".csv"

def tokenize_non_overlapping(seq, k=6):
    return [seq[i:i+k] for i in range(0, len(seq), k) if len(seq[i:i+k]) == k]

class SequenceDataset(Dataset):
    def __init__(self, sequences, tokenizer, kmer):
        self.kmer = kmer
        self.tokenizer = tokenizer
        self.tokens = [tokenize_non_overlapping(seq, k=kmer) for seq in sequences]
        self.sequences = sequences

    def __len__(self):
        return len(self.sequences)

    def __getitem__(self, idx):
        return self.tokens[idx], self.sequences[idx]

# === Attention Processing ===
def batch_attention_analysis(dataloader, model, tokenizer, kmer, output_path, output_dir):
    model.eval()
    all_attn_matrices = []
    all_seqs = []
    lines = ["Sequence,Attention_score"]

    os.makedirs(output_dir, exist_ok=True)

    for kmers_batch, seqs_batch in tqdm(dataloader, desc="Processing sequences", unit="batch"):
        inputs = tokenizer(kmers_batch, is_split_into_words=True, return_tensors="pt",
                          padding="max_length", truncation=True,
                          max_length=tokenizer.model_max_length)
        inputs = {k: v.to(model.device) for k, v in inputs.items()}

        with torch.no_grad():
            outputs = model(**inputs, output_attentions=True)

        final_layer_attn = outputs.attentions[-1].mean(dim=1)  # [batch, seq_len, seq_len]
        for i in range(len(seqs_batch)):
            attn_vector = final_layer_attn[i].mean(dim=0)
            tokens = tokenizer.convert_ids_to_tokens(inputs["input_ids"][i].tolist())
            if tokens[0].lower() == "<cls>":
                attn_vector = attn_vector[1:]

            base_attn = map_attention_to_bases(attn_vector.cpu(), len(seqs_batch[i]), kmer)
            all_attn_matrices.append(base_attn)
            all_seqs.append(seqs_batch[i])
            attn_str = ",".join([f"{x:.4f}" for x in base_attn])
            lines.append(f"{seqs_batch[i]},{attn_str}")

            # Write individual CSV
            out_file = os.path.join(output_dir, sanitize_filename(seqs_batch[i]))
            with open(out_file, 'w') as indiv_f:
                indiv_f.write("Base,Attention\n")
                for pos, score in enumerate(base_attn):
                    indiv_f.write(f"{pos},{score:.4f}\n")

    with open(output_path, 'w') as f:
        f.write("\n".join(lines))

    return all_attn_matrices, all_seqs

# === Analysis ===
def location_above_threshold(attn_matrix, threshold=0.5):
    return [i for i, score in enumerate(attn_matrix) if score > threshold]

def locations_multiple_sequences(attn_matrices, threshold=0.5):
    return [location_above_threshold(m, threshold) for m in attn_matrices]

def plot_locations(locations, output_file_path):
    all_positions = [pos for loc in locations for pos in loc]
    if not all_positions:
        print("No high-attention positions above threshold.")
        return
    counts = [0] * (max(all_positions) + 1)
    for pos in all_positions:
        counts[pos] += 1

    plt.figure(figsize=(10, 6))
    plt.plot(range(len(counts)), counts)
    plt.xlabel('Base Position')
    plt.ylabel('High-Attention Count')
    plt.grid(True)
    plt.tight_layout()
    plt.savefig(output_file_path)
    plt.close()

# === Main ===
def main():
    args = parse_args()
    model, tokenizer = load_model_and_tokenizer(args.model, args.base_model)
    model.eval()

    if args.sequence_file:
        with open(args.sequence_file) as f:
            sequences = [line.strip() for line in f if line.strip()]
    elif args.sequence_fasta_file:
        sequences = read_fasta(args.sequence_fasta_file)
    else:
        sequences = ["ACGTACGT", "TTTTGGGG"]

    dataset = SequenceDataset(sequences, tokenizer, args.kmer)
    dataloader = DataLoader(dataset, batch_size=args.batch_size, shuffle=False, collate_fn=lambda x: list(zip(*x)))

    attn_matrices, _ = batch_attention_analysis(dataloader, model, tokenizer, args.kmer, args.output_path, args.output_dir)
    locations = locations_multiple_sequences(attn_matrices, threshold=0.0717)
    plot_locations(locations, 'test_histogram.png')

if __name__ == "__main__":
    main()

