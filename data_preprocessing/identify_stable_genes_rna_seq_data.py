# This script process data from the Soy expression atlas. https://soyatlas.venanciogroup.uenf.br/
# Aims to identify stable genes across different experiments. Removes transcripts less that 0.5TPM, 
# #calculates standard deviation, coefficient of variation, median absolute deviation, pearson and spearmans correlation.


# Huang  = https://doi.org/10.1016/j.ygeno.2022.110364
# Wang = https://doi.org/10.1093/plcell/koab081  
# bn = The NCBI bioproject number
# s number is the biosample number e.g. SAMN15835458 



import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns 
import sys 
from scipy.stats import pearsonr
from scipy.stats import linregress
import numpy as np
import seaborn as sns
from scipy.stats import spearmanr, pearsonr, median_abs_deviation
from sklearn.decomposition import PCA
from sklearn.preprocessing import StandardScaler
from sklearn.cluster import KMeans




def get_s_numbers(metadata_file_path, tissue):
    """
    Returns the biosample numbers of a tissue as a list 
    e.g. 
    get_s_numbers(huang_2022_metadata, leaf) =  ['SAMN20525661', 'SAMN20525662'] 
    """
    metadata = pd.read_csv(metadata_file_path, sep='\t')
    bio_sample_numbers = metadata[metadata['Part'] == tissue]['BioSample'].to_list()
    # Excude SAMN20525663 SAMN20525664 as PRJNA751745_metadata.tsv reports them as leaf but they are actually leaf bud as reported on NCBI.
    bio_sample_numbers = [x for x in bio_sample_numbers if x not in ['SAMN20525663', 'SAMN20525664']]
    return bio_sample_numbers


def tpm_matrix(tpm_file_path):
    matrix = pd.read_csv(tpm_file_path, sep = '\t' )
    return matrix


def expression_value(tpm_matrix, s_number, gene):
    """
    Returns as a value the tpm of a given gene for a given biosample number in a given expression matrix. 
    """
    gene_row = tpm_matrix[tpm_matrix['Gene'] == gene]
    print(f'gene row is {gene_row}')
    if not gene_row.empty:
        expression = gene_row[s_number].iloc[0] # iloc to return the value directly rather than a series.
        return expression
    else:
        print('Error there is no row in the expression matrix with that gene name ')


def plot_replicates(expression_matrix, s_number_1, s_number_2, out_file_path, log=False):
    """
    Plots a scatter plot of the expression values of two biosample numbers (2 replicates) from the same study / the same expression matrix. 
    """
    fig, ax = plt.subplots(figsize=(5.7, 5.7))
    ax.scatter(expression_matrix[s_number_1], expression_matrix[s_number_2], color='blue')
    # Add labels and title
    if log:
        ax.set_xscale("log")
        ax.set_yscale("log")

    plt.xlabel(s_number_1)
    plt.ylabel(s_number_2)
    plt.title(f'Expression Values: {s_number_1} vs {s_number_2}')
    plt.grid(True)
    # Display the plot
    plt.savefig(out_file_path)


def average_expression_matrix(expression_matrix, list_of_s_numbers):
    """
    Returns the mean of each gene for given bio sample numbers
    Input: ['SAMN15835458', 'SAMN15835459'] AND 
                  Gene  SAMN15835458  SAMN15835459
    Glyma.01G000100      5.071897      4.031121
    Glyma.01G000137      0.000000      0.000000
    Returns:
                  Gene  Mean_expression
    Glyma.01G000100      4.55.....
    Glyma.01G000137      0.000000      

    """
    expression_matrix = expression_matrix.copy()

    # Check that the given biosamples are columns in the expression matrix. 
    list_expression_columns = expression_matrix.columns
    if not set(list_of_s_numbers).issubset(set(list_expression_columns)):
        raise ValueError('Not all of the biosample numbers e.g. SAMN20525553 are columns in the expression matrix ')

    expression_matrix.loc[:,'Mean_expression'] = expression_matrix[list_of_s_numbers].mean(axis=1)
    average_matrix = expression_matrix[['Gene', 'Mean_expression']]
    return average_matrix


