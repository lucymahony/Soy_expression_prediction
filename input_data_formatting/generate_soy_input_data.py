# This script creates the input data for the LLM e.g.
# sequence, label
# AAGGCCCA, 0.677

from tqdm import tqdm
from Bio import SeqIO
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import sys 
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import MinMaxScaler
from process_rna_seq_data import tpm_matrix, average_expression_matrix, get_s_numbers
import numpy as np


def parse_fasta(fasta_file_path):
    """
    :param fasta_file: Fasta file path
    :return: A dictionary of gene ids as keys and the sequences as values
    """
    fasta_dict = {}
    for record in SeqIO.parse(fasta_file_path, 'fasta'):
        gene_id = record.id
        sequence = str(record.seq)
        fasta_dict[gene_id] = sequence
    return fasta_dict


def parse_fasta_transcripts(fasta_file_path):
    """
    :param fasta_file: Fasta file path
    :return: A dictionary of gene ids as keys and the sequences as values
    """
    fasta_dict = {}
    for record in SeqIO.parse(fasta_file_path, 'fasta'):
        gene_id = record.id # Split at the second . and take the first section
        gene_id = '.'.join(gene_id.split('.', 2)[:2])# Stop at the second . ID=Glyma.U005100.
        sequence = str(record.seq)
        fasta_dict[gene_id] = sequence
    return fasta_dict


def filter_average_expression_dataset(df, threshold=1):
    """
    Filters the average expression matrix to only include transcripts where the expression is above the threshold
    Input 
    df: columns should be ['Gene', 'Mean_expression']
    threshold: Minimum number of mean transcripts per million 
    Output 
    Filtered df
    """
    # Filter points based on threshold
    mask = (df['Mean_expression'] >= threshold) 
    df_filtered = df[mask]
    print(f'Filtering the mean expression dataset with the threshold {threshold} TPM reduced the dataset size from {df.shape[0]} to {df_filtered.shape[0]}')
    return df_filtered

def log2_transform(df):
    """
    Log2 transform the expression values
    :return: The log2 transformed dataframe
    """
    df.loc[:, 'Mean_expression_log2'] = df['Mean_expression'].apply(lambda x: np.log2(x))
    return df


def check_log2_transformed_thresholded_df(df):
    """
    The average expression is above 0.5 TPM and the log2 transformation is applied so the values must be above -1
    log2(0.5) = -1
    """
    print(df['Mean_expression_log2'].min())
    print(df['Mean_expression_log2'].max())
    print(df.columns)
    print(df.head())
    print(df.describe())
    if df['Mean_expression_log2'].min() < -1:
        raise ValueError('The log2 transformation has not worked correctly as the minimum value is below -1')
    else:
        print('The log2 transformation has worked correctly')


def split_datasets(df, random_state):
    """
    Split the circadian data into the train, dev, and test set. 90% of the data is used for training
    :return: List of transcripts for the train, dev, and test set
    """
    temp, test = train_test_split(df, test_size=0.1, random_state=random_state)
    train, dev = train_test_split(temp, test_size=0.1, random_state=random_state)
    return train, dev, test


def write_promoter_and_transcript_to_csv(df, y_column, promoter_dictionary, transcript_dictionary, output_file_names, random_state, prom_name_ending):
    """
    Split the transcripts into the three different datasets and write to a csv file.
    Get the promoter and transcript sequences and write to a csv file.
    The label is the expression scalled between 0 and 1, The scalling is performed independently in test dev and train to prevent data leakage 
    :return: None
    """
    X_train, X_dev, X_test = split_datasets(df, random_state)
    datasets = {'X_train': X_train, 'X_dev': X_dev, 'X_test': X_test}
    missing_prom_count = 0
    missing_transcript_count = 0

    for dataset_name, dataset in datasets.items():
        print(dataset.columns)
        print(f'For dataset {dataset_name} the head is:', dataset.head())
        with open(output_file_names[dataset_name], 'w') as f:
            f.write('sequence,label\n')
            list_transcripts = dataset['Gene']
            for transcript in tqdm(list_transcripts.to_list()):
                promoter_name = transcript + prom_name_ending

                if promoter_name not in promoter_dictionary:
                    missing_prom_count += 1
                if transcript not in transcript_dictionary:
                    missing_transcript_count += 1

                if promoter_name in promoter_dictionary and transcript in transcript_dictionary:
                    
                    sequence = promoter_dictionary[promoter_name] + transcript_dictionary[transcript]
                    expression_value = dataset.loc[dataset['Gene'] == transcript, y_column].values[0]
                    f.write(f"{sequence},{expression_value}\n")
        print(f'Finished writing {dataset_name} to csv')
    print(f"Number of missing promoters: {missing_prom_count}")
    print(f"Number of missing transcripts: {missing_transcript_count}")


