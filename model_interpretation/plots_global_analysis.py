# This python script generates the plots from the script global_analysis_of_TFBS.py
# Requires a df like:
# glycine_max_test_attention.csv
# Sequence, Attention Score 

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Read all lines properly
def readin_attention(filepath, max_length=6000):
    with open(filepath, 'r') as f:
        lines = f.readlines()

    # Optional: skip header if it exists
    if lines[0].lower().startswith('sequence'):
        lines = lines[1:]

    data = []
    for line in lines:
        line = line.strip()
        if not line:
            continue  # skip empty lines
        parts = line.split(',', 1)  # split only at first comma
        sequence = parts[0]
        attention_vals = parts[1].split(',')  # split the rest into attention scores
        attention_scores = [[float(val)] for val in attention_vals]
        # match the length of attention scores to max_length
        attention_scores = attention_scores[:max_length]  # truncate if longer

        data.append((sequence, attention_scores))

    df = pd.DataFrame(data, columns=['sequence', 'attention'])

    # Check shape
    print(df.shape)
    return df

df = readin_attention('glycine_max_test_attention.csv')


def plot_average_attention_over_length(df):
    all_attentions = []

    for attn in df['attention']:
        # Handle list of lists like [[0.1], [0.2], ...]
        if isinstance(attn[0], list):
            attn = [x[0] for x in attn]  # flatten to list of floats
        all_attentions.append(attn)

    # Convert to 2D numpy array: (num_sequences, sequence_length)
    attn_array = np.array(all_attentions)

    # Check that all attention lists are the same length
    if not np.all([len(row) == attn_array.shape[1] for row in all_attentions]):
        raise ValueError("Not all attention vectors are the same length.")

    # Compute average attention at each position
    avg_attention = attn_array.mean(axis=0)

    # Plot
    plt.figure(figsize=(10, 4))
    plt.plot(avg_attention, marker='o')
    plt.title("Average Attention per Position")
    plt.xlabel("Position in sequence (0-indexed)")
    plt.ylabel("Average Attention")
    plt.grid(True)
    plt.tight_layout()
    plt.savefig('average_attention_per_position.png')
    print("Plot saved as 'average_attention_per_position.png'")


def plot_average_attention_over_length_2(df, title="Average Attention per Position", save_path=None):
    """
    Enhanced plot of average attention score per base position.
    """
    all_attentions = []

    for attn in df['attention']:
        if isinstance(attn[0], list):  # flatten if needed
            attn = [x[0] for x in attn]
        all_attentions.append(attn)

    attn_array = np.array(all_attentions)
    print(f"Attention array shape: {attn_array.shape}")

    # Sanity check
    if not np.all([len(row) == attn_array.shape[1] for row in all_attentions]):
        raise ValueError("Inconsistent attention vector lengths.")

    avg_attention = attn_array.mean(axis=0)
    std_attention = attn_array.std(axis=0)

    x = np.arange(len(avg_attention))

    # Plotting
    plt.figure(figsize=(12, 6))

    # Plot average line with shading for std dev
    plt.plot(x, avg_attention, color='navy', linewidth=1.5, label='Mean Attention')
    plt.fill_between(x, avg_attention - std_attention, avg_attention + std_attention,
                     color='skyblue', alpha=0.3, label='±1 SD')

    # Mark peaks if desired
    max_idx = np.argmax(avg_attention)
    plt.scatter([max_idx], [avg_attention[max_idx]], color='red', s=60, label='Max Attention')

    # Labels and style
    plt.title(title, fontsize=14, fontweight='bold', pad=15)
    plt.xlabel("Position in Sequence", fontsize=12)
    plt.ylabel("Average Attention", fontsize=12)
    plt.grid(True, linestyle='--', alpha=0.5)
    plt.legend(frameon=False, fontsize=10)

    # Minimalist ticks and spine trimming
    plt.tick_params(axis='both', which='major', labelsize=10)
    for spine in ['top', 'right']:
        plt.gca().spines[spine].set_visible(False)

    # Tight layout and optional save
    plt.tight_layout()
    if save_path:
        plt.savefig(save_path, dpi=300, bbox_inches='tight')
    plt.show()


plot_average_attention_over_length_2(df, title="Average Attention per Position in Glycine max", save_path='average_attention_per_position_glycine_max.png')