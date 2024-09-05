import pandas as pd
import matplotlib.pyplot as plt
from scipy.stats import pearsonr
import seaborn as sns


def read_in_results(file_path):
    results = pd.read_csv(file_path, sep=',')
    results.columns = results.columns.str.strip()
    return results


def plot(results, out_file_path, log=False,):
    """
    Plot predicted vs actual expression values 
    """
    predicted = results['Actual']
    actual = results['Predicted']


    # Calculate Pearson correlation
    pearson_corr, p_value = pearsonr(predicted, actual)
    print(f'Pearson correlation: {pearson_corr:.2f}, p-value: {p_value:.2f}')
    # Calculate the number of points above and below the threshold

    fig, ax = plt.subplots(figsize=(8, 8))
    sns.regplot(x=predicted, y=actual, ci=None, ax=ax, scatter_kws={"color": "royalblue", 's': 10}, line_kws={"color": "navy", "lw": 1})
    ax.grid(False)
    if log:
        ax.set_xscale("log")
        ax.set_yscale("log")

    ax.set_xlabel('Predicted expression values (TPM)')
    ax.set_ylabel('Actual expression values (TPM)')
    plt.title('Expression Values of Predicted vs Actual')
    plt.savefig(out_file_path, dpi=900)


if __name__ == '__main__':
    results = read_in_results('/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/soy_1500up_0down_42/3e-5/checkpoint-4500/predictions.csv')
    print(results.head())
    print(f'The headers are: {results.columns}')
    output_file_path = '../intermediate_data/soy_1500up_0down_42_3e-5_checkpoint-4500_predicted_vs_actual.png'
    plot(results, output_file_path, log=True)