def plot_different_experiments(experiment_1, experiment_2, out_file_path, log=False):
    """
    plot the averages of expression matrix 1 against expression matrix 2 
    Input:
        experiment_1 and 2 are dictionaries that contain average_matrix
    """
    mean_1 = experiment_1['average_matrix']
    mean_2 = experiment_2['average_matrix']

    x = mean_1['Mean_expression']
    y = mean_2['Mean_expression']

    # Check that there are the same genes in matrix 1 as matrix 2 
    # Check same number of rows in each 
    if mean_1.shape[0] != mean_2.shape[0]:
        raise ValueError('The number of genes in the expression matrixes are not the same')
    # Check the columns 'Gene' in both are the same. 
    if not mean_1['Gene'].equals(mean_2['Gene']):
        raise ValueError('The column Gene in the two expression matrixes are not the same ')
    
    # Calculate Pearson correlation
    pearson_corr, p_value = pearsonr(x, y)


    # Now the tests have passed can plot the average expression value across the replicates in expression matrix 1 to matrix 2. 
    fig, ax = plt.subplots(figsize=(5.7, 5.7))
    sns.regplot(x = x, y = y, color='blue',  ci=None)
    ax.grid(False)
    if log:
        ax.set_xscale("log")
        ax.set_yscale("log")

    ax.set_xlabel(experiment_1['name']+ ' expression values (TPM)')
    ax.set_ylabel(experiment_2['name']+ ' expression values (TPM)')
    plt.title('Expression Values of ' + str(experiment_1['name']) + ', plotted against ' + str(experiment_2['name']))
    ax.text(x.min(), y.max(), 'Pearson r = {:.2f}'.format(pearson_corr), horizontalalignment='right', verticalalignment='top', fontsize=12, color='black')
    plt.savefig(out_file_path)


def plot_different_experiments_with_thresholds(experiment_1, experiment_2, out_file_path, log=False, threshold=1):
    """
    Plot the average gene expression (TPM) from two experiments.
    Filters out low-expressed genes below a TPM threshold and plots:
    - Scatter plot of expression
    - Red threshold lines
    - Log-log regression line (fitted only to points above threshold)
    - Pearson correlation
    """

    # Step 1: Extract gene-wise mean expression
    avg_expr1 = experiment_1['average_matrix']
    avg_expr2 = experiment_2['average_matrix']
    x = avg_expr1['Mean_expression']
    y = avg_expr2['Mean_expression']

    # Step 2: Check consistency
    if avg_expr1.shape[0] != avg_expr2.shape[0]:
        raise ValueError('Expression matrices have different numbers of genes.')
    if not avg_expr1['Gene'].equals(avg_expr2['Gene']):
        raise ValueError('Gene identifiers do not match between experiments.')

    # Step 3: Apply threshold filter
    above_threshold_mask = (x >= threshold) & (y >= threshold)
    x_filtered = x[above_threshold_mask]
    y_filtered = y[above_threshold_mask]

    # Step 4: Compute Pearson correlation
    pearson_r, _ = pearsonr(x_filtered, y_filtered)

    # Step 5: Fit log-log regression
    log_x = np.log10(x_filtered)
    log_y = np.log10(y_filtered)
    slope, intercept, r_val, p_val, stderr = linregress(log_x, log_y)

    # Regression line: y = 10^(intercept + slope * log10(x))
    regression_x_vals = np.logspace(np.log10(threshold), np.log10(x_filtered.max()), 100)
    regression_y_vals = 10 ** (intercept + slope * np.log10(regression_x_vals))

    # Step 6: Count above/below threshold
    n_above = above_threshold_mask.sum()
    n_below = len(above_threshold_mask) - n_above

    # Step 7: Plot
    fig, ax = plt.subplots(figsize=(5.7, 5.7))

    # Plot points
    ax.scatter(x[~above_threshold_mask], y[~above_threshold_mask], color='grey', s=10, label='Below threshold')
    ax.scatter(x_filtered, y_filtered, color='royalblue', s=10, label='Above threshold')

    # Plot regression line (log-log space)
    ax.plot(regression_x_vals, regression_y_vals, '--', color='black', lw=1.5, label='Log-log regression')

    # Plot red threshold lines
    ax.axhline(threshold, color='red', linestyle='dotted', lw=2)
    ax.axvline(threshold, color='red', linestyle='dotted', lw=2)

    # Apply log scaling if requested
    if log:
        ax.set_xscale("log")
        ax.set_yscale("log")

    # Labels and annotation
    ax.set_xlabel(f"{experiment_1['name']} (TPM)", fontsize=20)
    ax.set_ylabel(f"{experiment_2['name']} (TPM)", fontsize=20)
    ax.text(0.01, 0.95, f'Pearson r = {pearson_r:.2f}', transform=ax.transAxes,
            ha='left', va='top', fontsize=12)

    # Aesthetics
    ax.grid(False)
    sns.despine()
    plt.tight_layout()
    plt.savefig(out_file_path,  dpi=900)
    plt.close()

    # Print summary
    print(f'Pearson r = {pearson_r:.3f}')
    print(f'Log-log regression: y = 10^({intercept:.2f} + {slope:.2f}·log10(x))')
    print(f'Points above threshold = {n_above}')
    print(f'Points below threshold = {n_below}')



