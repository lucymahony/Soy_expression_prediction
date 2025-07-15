import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import re

def load_results(file_path):
    """
    
    Parameters:
        filepath (str): Path to the .txt file.
    
    Returns:
        pd.DataFrame: DataFrame with columns: Dataset, Type, Val_R2, Output_Dir
    """
    df = pd.read_csv(file_path, sep='\t')
    df['Val_R2'] = pd.to_numeric(df['Val_R2'], errors='coerce')
    df['Upstream'] = df['Dataset'].str.extract(r'(\d+)up').astype(int)
    df['Downstream'] = df['Dataset'].str.extract(r'(\d+)down').astype(int)
    df = df.dropna(subset=['Val_R2', 'Upstream', 'Downstream'])
    return df


def plot_bar_chart(df, output_file_path):
    plt.figure(figsize=(5.7, 5.7), dpi=900)
    colour_palette = ['#fa4d56', '#ee5396', '#a56eff', '#4589ff', '#009d9a'] #  
    ax = sns.barplot(
        data=df,
        x='Upstream',
        y='Val_R2',
        hue='Downstream',
        palette=colour_palette,
        edgecolor='black',)
    handles, labels = ax.get_legend_handles_labels()
    label_map = {
        '0': 'Transcript',
        '150': '150 bp',
        '1000': '1 kb',
        '5000': '5 kb',
        '10000': '10 kb'
    }
    new_labels = [label_map.get(l, l) for l in labels]
    ax.legend(handles=handles, labels=new_labels, title='Downstream\n Sequence\n Length (bp)',
              bbox_to_anchor=(1.05, 1), loc='upper left', frameon=False,)
    plt.xlabel('Upstream Length (bp)', fontsize=22)
    plt.ylabel('Validation R²', fontsize=22)
    plt.title('')
    plt.tight_layout()
    sns.despine()
    plt.savefig(output_file_path, dpi=900)
    plt.close()
    
def plot_heatmap(df, output_file_path):
    df = df[df['Type'] == 'promoter_only']
    pivot = df.pivot(index='Upstream', columns='Downstream', values='Val_R2')
    pivot = pivot.sort_index(ascending=True).sort_index(axis=1, ascending=True)
    plt.figure(figsize=(10, 8))
    cmap = sns.light_palette("seagreen", as_cmap=True)
    sns.heatmap(pivot, annot=True, fmt=".3f", cmap=cmap, cbar_kws={'label': 'R²'})
    plt.title('')
    plt.xlabel('Down')
    plt.ylabel('Up')
    plt.tight_layout()
    plt.savefig(output_file_path, dpi=900)
    plt.close()


if __name__ == "__main__":
    repo="/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction"
    results_file_path= f"{repo}/intermediate_data/variable_input_experiment/small_test_summary_results.tsv"
    df = load_results(results_file_path)
    print
    print(df.sort_values(by=['Upstream', 'Downstream']))
    plot_bar_chart(df, "small_test_variable_length_bar_chart.png")
    plot_heatmap(df, "small_test_variable_length_heatmap.png")