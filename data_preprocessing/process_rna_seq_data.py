# This script process data from the Soy expression atlas. https://soyatlas.venanciogroup.uenf.br/
# It plots the TPM values for each transcripts replicates from the same paper against each other and between papers. 

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
    Plot the averages of expression matrix 1 against expression matrix 2.
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
        raise ValueError('The number of genes in the expression matrices are not the same')
    # Check the columns 'Gene' in both are the same.
    if not mean_1['Gene'].equals(mean_2['Gene']):
        raise ValueError('The column Gene in the two expression matrices are not the same')
    
    # Filter points based on threshold
    mask = (x >= threshold) & (y >= threshold)
    x_filtered = x[mask]
    y_filtered = y[mask]

    # Calculate Pearson correlation
    pearson_corr, p_value = pearsonr(x_filtered, y_filtered)
    # Calculate the number of points above and below the threshold
    points_above_threshold = mask.sum()
    points_below_threshold = len(mask) - points_above_threshold

    fig, ax = plt.subplots(figsize=(5.7, 5.7))
    sns.regplot(x=x_filtered, y=y_filtered, ci=None, ax=ax, scatter_kws={"color": "royalblue", 's': 10}, line_kws={"color": "navy", "lw": 1})
    ax.scatter(x[~mask], y[~mask], color='grey', s=10, label='Below threshold') # unfiltered points in grey
    ax.axhline(threshold, color='red', linestyle='dotted', lw=2)
    ax.axvline(threshold, color='red', linestyle='dotted', lw=2)

    ax.grid(False)
    if log:
        ax.set_xscale("log")
        ax.set_yscale("log")

    ax.set_xlabel(experiment_1['name'] + ' expression values (TPM)')
    ax.set_ylabel(experiment_2['name'] + ' expression values (TPM)')
    plt.title('Expression Values of ' + str(experiment_1['name']) + ', plotted against ' + str(experiment_2['name']))
    
    ax.text(0.001, 10000, f'Pearson r = {pearson_corr:.2f}', horizontalalignment='left', verticalalignment='top', fontsize=12, color='black')
    ax.text(0.001, 5623, f'Above threshold = {points_above_threshold}', horizontalalignment='left', verticalalignment='top', fontsize=12, color='black')
    ax.text(0.001, 3200, f'Below threshold = {points_below_threshold}', horizontalalignment='left', verticalalignment='top', fontsize=12, color='black')

    plt.savefig(out_file_path, dpi=900)



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
                  'average_matrix': average}
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
    

def ma_plot_boxplot(experiment_dict, out_file_path, title='MA plot'):
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
    tpm_matrix = tpm_matrix.copy()

    # Remove any rows with 0 TPM values
    tpm_matrix = tpm_matrix[(tpm_matrix[experiment_dict['s_numbers'][0]] > 0) & (tpm_matrix[experiment_dict['s_numbers'][1]] > 0)]

    s_numbers = experiment_dict['s_numbers']
    # Check that there are only 2 replicates
    if len(s_numbers) != 2:
        raise ValueError('This function is only for plotting 2 replicates')

    # Get the log2 of the TPM values for each replicate
    for s_number in s_numbers:
        tpm_matrix[f'log2_{s_number}'] = np.log2(tpm_matrix[s_number])

    # Calculate A (log2 average) and M (log2 ratio)
    tpm_matrix['A'] = (tpm_matrix[f'log2_{s_numbers[0]}'] + tpm_matrix[f'log2_{s_numbers[1]}']) / 2
    tpm_matrix['M'] = tpm_matrix[f'log2_{s_numbers[0]}'] - tpm_matrix[f'log2_{s_numbers[1]}']

    # Create bins of size 1 for A
    tpm_matrix['A_bin'] = np.floor(tpm_matrix['A']).astype(int)

    # Create the plot with box plots for each bin of A
    fig, ax = plt.subplots(figsize=(5.7, 5.7), dpi=900)
    sns.boxplot(x='A_bin', y='M', data=tpm_matrix, ax=ax, color='#0f62fe')
    ax.axhline(y=1, color='grey', linestyle='--', zorder=10)
    ax.axhline(y=-1, color='grey', linestyle='--', zorder=20)
    ax.set_xlabel('A (Log2 Average)', fontsize=11)
    ax.set_ylabel('M (Log2 Ratio)', fontsize=11)
    ax.set_yticks(np.linspace(-6, 6, num=7))   
    ax.set_title(title, fontsize=11)
    fig.savefig(out_file_path, dpi=900)




if __name__ == "__main__":
    huang_bn = 'PRJNA751745'
    wang_bn = 'PRJNA657728'
    input_data_path = str(sys.argv[1]) 
    output_data_path = str(sys.argv[2]) 
    tissue = 'leaf'

    huang = generate_experiment_dict('PRJNA751745', 'leaf', 'Huang et al., 2022', input_data_path)
    wang = generate_experiment_dict('PRJNA657728', 'leaf', 'Wang et al., 2021', input_data_path)

    ma_plot_boxplot(huang, f'{output_data_path}/huang_ma_box_plot.png', title='Huang Leaf Tissue MA plot')
    ma_plot_boxplot(wang, f'{output_data_path}/wang_ma_box_plot.png', title='Wang Leaf Tissue MA plot')

    # Save the average expression matricies 
    huang_average = (huang['average_matrix']).to_csv(f'{output_data_path}/average_huang_TPM.tsv', index=False, sep = '\t')
    wang_average = (wang['average_matrix']).to_csv(f'{output_data_path}/average_wang_TPM.tsv', index=False, sep = '\t')

    #plot_replicates(wang['tpm_matrix'], wang['s_numbers'][0], wang['s_numbers'][1], f'{output_data_path}scatter_wang.png', log=True)
    #plot_replicates(huang['tpm_matrix'], huang['s_numbers'][0], huang['s_numbers'][1], f'{output_data_path}scatter_huang.png', log=True)
    
    plot_different_experiments_with_thresholds(huang, wang, f'{output_data_path}scatter_wang_against_huang.png', log=True)



