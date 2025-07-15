# This script runs:
# - Extracting final layer attention
# - Get location of sequences above threshold
# - Get sequences above threshold

# Determine if theres is a common location 
# Determine if the sequences are more distinct than random 

# Determine if any of the sequences are TFBS

import argparse
from extracting_final_layer_attention import load_model_and_tokenizer, map_attention_to_bases
import matplotlib.pyplot as plt
import numpy as np
from collections import Counter
from scipy.stats import binomtest
import torch
import sys
print("Script started", flush=True)

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--model', type=str, default='', help='Path to the model directory')
    parser.add_argument('--base_model', type=str, default='/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b', help='Path to the base model directory -required for tokenizer')
    parser.add_argument('--output_path', type=str, default='', help='Path to save the heatmap image')
    parser.add_argument('--kmer', type=int, default=6, help='k-mer size (default: 6)')
    parser.add_argument('--sequence_file', type=str, help='Path to file containing multiple sequences')
    parser.add_argument('--sequence_fasta_file', type=str, help='Path to fasta file containing sequences')
    args = parser.parse_args()
    return args


def get_attention_matrix(model, tokenizer, sequence_or_kmers, kmer=6, is_split=True):
    """
    Returns average attention matrix from final layer.

    Parameters:
    - sequence_or_kmers: str if is_split=False, else list of non-overlapping k-mers
    - kmer: k-mer size used (default 6)
    - is_split: True if `sequence_or_kmers` is already tokenized into k-mers

    Returns:
    - avg_attn: attention matrix from the final layer, averaged over heads
    - inputs: tokenizer output
    """
    if is_split:
        # Input is already a list of non-overlapping kmers
        inputs = tokenizer(
            sequence_or_kmers,
            is_split_into_words=True,
            return_tensors="pt",
            padding="max_length",
            truncation=True,
            max_length=tokenizer.model_max_length
        )
    else:
        # Tokenize full sequence (e.g. overlapping kmers)
        inputs = tokenizer(
            sequence_or_kmers,
            return_tensors="pt",
            padding="max_length",
            truncation=True,
            max_length=tokenizer.model_max_length
        )

    inputs = {k: v.to(model.device) for k, v in inputs.items()}

    with torch.no_grad():
        outputs = model(**inputs)

    attentions = outputs.attentions  # [batch, heads, seq_len, seq_len]
    final_layer_attn = attentions[-1]
    avg_attn = final_layer_attn.mean(dim=1).squeeze(0)  # [seq_len, seq_len]

    return avg_attn, inputs



def tokenize_non_overlapping(seq, k=6):
    return [seq[i:i+k] for i in range(0, len(seq), k) if len(seq[i:i+k]) == k]


def multiple_sequences(sequences, output_file_path, model, tokenizer, args):
    # For each sequence compute attention from final layer

    all_attn_matrices = []
    for seq in sequences:
        kmers = tokenize_non_overlapping(seq, k=6)
        attn_matrix, inputs = get_attention_matrix(model, tokenizer, kmers, 6, is_split=True)

        token_attn_scores = attn_matrix.mean(dim=0)
        tokens = tokenizer.convert_ids_to_tokens(inputs["input_ids"].squeeze().tolist())
        if tokens[0].lower() == "<cls>":
            token_attn_scores = token_attn_scores[1:]
        base_attn = map_attention_to_bases(token_attn_scores, len(seq), 6)
        all_attn_matrices.append(base_attn)

    # Write to file 
    with open(output_file_path, 'w') as f:
        f.write(f"Sequence,Attention_score\n")
        for i, seq in enumerate(sequences):
            attn_str = ",".join([f"{x:.4f}" for x in all_attn_matrices[i]])
            f.write(f"{seq},{attn_str}\n")  
    print(f"Attention scores for multiple sequences saved to {output_file_path}")
    return all_attn_matrices


def location_above_threshold(attn_matrix, threshold=0.5):
    # Get the locations where attention scores are above the threshold
    locations = []
    for i, score in enumerate(attn_matrix):
        if score > threshold:
            locations.append(i)
    return locations


def locations_multiple_sequences(attn_matrices, threshold=0.5):
    locations = []
    for attn_matrix in attn_matrices:
        locs = location_above_threshold(attn_matrix, threshold)
        locations.append(locs)
    return locations


def plot_locations(locations, output_file_path):
    all_locations = [loc for sublist in locations for loc in sublist]
    if not all_locations:
        print("No attention positions above threshold — line plot not generated.")
        return
    max_pos = max(all_locations)
    counts = [0] * (max_pos + 1)
    for pos in all_locations:
        counts[pos] += 1

    # Plot line graph
    plt.figure(figsize=(10, 6))
    plt.plot(range(len(counts)), counts)
    plt.xlabel('Base Position')
    plt.ylabel('Count of High-Attention Scores')
    plt.title('')
    plt.grid(True)
    plt.tight_layout()
    plt.savefig(output_file_path)
    plt.close()
    print(f"Line plot saved to {output_file_path}")


