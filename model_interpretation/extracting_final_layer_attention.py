
import torch
from transformers import AutoTokenizer, AutoModel
import matplotlib.pyplot as plt
import numpy as np
import argparse
import os
from atacseq_processing import extract_chromatin_coverage
import matplotlib.gridspec as gridspec
import pandas as pd
def load_model_and_tokenizer(model_path, base_model_path):
    # Tokenizer is loaded from the base model path
    tokenizer = AutoTokenizer.from_pretrained(base_model_path, local_files_only=True)
    model = AutoModel.from_pretrained(model_path, output_attentions=True, local_files_only=True)
    model.eval()
    return model, tokenizer


def kmer_tokenize(seq, k):
    remainder = len(seq) % k
    if remainder != 0:
        seq += 'N' * (k - remainder)
    return " ".join([seq[i:i+k] for i in range(0, len(seq), k)])



def get_attention_matrix(model, tokenizer, sequence, kmer=6):
    # Tokenize sequence using overlapping k-mers
    tokenized_seq = kmer_tokenize(sequence, kmer)
    inputs = tokenizer(tokenized_seq, return_tensors="pt")

    with torch.no_grad():
        outputs = model(**inputs)

    attentions = outputs.attentions
    final_layer_attn = attentions[-1]  # [batch, heads, seq_len, seq_len]
    avg_attn = final_layer_attn.mean(dim=1).squeeze(0)  # [seq_len, seq_len]
    return avg_attn, inputs


def map_attention_to_bases(attn_scores, seq_len, k):
    # multiply attention scores by k to get base-level attention
    return attn_scores.repeat_interleave(k) 



def plot_base_attention(base_attn, sequence, output_path, show_x_ticks=False):
    plt.figure(figsize=(12, 2))
    plt.imshow(base_attn.reshape(1, -1), cmap="viridis", aspect="auto")
    if show_x_ticks:
        plt.xticks(ticks=range(len(sequence)), labels=list(sequence), rotation=90, fontsize=6)
    plt.yticks([])
    plt.colorbar(label="Attention Score")
    plt.title("Base-level Attention (Averaged Over Heads and Source Tokens)")
    plt.tight_layout()
    plt.savefig(output_path, dpi=300)
    plt.close()
    print(f"Saved base-level attention heatmap to {output_path}")


def read_sequences(file_path):
    # File of sequences, one per line
    with open(file_path) as f:
        seqs = [line.strip() for line in f if line.strip()]
    # Ensure all sequences ar the same length
    seq_len = len(seqs[0])
    for seq in seqs:
        if len(seq) != seq_len:
            raise ValueError(f"All sequences must be of the same length. Found sequence of length {len(seq)}")
    # make all uppercase
    seqs = [seq.upper() for seq in seqs]
    return seqs

def multiple_sequences(sequences, output_file_path):
    # For each sequence, compute attention 
    # Create heatmap of sequence along the x-axis and each sequence along the y-axis 
    all_attn_matrices = []
    for seq in sequences:
            # Get averaged attention from final layer
        attn_matrix, inputs = get_attention_matrix(model, tokenizer, seq, args.kmer)

        # Collapse attention over source tokens (dim=0)
        token_attn_scores = attn_matrix.mean(dim=0)  # shape: (seq_len,)

        # Handle special tokens like <cls>
        tokens = tokenizer.convert_ids_to_tokens(inputs["input_ids"].squeeze().tolist())
        if tokens[0].lower() == "<cls>":
            token_attn_scores = token_attn_scores[1:]
        
        base_attn = map_attention_to_bases(token_attn_scores, len(seq), args.kmer)
        all_attn_matrices.append(base_attn)
    # Plot and save
    plt.figure(figsize=(12, 6))
    plt.imshow(np.array(all_attn_matrices), cmap="viridis", aspect="auto")
    plt.yticks([])
    plt.colorbar(label="Attention Score")
    plt.title("Base-level Attention (Averaged Over Heads and Source Tokens)")
    plt.tight_layout()
    plt.savefig(output_file_path, dpi=300)
    plt.close()
    print(f"Saved base-level attention heatmap to {output_file_path}")


