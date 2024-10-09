import pandas as pd
import matplotlib.pyplot as plt
from scipy.stats import pearsonr
import seaborn as sns
import sys

def read_in_results(file_path):
    results = pd.read_csv(file_path, sep=',')
    results.columns = results.columns.str.strip()
    return results


def check_range_of_values(input_data, results):
    predicted = results['Predicted']
    actual = results['Actual']
    print('The cut off is at 0.5 TPM which when log2 transformed is -1')
    print(f'Minimum predicted value: {predicted.min()}, maximum predicted value: {predicted.max()}')
    print(f'Minimum actual value: {actual.min()}, maximum actual value: {actual.max()}')
    input_values = input_data['label']
    print(f'The data used to make the predictions minimum is {input_values.min()}, maximum is {input_values.max()}')


def plot(results, out_file_path):
    """
    Plot predicted vs actual expression values 
    Note. The values are already log2 transformed so dont log the axis
    """
    predicted = results['Actual']
    actual = results['Predicted']
    # Calculate Pearson correlation
    pearson_corr, p_value = pearsonr(predicted, actual)
    print(f'Pearson correlation: {pearson_corr:.2f}, p-value: {p_value:.2f}')
    # Calculate the number of points above and below the threshold

    fig, ax = plt.subplots(figsize=(5.7, 5.7), dpi=900)
    sns.regplot(x=predicted, y=actual, ci=None, ax=ax, scatter_kws={"color": "#0f62f3", 's': 10}, line_kws={"color": "#002d9c", "lw": 1})
    ax.grid(False)
    ax.set_xlabel('Predicted expression values (Log2 TPM)', fontsize=11)
    ax.set_ylabel('Actual expression values (Log2 TPM)', fontsize=11)
    plt.title('Expression Values of Predicted vs Actual', fontsize=11)
    plt.savefig(out_file_path, dpi=900)


if __name__ == '__main__':
    input_data = str(sys.argv[1])
    predictions = str(sys.argv[2])
    output_file_path = str(sys.argv[3])
    results = read_in_results(predictions)
    input_data = read_in_results(input_data)
    print(results.head())
    print(f'The headers are: {results.columns}')
    check_range_of_values(input_data, results)
    plot(results, output_file_path)
