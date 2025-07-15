import os
import json
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

def load_results(base_path, params):
    """
    Load results from JSON files and build a DataFrame with hyperparameters and metrics.

    base_path: str, base directory containing experiment results
    params: list, list of parameter names (e.g., ['lr', 'r', 'alpha', 'dropout'])
    """
    records = []
    for root, _, files in os.walk(base_path):
        for file in files:
            if file == "eval_results.json":
                file_path = os.path.join(root, file)
                # Extract hyperparameters from directory name
                x = [param.split("_")[0:2] for param in os.path.basename(root).split("_")]
                hyperparams ={x[i][0]: x[i+1][0] for i in range(0, len(x), 2)}
                print(file_path)
                with open(file_path) as f:
                    metrics = json.load(f)
                    metrics.update(hyperparams)
                    records.append(metrics)
    # Convert to DataFrame and ensure numeric columns are parsed correctly
    df = pd.DataFrame(records)
    for param in params:
        if param in df.columns:
            df[param] = pd.to_numeric(df[param], errors="coerce")
    return df

def plot_lowest_mse(df, params, metrics, output_path=None):
    """
    Create plots of the lowest validation MSE grouped by each parameter.

    df: pd.DataFrame, contains results with hyperparameters and metrics
    params: list, parameter names to plot against
    metrics: str, the metric to minimize (e.g., 'eval_mse')
    output_path: str, path to save the plot (optional)
    """
    fig, axs = plt.subplots(2, 2, figsize=(14, 12))
    axs = axs.flatten()
    
    for i, param in enumerate(params):
        # Group by parameter and find the minimum MSE for each value
        grouped = df.groupby(param).agg({metrics: 'min'}).reset_index()
        axs[i].plot(grouped[param], grouped[metrics], marker="o", linestyle="--")
        axs[i].set_title(f"Lowest {metrics} vs {param}")
        axs[i].set_xlabel(param.capitalize())
        axs[i].set_ylabel(f"Lowest {metrics}")
        axs[i].grid()

    plt.tight_layout()
    if output_path:
        plt.savefig(output_path, dpi=300)
        print(f"Plot saved to {output_path}")
    else:
        plt.show()

if __name__ == "__main__":
    # Define the base path containing results and parameters to consider
    base_path = "../intermediate_data/filtering_out_low/soy_1500up_0down_42_log2plus1/"
    params = ["lr", "r", "alpha", "dropout"]
    metrics = "eval_mse"

    # Load results into a DataFrame
    results_df = load_results(base_path, params)

    # Plot the lowest MSE grouped by each parameter
    output_plot_path = "lowest_mse_by_params.png"
    plot_lowest_mse(results_df, params, metrics, output_path=output_plot_path)