def get_sequences_above_threshold(sequences, attn_matrices, threshold=0.5):
    """
    Extracts continuous blocks of characters from each sequence where the 
    corresponding attention values are above the threshold.
    
    Parameters:
        sequences (List[str]): List of nucleotide (or protein) sequences.
        attn_matrices (List[List[float]]): Corresponding list of attention values.
        threshold (float): The minimum attention value to include a base.
    
    Returns:
        List[List[str]]: A list for each input sequence, each containing substrings
                         where attention is above the threshold in contiguous blocks.
    """
    result = []

    for seq, attn in zip(sequences, attn_matrices):
        subsequences = []
        current_subseq = ""
        
        for base, score in zip(seq, attn):
            if score > threshold:
                current_subseq += base
            else:
                if current_subseq:
                    subsequences.append(current_subseq)
                    current_subseq = ""
        
        # Catch any remaining sequence at the end
        if current_subseq:
            subsequences.append(current_subseq)
        
        result.append(subsequences)
    
    return result


def find_enriched_kmers(kmers, alpha=0.05):
    """
    """
    
    total_kmers = len(kmers)
    expected_number = total_kmers / 4**6  # Assuming uniform distribution of 6-mers
    for kmer in kmers:
        occurance_count = kmers.count(kmer)
        if occurance_count > expected_number:
            print(f"Found kmer {kmer} with count {occurance_count} (expected {expected_number})")

def test_get_sequences_above_threshold():
    sequences=["ACGTACGT", "TTTTGGGG"]
    attn_matrices=[
            [0.1, 0.2, 0.6, 0.7, 0.3, 0.4, 0.1, 0.0],
            [0.8, 0.9, 0.1, 0.0, 0.6, 0.6, 0.0, 0.2]]
    expected=[["GT"], ["TT", "GG"]]
    result = get_sequences_above_threshold(sequences, attn_matrices, threshold=0.5)
    if result == expected:
        print('Test passed!')
    else :f"Expected {expected}, but got {result}"
    return result == expected



def find_enriched_kmers_2(kmers, alpha=0.05):
    """
    Identify enriched 6-mers using binomial testing under uniform background.

    Parameters:
        kmers (List[str]): List of 6-mer strings.
        alpha (float): Significance threshold for enrichment.

    Returns:
        List[Tuple[str, int, float, float]]: Enriched kmers and their stats:
            (kmer, observed_count, expected_count, p_value)
    """
    total_kmers = len(kmers)
    expected_p = 1 / (4 ** 6)  # Uniform probability for any 6-mer
    kmer_counts = Counter(kmers)
    enriched = []

    for kmer, observed in kmer_counts.items():
        result = binomtest(observed, total_kmers, expected_p, alternative='greater')
        if result.pvalue < alpha:
            expected = total_kmers * expected_p
            enriched.append((kmer, observed, expected, result.pvalue))

    enriched.sort(key=lambda x: x[3])  # Sort by p-value
    return enriched


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



def main():
    # Read in sequences from file
    if args.sequence_file:
        with open(args.sequence_file, 'r') as f:
            sequences = [line.strip() for line in f if line.strip()]
    elif args.sequence_fasta_file:
        sequences = read_fasta(args.sequence_fasta_file)
    else:
        sequences = ["ACGTACGT", "TTTTGGGG"]  # Example sequences

    print(f" There are {len(sequences)} sequences")


    attn_matrices = multiple_sequences(sequences, args.output_path, model, tokenizer, args)
    print(f"Attention matrices computed for")

    locations = locations_multiple_sequences(attn_matrices, threshold=0.0717)
    plot_locations(locations, 'test_histogram.png')
    kmers = ['ATCGGA', 'GCTTGA', 'ATCGGA', 'CGATTA', 'ATCGGA', 'GCTTGA']
    enriched = find_enriched_kmers_2(kmers)
    
    for kmer, count, expected, p in enriched:
        print(f"{kmer}: count={count}, p-value={p:.2e}")


if __name__ == "__main__":
    print("Parsing arguments", flush=True)
    args = parse_args()
    print("Loading model")
    model, tokenizer = load_model_and_tokenizer(args.model, args.base_model) 
    print("Model loaded successfully")
    print(f"The models max length is {tokenizer.model_max_length}")
    print(f"Using model from: {args.model}")
    if test_get_sequences_above_threshold():
        # If the test passes, run the main functionality
        main()



