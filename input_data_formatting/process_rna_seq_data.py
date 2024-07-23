# This script process data from the Soy expression atlas. https://soyatlas.venanciogroup.uenf.br/
# It plots the TPM values for each transcripts replicates from the same paper against each other and between papers. 

# Huang  = https://doi.org/10.1016/j.ygeno.2022.110364
# Wang = https://doi.org/10.1093/plcell/koab081  
# bn = The NCBI bioproject number
# s number is the biosample number e.g. SAMN15835458 



import pandas as pd
import matplotlib.pyplot as plt
import sys 


def get_s_numbers(metadata_file_path, tissue):
    """
    Returns the biosample numbers of a tissue as a list 
    e.g. 
    get_s_numbers(huang_2022_metadata, leaf) =  ['SAMN20525661', 'SAMN20525662', 'SAMN20525663', 'SAMN20525664'] 
    """
    metadata = pd.read_csv(metadata_file_path, sep='\t')
    bio_sample_numbers = metadata[metadata['Part'] == tissue]['BioSample'].to_list()
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
    fig, ax = plt.subplots(figsize=(10,10))
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

    # Check that there are the same genes in matrix 1 as matrix 2 
    # Check same number of rows in each 
    if mean_1.shape[0] != mean_2.shape[0]:
        raise ValueError('The number of genes in the expression matrixes are not the same')
    
    # Check the columns 'Gene' in both are the same. 
    if not mean_1['Gene'].equals(mean_2['Gene']):
        raise ValueError('The column Gene in the two expression matrixes are not the same ')
    
    # Now the tests have passed can plot the average expression value across the replicates in expression matrix 1 to matrix 2. 
    fig, ax = plt.subplots(figsize=(10,10))



    ax.scatter(mean_1['Mean_expression'], mean_2['Mean_expression'], color='blue')
    if log:
        ax.set_xscale("log")
        ax.set_yscale("log")

    # Add labels and title
    ax.set_xlabel(experiment_1['name']+ ' expression values (TPM)')
    ax.set_ylabel(experiment_2['name']+ ' expression values (TPM)')
    plt.title('Expression Values of ' + str(experiment_1['name']) + ', plotted against ' + str(experiment_2['name']) + '.')
    plt.grid(True)
    # Display the plot
    plt.savefig(out_file_path)


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
    print(f'This is the head of {name} expression matrix {matrix.head()}')
    average = average_expression_matrix(matrix, s_numbers) 
    experiment = {'name' : name, 
                  's_numbers': s_numbers,
                  'tpm_matrix': matrix,
                  'average_matrix': average}
    return experiment 


if __name__ == "__main__":
    huang_bn = 'PRJNA751745'
    wang_bn = 'PRJNA657728'
    input_data_path = str(sys.argv[1]) 
    output_data_path = str(sys.argv[2]) 
    tissue = 'leaf'

    huang = generate_experiment_dict('PRJNA751745', 'leaf', 'Huang et al., 2022', input_data_path)
    wang = generate_experiment_dict('PRJNA657728', 'leaf', 'Wang et al., 2021', input_data_path)

    # Save the average expression matricies 
    huang_average = (huang['average_matrix']).to_csv(f'{output_data_path}/average_huang_TPM.tsv', index=False, sep = '\t')
    wang_average = (wang['average_matrix']).to_csv(f'{output_data_path}/average_wang_TPM.tsv', index=False, sep = '\t')

    plot_replicates(wang['tpm_matrix'], wang['s_numbers'][0], wang['s_numbers'][1], f'{output_data_path}scatter_wang.png', log=True)
    plot_replicates(huang['tpm_matrix'], huang['s_numbers'][0], huang['s_numbers'][1], f'{output_data_path}scatter_huang.png', log=True)
    plot_different_experiments(huang, wang, f'{output_data_path}scatter_wang_against_huang.png', log=True)