def generate_experiment_dict(bn, tissue, name, data_path):
    """
    Input:
        bn - bioproject number e.g. 'PRJNA751745'
        tissue - e.g. 'leaf'
        name - The name given to the dictionary = used i writing the axis and title in the plots 
        path to where the data for the metadata and tpm tsvs are 
    Returns:
        Dictionary of the 'experiment' name, sample numbers, expression matrix, and averaged matrix. 
    """
    metadata_path = f'{data_path}{bn}_metadata.tsv'
    tpm_path = f'{data_path}{bn}_TPM.tsv'
    s_numbers = get_s_numbers(metadata_path, tissue)
    matrix = tpm_matrix(tpm_path)
    # Filter the matrix to contain columns for the correct s_numbers only
    matrix = matrix[['Gene'] + s_numbers]
    print(f'This is the head of {name} expression matrix {matrix.head()}')

    average = average_expression_matrix(matrix, s_numbers) 

    experiment = {'name' : name, 
                  's_numbers': s_numbers,
                  'tpm_matrix': matrix,
                  'average_matrix': average
                  }
    return experiment 


def ma_plot_scatter(experiment_dict, out_file_path):
    """
    Given an experiment dictionary it plots the 2 biological replicates in the style of an MA plot.
    x-axis = log average = A = ( log(a) + log(b) )/ 2
    y-axis = log ratio = M = (log(a/b)) = log(a) - log(b)
    where:
    a = rep 1
    b = rep 2
    """
    tpm_matrix = experiment_dict['tpm_matrix']
    tpm_matrix = tpm_matrix.copy()
    # Remove any rows with 0 TPM values
    tpm_matrix = tpm_matrix[(tpm_matrix[experiment_dict['s_numbers'][0]] > 0) & (tpm_matrix[experiment_dict['s_numbers'][1]] > 0)]

    s_numbers = experiment_dict['s_numbers']
    # Check that there are only 2 replicates
    if len(s_numbers) != 2:
        raise ValueError('This function is only for plotting 2 replicates')
    # Get the log2 of the TPM values for each repplicate/s_number
    for s_number in s_numbers:
        tpm_matrix[f'log2_{s_number}'] = np.log2(tpm_matrix[s_number])

    tpm_matrix['A'] = (tpm_matrix[f'log2_{s_numbers[0]}'] + tpm_matrix[f'log2_{s_numbers[1]}']) / 2
    tpm_matrix['M'] = tpm_matrix[f'log2_{s_numbers[0]}'] - tpm_matrix[f'log2_{s_numbers[1]}']

    fig, ax = plt.subplots(figsize=(5.7, 5.7), dpi=900)
    # Grid with line at 1 and -1
    ax.grid(zorder=0)
    ax.scatter(tpm_matrix['A'], tpm_matrix['M'], color='#0f62fe', zorder=5) 
    ax.axhline(y=1, color='grey', linestyle='--', zorder=10)
    ax.axhline(y=-1, color='grey', linestyle='--', zorder=20)
    ax.set_xlabel('A (Log2 Average)', fontsize=11)
    ax.set_ylabel('M (Log2 Ratio)', fontsize=11)
    ax.set_title('MA plot', fontsize=11)
    fig.savefig(out_file_path, dpi=900)
    