def plot_base_attention_with_chromatin(base_attn, sequence, chromatin_coverage, output_path):
    # Sanity check
    if len(chromatin_coverage) != len(sequence):
        raise ValueError("Chromatin coverage length must match sequence length.")
    
    print(f"The base attention shape: {base_attn.shape}")
    print(f"The chromatin coverage shape: {len(chromatin_coverage)}")

    # Convert chromatin coverage to 2D array like base_attn
    chromatin_array = np.array(chromatin_coverage).reshape(1, -1)
    base_attn_array = base_attn.detach().cpu().numpy().reshape(1, -1)  # ensure numpy and correct shape

    fig = plt.figure(figsize=(12, 3))
    gs = gridspec.GridSpec(2, 1, height_ratios=[1, 1], hspace=0.0)  # No vertical gap

    # --- Plot Base Attention ---
    ax0 = plt.subplot(gs[0])
    im0 = ax0.imshow(base_attn_array, cmap="viridis", aspect="auto")
    ax0.set_xticks([])
    ax0.set_xticklabels([])
    ax0.set_yticks([])
    fig.colorbar(im0, ax=ax0, label="Attention")

    # --- Plot Chromatin Coverage as Heatmap ---
    ax1 = plt.subplot(gs[1], sharex=ax0)  # share x-axis for alignment
    im1 = ax1.imshow(chromatin_array, cmap="Blues", aspect="auto")
    ax1.set_xticks([0, len(sequence) - 1])
    ax1.set_xticklabels(['−1.5kbp', 'TSS'])
    ax1.set_yticks([])
    fig.colorbar(im1, ax=ax1, label="ATAC-seq")

    # --- Override sharex ticks leaking into ax0 ---
    ax0.tick_params(axis='x', which='both', bottom=False, top=False, labelbottom=False)

    plt.tight_layout()
    plt.savefig(output_path, dpi=300)
    plt.close()
    print(f"Saved attention + chromatin heatmap to {output_path}")


def plot_base_attention_with_chromatin_and_prediction(base_attn, sequence, chromatin, difference, output_file_path):
      # Sanity check
    if len(chromatin) != len(difference):
        raise ValueError("difference  length must match sequence length.")
    
    print(f"The base attention shape: {base_attn.shape}")
    print(f"The chromatin coverage shape: {len(chromatin)}")
    print(f"The difference shape: {len(difference)}")

    chromatin_array = np.array(chromatin).reshape(1, -1)
    difference_array = np.array(difference).reshape(1, -1)
    base_attn_array = base_attn.detach().cpu().numpy().reshape(1, -1)  # ensure numpy and correct shape

    fig = plt.figure(figsize=(12, 6))
    gs = gridspec.GridSpec(3, 1, height_ratios=[1, 1, 1], hspace=0.0)  # No vertical gap

    # --- Plot Base Attention ---
    ax0 = plt.subplot(gs[0])
    im0 = ax0.imshow(base_attn_array, cmap="viridis", aspect="auto")
    ax0.set_xticks([])
    ax0.set_xticklabels([])
    ax0.set_yticks([])

    # --- Plot Chromatin Coverage as Heatmap ---
    ax1 = plt.subplot(gs[1], sharex=ax0)  # share x-axis for alignment
    im1 = ax1.imshow(chromatin_array, cmap="Blues", aspect="auto")
    ax1.set_yticks([])

    # --- Plot Difference as Heatmap ---
    ax2 = plt.subplot(gs[2], sharex=ax0)  # share x-axis for alignment
    im2 = ax2.imshow(difference_array, cmap="Reds", aspect="auto")
    ax2.set_xticks([0, len(sequence) - 1])
    ax2.set_xticklabels(['−1.5kbp', 'TSS'])
    ax2.set_yticks([])


    # --- Override sharex ticks leaking into ax0 ---
    ax0.tick_params(axis='x', which='both', bottom=False, top=False, labelbottom=False)
    ax1.tick_params(axis='x', which='both', bottom=False, top=False, labelbottom=False)
    # Set clourbars 
    cbar0 = fig.colorbar(im0, ax=ax0)
    cbar0.set_label("Attention", rotation=270, labelpad=15)
    cbar1 = fig.colorbar(im1, ax=ax1)
    cbar1.set_label("ATAC-seq", rotation=270, labelpad=15)

    cbar2 = fig.colorbar(im2, ax=ax2)
    cbar2.set_label("In silico Predictions", rotation=270, labelpad=15)


    plt.tight_layout()
    plt.savefig(output_file_path, dpi=300)
    plt.close()
    print(f"Saved attention + chromatin + difference heatmap to {output_file_path}")


