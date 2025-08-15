import argparse
import matplotlib.pyplot as plt
import numpy as np
from collections import Counter
from scipy.stats import binomtest
import torch
import pandas as pd 
from extracting_final_layer_attention import load_model_and_tokenizer, map_attention_to_bases

print("Script started", flush=True)


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--model', type=str, required=True, help='Path to the model directory')
    parser.add_argument('--base_model', type=str, default='/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b')
    parser.add_argument('--output_path', type=str, required=True, help='Path to save the attention scores')
    parser.add_argument('--kmer', type=int, default=6, help='k-mer size (default: 6)')
    parser.add_argument('--sequence_file', type=str, help='Path to a text or .csv file of sequences')
    parser.add_argument('--sequence_fasta_file', type=str, help='Path to a FASTA file of sequences')
    return parser.parse_args()


def read_sequences(sequence_file):
    sequences = []
    with open(sequence_file, 'r') as f:
        header = f.readline()  # skip header
        for line in f:
            line = line.strip()
            if not line:
                continue
            parts = line.split(',')
            if len(parts) >= 1:
                sequences.append(parts[0].strip())
    return sequences


def read_fasta(file_path):
    sequences = []
    with open(file_path, 'r') as f:
        current_seq = ""
        for line in f:
            line = line.strip()
            if not line:
                continue
            if line.startswith(">"):
                if current_seq:
                    sequences.append(current_seq)
                    current_seq = ""
            else:
                current_seq += line.upper()
        if current_seq:
            sequences.append(current_seq)
    return sequences


def tokenize_non_overlapping(seq, k=6):
    return [seq[i:i+k] for i in range(0, len(seq), k) if len(seq[i:i+k]) == k]


def batch_attention(sequences, model, tokenizer, kmer=6, batch_size=32):
    all_base_attn = []

    for i in range(0, len(sequences), batch_size):
        batch_seqs = sequences[i:i+batch_size]
        batch_kmers = [tokenize_non_overlapping(seq, k=kmer) for seq in batch_seqs]

        inputs = tokenizer(
            batch_kmers,
            is_split_into_words=True,
            return_tensors="pt",
            padding="max_length",
            truncation=True,
            max_length=tokenizer.model_max_length
        )
        inputs = {k: v.to(model.device) for k, v in inputs.items()}

        with torch.no_grad():
            outputs = model(**inputs)

        final_layer_attn = outputs.attentions[-1]  # [B, heads, T, T]
        avg_attn = final_layer_attn.mean(dim=1).mean(dim=1)  # [B, T]

        for seq, attn_scores in zip(batch_seqs, avg_attn):
            base_attn = map_attention_to_bases(attn_scores[1:].cpu(), len(seq), kmer)

            all_base_attn.append(base_attn)

    return all_base_attn


def write_attention_output(sequences, attn_matrices, output_file_path):
    with open(output_file_path, 'w') as f:
        f.write("Sequence,Attention_score\n")
        for seq, attn in zip(sequences, attn_matrices):
            attn_str = ",".join(f"{x:.4f}" for x in attn)
            f.write(f"{seq},{attn_str}\n")
    print(f"Attention scores written to {output_file_path}")

def read_attention_output(file_path):
    df = pd.read_csv(file_path, skiprows=1, sep=',')
    sequences = df.iloc[:, 0].astype(str).tolist()
    attn_matrices = df.iloc[:, 1:].astype(float).values.tolist()
    attn_matrices = [matrix[1:6001] for matrix in attn_matrices]

    return sequences, attn_matrices



def location_above_threshold(attn_matrix, threshold=0.5):
    return [i for i, score in enumerate(attn_matrix) if score > threshold]


def locations_multiple_sequences(attn_matrices, threshold=0.5):
    return [location_above_threshold(attn, threshold) for attn in attn_matrices]