def ma_plot_boxplot(experiment_dict, out_file_path, title='MA plot', transform=False):
    """
    Given an experiment dictionary, it plots the 2 biological replicates in the style of an MA plot,
    but using box plots across A (log2 average) in bins of size 1.
    x-axis = log average = A = ( log(a) + log(b) )/ 2
    y-axis = log ratio = M = (log(a/b)) = log(a) - log(b)
    where:
    a = rep 1
    b = rep 2
    """
    tpm_matrix = experiment_dict['tpm_matrix']
     # Remove any rows with 0 TPM values
    tpm_matrix = tpm_matrix[(tpm_matrix[experiment_dict['s_numbers'][0]] > 0) & (tpm_matrix[experiment_dict['s_numbers'][1]] > 0)]
    s_numbers = experiment_dict['s_numbers']
    # Check that there are only 2 replicates
    if len(s_numbers) != 2:
        raise ValueError('This function is only for plotting 2 replicates')


    if transform:
        # Apply log2(x+1) transform to both replicates before calculating A and M
        for s_number in experiment_dict['s_numbers']:
            tpm_matrix[f'log2plus1_{s_number}'] = np.log2(tpm_matrix[s_number] + 1)
            tpm_matrix[f'logoflog2plus1_{s_number}'] = np.log2(tpm_matrix[f'log2plus1_{s_number}'])
        # Calculate A (log2 average) and M (log2 ratio)
        tpm_matrix['A'] = (tpm_matrix[f'logoflog2plus1_{s_numbers[0]}'] + tpm_matrix[f'logoflog2plus1_{s_numbers[1]}']) / 2
        tpm_matrix['M'] = tpm_matrix[f'logoflog2plus1_{s_numbers[0]}'] - tpm_matrix[f'logoflog2plus1_{s_numbers[1]}']

    else:
           # Get the log2 of the TPM values for each replicate
        for s_number in s_numbers:
            tpm_matrix[f'log2_{s_number}'] = np.log2(tpm_matrix[s_number])

        # Calculate A (log2 average) and M (log2 ratio)
        tpm_matrix['A'] = (tpm_matrix[f'log2_{s_numbers[0]}'] + tpm_matrix[f'log2_{s_numbers[1]}']) / 2
        tpm_matrix['M'] = tpm_matrix[f'log2_{s_numbers[0]}'] - tpm_matrix[f'log2_{s_numbers[1]}']

    # Create bins of size 1 for A
    tpm_matrix['A_bin'] = np.floor(tpm_matrix['A']).astype(int)
    # Print the range of values of A
    print(f'The range of A values is from {tpm_matrix["A"].min()} to {tpm_matrix["A"].max()}')
    # Create the plot with box plots for each bin of A
    fig, ax = plt.subplots(figsize=(5.7, 5.7), dpi=900)
    sns.boxplot(x='A_bin', y='M', data=tpm_matrix, ax=ax, boxprops=dict(facecolor='#0f62fe', edgecolor='#6f6f6f',)) #blue60
    ax.axhline(y=1, color='#c6c6c6', linestyle='--', zorder=10) # grey30 
    ax.axhline(y=-1, color='#c6c6c6', linestyle='--', zorder=20)
    # Add vertical line at a = -1 as log2(0.5) = -1
    xticks = sorted(tpm_matrix['A_bin'].unique())
    try:
        x_pos = xticks.index(-1)
        ax.axvline(x=x_pos, color='#da1e28', linestyle='--', zorder=30) # red60
    except ValueError:
        print("No A_bin = -1 in the data.")

    ax.set_xlabel('A (Log2 Average)', fontsize=20)
    ax.set_ylabel('M (Log2 Ratio)', fontsize=20)
    ax.set_yticks(np.linspace(-6, 6, num=7))  
    tick_positions = np.linspace(0, len(xticks) - 1, 6, dtype=int)  # 6 positions across index range
    tick_labels = [xticks[i] for i in tick_positions]  # Get actual bin values for these positions
    ax.set_xticks(tick_positions)
    ax.set_xticklabels(tick_labels, fontsize=20)
    ax.tick_params(axis='y', labelsize=20)
    ax.tick_params(axis='x', labelsize=20)
    ax.set_title(title, fontsize=20)
    sns.despine()
    plt.tight_layout()
    fig.savefig(out_file_path, dpi=900)