def plot_heatmap_from_fimo(fimo_file_path, sequence_length, title, output_path):
    with open(fimo_file_path, 'r') as f:
            fimo_data = f.readlines()
    hits_array = np.zeros(sequence_length, dtype=int)
    
    # Parse GFF lines and mark hits
    for line in fimo_data:
        fields = line.strip().split('\t')
        if len(fields) >= 5:
            start = int(fields[3]) - 1  # GFF is 1-based
            end = int(fields[4])        # end is inclusive
            # Clamp to sequence length
            start = max(0, start)
            end = min(sequence_length, end)
            hits_array[start:end] = 1
    
    # Convert to 2D array for heatmap (reshape to 1 row)
    heatmap_data = hits_array.reshape(1, -1)
    
    # Plotting
    plt.figure(figsize=(15, 2))
    plt.imshow(heatmap_data, aspect='auto', cmap='Reds', interpolation='none')
    plt.colorbar(label='Motif Hit')
    plt.xlabel('Position on Sequence')
    plt.yticks([])
    plt.title('')
    plt.tight_layout()
    plt.savefig(output_path, dpi=300)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()

    parser.add_argument('--model', type=str, required=True, help='Path to the model directory')
    parser.add_argument('--base_model', type=str, default='/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b', help='Path to the base model directory -required for tokenizer')
    parser.add_argument('--output_path', type=str, required=True, help='Path to save the heatmap image')
    parser.add_argument('--kmer', type=int, default=6, help='k-mer size (default: 6)')
    parser.add_argument('--sequence', type=str, help='Single nucleotide sequence (ACGT...)')
    parser.add_argument('--sequence_file', type=str, help='Path to file containing multiple sequences')
    parser.add_argument('--add_chromatin', action='store_true', help='Whether to add chromatin coverage to the plot')
    parser.add_argument('--add_insilico', action='store_true', help='Whether to add chromatin coverage to the plot')
    parser.add_argument('--plot_fimo', action='store_true', help='Whether to plot FIMO results')
    parser.add_argument('--fimo_file', type=str, help='Path to FIMO file for motif enrichment analysis')


    args = parser.parse_args()
    if args.plot_fimo:
        plot_heatmap_from_fimo(args.fimo_file, 6000, '', 'examining_one_sequence/fimo_jaspar_Glyma_17G160200.png')



    model, tokenizer = load_model_and_tokenizer(args.model, args.base_model)

    print(f"Using model from: {args.model}")

    if args.sequence:
        print(f"Input sequence length: {len(args.sequence)}")

        # Get averaged attention from final layer
        attn_matrix, inputs = get_attention_matrix(model, tokenizer, args.sequence, args.kmer)

        # Collapse attention over source tokens (dim=0)
        token_attn_scores = attn_matrix.mean(dim=0)  # shape: (seq_len,)

        # Handle special tokens like <cls>
        tokens = tokenizer.convert_ids_to_tokens(inputs["input_ids"].squeeze().tolist())
        if tokens[0].lower() == "<cls>":
            token_attn_scores = token_attn_scores[1:]
        #print(f"The Token Attention Scores: {token_attn_scores}")
        #print(f"Token Attention Scores shape: {token_attn_scores.shape}")
        #print(f"Tokens: {tokens}")
        #print(f"Tokens length: {len(tokens)}")

        # Map token attention to base attention
        base_attn = map_attention_to_bases(token_attn_scores, len(args.sequence), args.kmer)
        
        
        # Add chromatin 
        if args.add_chromatin:
            if args.add_insilico:
                insilico_predictions_path = "../intermediate_data/predictions_output/results/insilico_eval/test_predictions.csv"
                if not os.path.exists(insilico_predictions_path):
                    raise FileNotFoundError(f"Insilico predictions file not found: {insilico_predictions_path}")
                # Load insilico predictions
                insilico_predictions = pd.read_csv(insilico_predictions_path)
                prediction = insilico_predictions['Prediction'].tolist()
                print(f"Insilico predictions loaded: {len(prediction)} predictions")
                # 3.6961261654032165 
                true_value= 3.6961261654032165 
                difference = [prediction[i] - true_value for i in range(len(prediction))]

                # Define region
                # 13843672-13847672

                region_start = 13843672
                region_end = 13847672
                region_chrom = "Gm17"
                reverse_strand = True 
                chromatin = extract_chromatin_coverage(region_start, region_end, region_chrom, '../input_data/ATAC_seq_data', reverse_strand)
                # Plot base attention with chromatin coverage
                plot_base_attention_with_chromatin_and_prediction(base_attn, args.sequence, chromatin, difference, 'attention_with_chromatin_coverage_and_difference.png')

            else:
                # Define region
                region_start = 13843672
                region_end = 13847672
                region_chrom = "Gm17"
                reverse_strand = True 
                chromatin = extract_chromatin_coverage(region_start, region_end, region_chrom, '../input_data/ATAC_seq_data', reverse_strand)
                # Plot base attention with chromatin coverage
                plot_base_attention_with_chromatin(base_attn, args.sequence, chromatin,  'attention_with_chromatin_coverage.png')
        # Plot and save
        else:
            plot_base_attention(base_attn, args.sequence, args.output_path)

    
    elif args.sequence_file:
        print(f"Reading sequences from: {args.sequence_file}")
        sequences = read_sequences(args.sequence_file)
        multiple_sequences(sequences, args.output_path)

    else:
        raise ValueError("You must provide either a sequence or a sequence file.")