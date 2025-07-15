import os
import torch
import numpy as np
import matplotlib.pyplot as plt
import json

def load_and_average_attention_per_token(attention_dir, token_map_path):
    """
    Loads the attention scores and token-to-sequence mapping.

    Args:
        attention_dir (str): Directory containing the attention scores.
        token_map_path (str): Path to the JSON file mapping token IDs to sequences.

    Returns:
        layer_mean (np.ndarray): Average attention scores across layers.
        token_total_attention (np.ndarray): Total attention scores per token.
        token_id_to_sequence (dict): Mapping of token indices to sequences.
    """
    attention_matrices = []

    # Load token-to-sequence mapping
    with open(token_map_path, "r") as f:
        token_id_to_sequence = json.load(f)

    # Get a sorted list of attention files
    attention_files = sorted(
        [f for f in os.listdir(attention_dir) if f.endswith("_attention.pt")],
        key=lambda x: int(x.split("_")[1])
    )

    for file in attention_files:
        file_path = os.path.join(attention_dir, file)
        attention = torch.load(file_path).cpu().numpy()
        attention_matrices.append(attention)

    attention_stack = np.stack(attention_matrices)
    layer_mean = np.mean(attention_stack, axis=0)
    token_total_attention = np.sum(layer_mean, axis=0)

    return layer_mean, token_total_attention, token_id_to_sequence

def plot_total_attention(token_total_attention, token_id_to_sequence, threshold=4, save_path=None):
    """
    Plots the total attention per token and annotates the plot with tokens/sequences 
    that have attention scores above the given threshold.
    """
    plt.figure(figsize=(12, 6))
    plt.plot(token_total_attention, marker='o')
    plt.title("Total Attention Across Sequence Lengths")
    plt.xlabel("Token Index")
    plt.ylabel("Total Attention Score")
    plt.grid(True)


    # Annotate points above the threshold
    for idx, score in enumerate(token_total_attention):
        if score > threshold:
            plt.annotate(
                f"{token_id_to_sequence[str(idx)]}",
                (idx, score),
                textcoords="offset points",
                xytext=(0, 10),
                ha='center',
                fontsize=8,
                color='red'
            )

    if save_path:
        plt.savefig(save_path, dpi=900)
        print(f"Plot saved to {save_path}")
    else:
        plt.show()


# Example Usage
if __name__ == "__main__":
    attention_dir = "/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/soy_1500up_0down_42_log2/3e-4/checkpoint-3900/layers"

    token_map_path ="/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/soy_1500up_0down_42_log2/3e-4/checkpoint-3900/layers/token_id_to_sequence.json"

    # Compute the per-token average attention and token-to-sequence mapping
    layer_mean, token_total_attention, token_id_to_sequence = load_and_average_attention_per_token(
        attention_dir, token_map_path
    )

    # Display results
    print(f"Per-Token Average Attention Scores: {layer_mean}")
    print(f"Total Attention Per Token: {token_total_attention}")

    # Plot the attention scores
    plot_total_attention(
        token_total_attention,
        token_id_to_sequence,
        threshold=4,
        save_path="/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/soy_1500up_0down_42_log2/3e-4/checkpoint-3900/well_predicted_annotated_attention_plot.png"
    )