def filter_for_stable_genes(merged,output_data_path,log=False):
    #Input = merged average expression matrixes from the two experiments
    print(f'There are {merged.shape[0]} genes in the merged matrix')
    
    merged = merged.set_index('Gene') # Turn column Gene into the index
    # Calc std dev on the Mean_expression_huang and Mean_expression_wang columns
    
    std_dev = merged.std(axis=1)  # Standard Deviation
    mean_exp = merged.mean(axis=1)  # Mean Expression
    cv = std_dev / mean_exp  # Coefficient of Variation
    mad = median_abs_deviation(merged, axis=1)  # Median Absolute Deviation

    
    print(f'merged dataset has the dimensions {merged.shape} and looks like {merged.head()}')
    print('Standard Deviation \n', std_dev.head())
    print('Mean Expression \n', mean_exp.head())
    print('Coefficient of Variation \n', cv.head())
    print('Median Absolute Deviation \n', pd.Series(mad, index=merged.index).head())

    stability_df = pd.DataFrame({
        "Mean_Expression": mean_exp,
        "Std_Dev": std_dev,
        "CV": cv,
        "MAD": mad,
    })
    #stable_genes = stability_df[
    #    (stability_df["Std_Dev"] < stability_df["Std_Dev"].median()) &
    #    (stability_df["CV"] < 0.2)] #&
    #    (stability_df["MAD"] < stability_df["MAD"].median()) &
    #    (stability_df["Mean_Expression"] > 0.5)]

    # for loop that applies different filteres to the stability_df and plots them stability_df["Std_Dev"] < stability_df["Std_Dev"].median(), (stability_df["CV"] < 0.2) e.c.t
    filters = ["Std_Dev < Std_Dev.median()", "CV < 0.2", "MAD < MAD.median()", "Mean_Expression > 0.5"]
    for filter in filters:
        stable_genes = stability_df.query(filter)
        print(f'By filtering the dataset by {filter} we have reduced the dataset from {stability_df.shape[0]} genes to {stable_genes.shape[0]} genes')

        stable_genes_df = merged.loc[stable_genes.index]
        pearson_corr_all, p_value_all = pearsonr(merged['Mean_expression_huang'], merged['Mean_expression_wang'])
        pearson_corr_stable, p_value_stable = pearsonr(stable_genes_df['Mean_expression_huang'], stable_genes_df['Mean_expression_wang'])
        fig, ax = plt.subplots(figsize=(5.7, 5.7))
        if log:
            ax.set_xscale("log")
            ax.set_yscale("log")

        ax.scatter(merged['Mean_expression_huang'], merged['Mean_expression_wang'], color='grey', s=10)
        ax.scatter(stable_genes_df['Mean_expression_huang'], stable_genes_df['Mean_expression_wang'], color='blue', s=10)
        ax.set_xlabel('Mean Expression Huang')
        ax.set_ylabel('Mean Expression Wang')
        ax.set_title(f'Stable Genes Scatter Plot: {filter}')

        ax.text(0.001, 10000, f'Pearson All r = {pearson_corr_all:.4f}', horizontalalignment='left', verticalalignment='top', fontsize=12, color='black')
        ax.text(0.001, 5623, f'Pearson stable = {pearson_corr_stable:.4f}', horizontalalignment='left', verticalalignment='top', fontsize=12, color='black')
        ax.text(0.001, 3200, f'Number of stable genes = {stable_genes.shape[0]}', horizontalalignment='left', verticalalignment='top', fontsize=12, color='black')
        file_path = output_data_path + f'stable_genes_scatter{filter[:2]}.png'
        plt.savefig(file_path, dpi=900)
        print(f'Figure saved to {file_path}')
    # save stable_genes = stability_df.query(filter) "CV < 0.2" to a csv file 
    stable_genes.to_csv(f'{output_data_path}/stable_genes_cv.tsv', sep='\t')