def determine_max_sequence_length(file_paths):
    """
    input: a list of the file paths e.g. [train_file_path, dev_file_path, test_file_path]
    :return: The maximum sequence length
    """
    max_lengths = []
    means = []
    std_devs = []

    for file_path in file_paths:
        df = pd.read_csv(file_path)
        lengths = df['sequence'].apply(len)
        max_lengths.append(lengths.max())
        means.append(lengths.mean())
        std_devs.append(lengths.std())

    max_length = max(max_lengths)
    print(f"The maximum sequence length is: {max_length}")
    print(f"The mean of the sequence lengths is: {means}")
    print(f"The standard deviation of the sequence lengths is: {std_devs}")
    
    return max_length



def plot_range_of_expression_values(file_paths, out_file_path):
    """
    Input: Dictionary containinng the file_paths to the csvs of train dev test
    Returns, saves a plot of the range in expression values 'label'
    """
    df1 = pd.read_csv(file_paths['X_train'])
    df2 = pd.read_csv(file_paths['X_dev'])
    df3 = pd.read_csv(file_paths['X_test'])
    print(df1.shape, df2.shape, df3.shape)
    print(df1.columns)
    means = [df['label'].mean() for df in [df1, df2, df3]]
    stds = [df['label'].std() for df in [df1, df2, df3]]
    
    # Print mean and standard deviation
    for i, (mean, std) in enumerate(zip(means, stds), 1):
        print(f"DataFrame {i}: Mean = {mean}, Standard Deviation = {std}")
    
    # Combine the dataframes for plotting
    combined_df = pd.concat([df1[['label']].assign(Dataset='Train'),
                             df2[['label']].assign(Dataset='Validation'),
                             df3[['label']].assign(Dataset='Test')],
                            axis=0)
    # Plotting
    plt.figure(figsize=(5.7, 5.7), dpi=900)
    colours = {'Train': '#da1e28', 'Validation': '#8a3ffc', 'Test': '#0072c3'}
    sns.boxplot(x='Dataset', y='label', data=combined_df, palette=colours)
    min_y = plt.ylim()[0] 
    for i in range(len(means)):
        plt.text(i, min_y +0.2, f"{means[i]:.2f} ± {stds[i]:.2f}", ha='center', fontsize=8)
    plt.title('Log2 Expression Values', fontsize=11)
    plt.ylabel('Expression values (Log2)', fontsize=11)
    plt.xlabel('', fontsize=11)
    plt.savefig(out_file_path, dpi=900)