def plot_locations(locations, output_file_path):
    all_locations = [pos for seq_locs in locations for pos in seq_locs]
    if not all_locations:
        print("No attention locations above threshold.")
        return

    max_pos = max(all_locations)
    counts = [0] * (max_pos + 1)
    for pos in all_locations:
        counts[pos] += 1

    plt.figure(figsize=(10, 6))
    plt.plot(range(len(counts)), counts)
    plt.xlabel('Base Position')
    plt.ylabel('Count of High-Attention Scores')
    plt.title('Attention Hotspots')
    plt.grid(True)
    plt.tight_layout()
    plt.savefig(output_file_path)
    plt.close()
    print(f"Location plot saved to {output_file_path}")


def get_sequences_above_threshold(sequences, attn_matrices, threshold=0.5):
    result = []
    for seq, attn in zip(sequences, attn_matrices):
        blocks = []
        current = ""
        for base, score in zip(seq, attn):
            if score > threshold:
                current += base
            elif current:
                blocks.append(current)
                current = ""
        if current:
            blocks.append(current)
        result.append(blocks)
    return result


def find_enriched_kmers_2(kmers, alpha=0.05):
    total_kmers = len(kmers)
    expected_p = 1 / (4 ** 6)
    kmer_counts = Counter(kmers)
    enriched = []
    for kmer, count in kmer_counts.items():
        result = binomtest(count, total_kmers, expected_p, alternative='greater')
        if result.pvalue < alpha:
            enriched.append((kmer, count, total_kmers * expected_p, result.pvalue))
    return sorted(enriched, key=lambda x: x[3])


def test_get_sequences_above_threshold():
    sequences = ["ACGTACGT", "TTTTGGGG"]
    attn = [
        [0.1, 0.2, 0.6, 0.7, 0.3, 0.4, 0.1, 0.0],
        [0.8, 0.9, 0.1, 0.0, 0.6, 0.6, 0.0, 0.2],
    ]
    expected = [["GT"], ["TT", "GG"]]
    result = get_sequences_above_threshold(sequences, attn, threshold=0.5)
    if result == expected:
        print("Test passed!")
    else:
        print(f"Test failed: expected {expected}, got {result}")
    return result == expected


def main():
    if args.sequence_file:
        sequences = read_sequences(args.sequence_file)
    elif args.sequence_fasta_file:
        sequences = read_fasta(args.sequence_fasta_file)
    else:
        sequences = ["ACGTACGT", "TTTTGGGG"]

    print(f"There are {len(sequences)} sequences")
    print("First 3 sequences:", sequences[:3])

    attn_matrices = batch_attention(sequences, model, tokenizer, kmer=args.kmer, batch_size=32)
    write_attention_output(sequences, attn_matrices, args.output_path)



    threshold=0.0717
    locations = locations_multiple_sequences(attn_matrices, threshold=threshold)
    plot_locations(locations, f'test_histogram_{threshold}.png')

    #kmers = ['ATCGGA', 'GCTTGA', 'ATCGGA', 'CGATTA', 'ATCGGA', 'GCTTGA']
    #enriched = find_enriched_kmers_2(kmers)
    #for kmer, count, expected, pval in enriched:
    #    print(f"{kmer}: count={count}, expected={expected:.1f}, p={pval:.2e}")


if __name__ == "__main__":
    print("Parsing arguments", flush=True)
    args = parse_args()
    #print("Loading model")
    #model, tokenizer = load_model_and_tokenizer(args.model, args.base_model)
    #print("Model loaded successfully")
    #print(f"Max input length: {tokenizer.model_max_length}")
    #if test_get_sequences_above_threshold():
    #    main()
    
    sequences, attn_matrices = read_attention_output(args.output_path)
    print(len(sequences[1]))
    print(len(attn_matrices[1]))
    threshold=0.01
    locations = locations_multiple_sequences(attn_matrices, threshold=threshold)
    plot_locations(locations, f'test_histogram_{threshold}.png')