def violin_plot_filtered_(experiment_1, output_plot_name, filter_threshold=0.5):
    # Average the expression values across the replicates
    # Filter expresion 
    # log2(x+1) transform 
    # Plot violin plot of the filtered expression values   
    df = experiment_1['average_matrix'].copy()
    df = df[df['Mean_expression'] > filter_threshold]
    df['log2plus1'] = np.log2(df['Mean_expression'] + 1)
    fig, axes = plt.subplots(nrows=2, ncols=1, figsize=(5.7, 5.7), sharey=True, dpi=900)

    # Raw TPM violin
    sns.violinplot(x=df['Mean_expression'], ax=axes[0], color='#d4bbff') # Purple 30
    axes[0].set_xlabel("TPM", fontsize=20)
    

    # log2(x+1) violin
    sns.violinplot(x=df['log2plus1'], ax=axes[1], color='#3ddbd9') # Teal 30
    axes[1].set_xlabel("log₂(TPM + 1)", fontsize=20)

    for ax in axes:
        ax.grid(True, linestyle='--', alpha=0.5)
        ax.tick_params(axis='x', labelsize=20)


    sns.despine()
    plt.tight_layout()
    plt.savefig(output_plot_name, dpi=900)
    plt.close()
    print(f"Violin plot saved to {output_plot_name}")


if __name__ == "__main__":
    huang_bn = 'PRJNA751745'
    wang_bn = 'PRJNA657728'
    input_data_path = str(sys.argv[1]) 
    output_data_path = str(sys.argv[2]) 
    tissue = 'leaf'

    huang = generate_experiment_dict('PRJNA751745', 'leaf', 'Huang et al., 2022', input_data_path)
    wang = generate_experiment_dict('PRJNA657728', 'leaf', 'Wang et al., 2021', input_data_path)

    #ma_plot_boxplot(huang, f'{output_data_path}/huang_ma_box_plot.png', title='', transform=False)

    #ma_plot_boxplot(wang, f'{output_data_path}/wang_ma_box_plot.png', title='', transform=False)
        # Save the average expression matricies 
    #huang_average = (huang['average_matrix']).to_csv(f'{output_data_path}/average_huang_TPM.tsv', index=False, sep = '\t')
    #wang_average = (wang['average_matrix']).to_csv(f'{output_data_path}/average_wang_TPM.tsv', index=False, sep = '\t')
    #plot_replicates(wang['tpm_matrix'], wang['s_numbers'][0], wang['s_numbers'][1], f'{output_data_path}scatter_wang.png', log=True)
    #plot_replicates(huang['tpm_matrix'], huang['s_numbers'][0], huang['s_numbers'][1], f'{output_data_path}scatter_huang.png', log=True)
    plot_different_experiments_with_thresholds(huang, wang, f'{output_data_path}scatter_wang_against_huang.png', log=True)
    #plot_different_experiments_with_thresholds(huang, wang, f'{output_data_path}scatter_wang_against_huang.png', log=True)

    #merged_matrix = pd.merge(huang['average_matrix'], wang['average_matrix'], on='Gene', suffixes=('_huang', '_wang'))
    #filter_for_stable_genes(merged_matrix, output_data_path, log=True)

    violin_plot_filtered_(wang, f'{output_data_path}/wang_violin_plot.png')