def plot_after_min_max_normalisation(file_paths, out_file_path):
    """
    """
    scaler = MinMaxScaler()
    df1 = pd.read_csv(file_paths['X_train'])
    df2 = pd.read_csv(file_paths['X_dev'])
    df3 = pd.read_csv(file_paths['X_test'])
    # Scale the labels of the dfs
    df1['label'] = scaler.fit_transform(df1[['label']])
    df2['label'] = scaler.transform(df2[['label']])
    df3['label'] = scaler.transform(df3[['label']])
    means = [df['label'].mean() for df in [df1, df2, df3]]
    stds = [df['label'].std() for df in [df1, df2, df3]]
    
    # Print mean and standard deviation
    for i, (mean, std) in enumerate(zip(means, stds), 1):
        print(f"DataFrame {i}: Mean = {mean}, Standard Deviation = {std}")
    
    # Combine the dataframes for plotting
    combined_df = pd.concat([df1[['label']].assign(Dataset='Train'),
                             df2[['label']].assign(Dataset='Validation'),
                             df3[['label']].assign(Dataset='Test')],
                            axis=0)
    # Plotting
    plt.figure(figsize=(5.7, 5.7), dpi=900)
    colours = {'Train': '#da1e28', 'Validation': '#8a3ffc', 'Test': '#0072c3'}
    sns.boxplot(x='Dataset', y='label', data=combined_df, palette=colours)
    min_y = plt.ylim()[0] 
    for i in range(len(means)):
        plt.text(i, min_y +0.02, f"{means[i]:.2f} ± {stds[i]:.2f}", ha='center', fontsize=8)
    plt.title('Log2 Expression Values after Min Max Scaler', fontsize=11)
    plt.ylabel('Scaled expression values (Log2)', fontsize=11)
    plt.xlabel('', fontsize=11)
    plt.savefig(out_file_path, dpi=900)

def main():
    distance_upstream = int(sys.argv[1])
    distance_downstream = int(sys.argv[2])
    random_state = int(sys.argv[3])

    transcript_dictionary = parse_fasta_transcripts(str(sys.argv[4]))
    promoter_dictionary = parse_fasta(str(sys.argv[5])) # Note the transcripts in the .fa file are named like _prom_{distance_upstream} 

    metadata_path = str(sys.argv[6])
    tpm_path = str(sys.argv[7])
    tissue = str(sys.argv[8])
    output_file_directory = str(sys.argv[9])
    output_file_names = {'X_train': f'{output_file_directory}soy_{distance_upstream}up_{distance_downstream}down_{random_state}_log2/train.csv',
                         'X_dev': f'{output_file_directory}soy_{distance_upstream}up_{distance_downstream}down_{random_state}_log2/dev.csv',
                         'X_test': f'{output_file_directory}soy_{distance_upstream}up_{distance_downstream}down_{random_state}_log2/test.csv'}

    s_numbers = get_s_numbers(metadata_path, tissue)
    matrix = tpm_matrix(tpm_path)
    average = average_expression_matrix(matrix, s_numbers) 
    expression_df = average # Columns are ['Gene', 'Mean_expression']
    expression_df_filtered = filter_average_expression_dataset(expression_df, threshold=0.5)
    expression_df_filtered = log2_transform(expression_df_filtered)
    check_log2_transformed_thresholded_df(expression_df_filtered)
    write_promoter_and_transcript_to_csv(expression_df_filtered, 'Mean_expression_log2', promoter_dictionary, transcript_dictionary, output_file_names, random_state, f'_prom_{distance_upstream}')
    determine_max_sequence_length(output_file_names.values())
    plot_range_of_expression_values(output_file_names, f'{str(sys.argv[10])}normalised_expression_values_wang.png')
    plot_after_min_max_normalisation(output_file_names, f'{str(sys.argv[10])}normalised_expression_values_wang_min_max_scaler.png')    

if __name__ == "__main__":
    main()
    # Filtering the mean expression dataset with the threshold 1 TPM reduced the dataset size from 52837 to 29971
    #The maximum sequence length is: 18432
    #The mean of the sequence lengths is: [3424.478393408857, 3458.29280948851, 3462.1000667111407]
    #The standard deviation of the sequence lengths is: [1178.332280832869, 1258.1119772813372, 1174.0035245271902]
    #(24275, 2) (2698, 2) (2998, 2)
    #Index(['sequence', 'label'], dtype='object')
    #DataFrame 1: Mean = 0.0018537544703770134, Standard Deviation = 0.015790488241157863
    #DataFrame 2: Mean = 0.004037938156329753, Standard Deviation = 0.026231881861027574
    #DataFrame 3: Mean = 0.008792021178505872, Standard Deviation = 0.03951655364061851

