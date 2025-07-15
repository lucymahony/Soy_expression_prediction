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
import os


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



def plot_interquartile_range_average_expression(df, plot_file_path):
    """
    Plots IQR of the average TPM expression with violin and box plots as two distinct lines on one subplot.
    Parameters:
    - df (pd.DataFrame): DataFrame with columns 'Gene' and 'Mean_expression'.
    - plot_file_path (str): Path to save the resulting plot.
    Output:
    - Saves the plot as a file at the specified path.
    """

    q1 = df['Mean_expression'].quantile(0.25)
    q3 = df['Mean_expression'].quantile(0.75)

    plt.figure(figsize=(5.7, 4), dpi=900)

    # Violin plot (adjusted position using y-coordinates)
    sns.violinplot(
        x=df['Mean_expression'], 
        y=[1] * len(df),  # Position the violin on a specific y-axis line
        color="#8a3ffc")

    # Box plot (adjusted position using y-coordinates)
    sns.boxplot(
        x=df['Mean_expression'], 
        y=[0] * len(df),  # Position the box plot on a different y-axis line
        color="#be95ff")

    # Annotate Q1 and Q3 on the box plot
    plt.annotate(f"Q1: {q1:.2f}", xy=(q1, 0), xytext=(q1, -0.2),
                 textcoords="offset points", ha='center', color='blue', fontsize=9)
    plt.annotate(f"Q3: {q3:.2f}", xy=(q3, 0), xytext=(q3, -0.2),
                 textcoords="offset points", ha='center', color='green', fontsize=9)

    # Formatting the plot
    plt.xscale('log')
    plt.xlabel("Mean Expression (TPM)", fontsize=11)
    plt.title("Wang Gene Expresison Distribution", fontsize=11)
    plt.tight_layout()
    # Save the plot
    plt.savefig(plot_file_path, dpi=900)
    plt.close()
    print(f"Plot saved to {plot_file_path}")




def filter_average_expression_dataset(df, lower_threshold=None, upper_threshold=None):
    """
    Filters the average expression matrix to only include transcripts where the expression is above the lower threshold and less that the upper threshold OR EQUAL TO. 

    Input 
    Parameters:
    - df (pd.DataFrame): DataFrame with columns 'Gene' and 'Mean_expression'.
    - lower_threshold (float, optional): Minimum mean expression (inclusive). Default is None (no lowwer limit).
    - upper_threshold (float, optional): Maximum mean expression (inclusive). Default is None (no upper limit).

    Returns:
    - pd.DataFrame: Filtered DataFrame.

    """
    initial_size = df.shape[0]

    if lower_threshold is not None:
        df = df[df['Mean_expression'] >= lower_threshold]
        print(f"Applied lower threshold ({lower_threshold}) TPM: Size = {initial_size} -> {df.shape[0]}")
    

    if upper_threshold is not None:
        initial_size = df.shape[0]
        df = df[df['Mean_expression'] <= upper_threshold]
        print(f"Applied upper threshold ({upper_threshold}) TPM: Size = {initial_size} -> {df.shape[0]}")
    
    return df

def filter_average_expression_dataset_by_cv(df):
    """
    Filters the average expression matrix to only include transcripts the coefficient of variation is less than 0.2
    Input 
    Parameters:
    - df (pd.DataFrame): DataFrame with columns 'Gene' and 'Mean_expression'.

    Returns:
    - pd.DataFrame: Filtered DataFrame.

    """
    initial_size = df.shape[0]

    df['CV'] = df['Mean_expression'].std() / df['Mean_expression'].mean()
    print(df.head())
    df = df[df['CV'] < 0.2]
    print(f"Applied CV filter: Size = {initial_size} -> {df.shape[0]}")
    exit()
    return df


def log2plus1_transform(df):
    """
    Log2 transform the expression values
    :return: The log2 transformed dataframe
    """
    df.loc[:, 'Mean_expression_log2plus1'] = df['Mean_expression'].apply(lambda x: np.log2(x+1))
    return df


def check_log2plus1_transformed_thresholded_df(df, lower_threshold=None, upper_threshold=None):
    """
    Check that once logged the datasets fall within the expected ranges as set by the thresholds. 
    Prints generable information describing df then check it falls within the logged thresholds. 
    """
    print(df['Mean_expression_log2plus1'].min())
    print(df['Mean_expression_log2plus1'].max())
    print(df.columns)
    print(df.head())
    print(df.describe())

    if lower_threshold is not None:
        logged_lower = np.log2(lower_threshold+1)
        if df['Mean_expression_log2plus1'].min() < logged_lower:
            raise ValueError(f"Log2 transformation error: Minimum value is below {logged_lower}")
        print("Lower threshold validation passed.")

    if upper_threshold is not None:
        logged_upper = np.log2(upper_threshold+1)
        if df['Mean_expression_log2plus1'].min() > logged_upper:
            raise ValueError(f"Log2 transformation error: Maximum value is above {logged_upper}")
        print("Upper threshold validation passed.")




def split_datasets(df, random_state):
    """
    Split the circadian data into the train, dev, and test set. 90% of the data is used for training
    :return: List of transcripts for the train, dev, and test set
    """
    print(f'Size of DataFrame before splitting: {df.shape[0]} rows')

    if df.empty:
        raise ValueError("The filtered DataFrame is empty. Please check the filtering criteria.")

    temp, test = train_test_split(df, test_size=0.1, random_state=random_state)
    train, dev = train_test_split(temp, test_size=0.1, random_state=random_state)
    return train, dev, test



def write_promoter_and_transcript_to_csv(df, y_column, promoter_dictionary, transcript_dictionary, output_file_names, random_state, prom_name_ending, promoter_only,  expected_length):
    """
    Writes promoter and/or transcript sequences with expression labels to CSVs for training.
    Splits into train/dev/test and scales labels independently to prevent data leakage.
    """
    if promoter_only:
        print("Promoter only mode is enabled. Only promoter sequences will be written to the CSV files.")

    print(f'The size of the DataFrame is: {df.shape[0]}')
    X_train, X_dev, X_test = split_datasets(df, random_state)
    datasets = {'X_train': X_train, 'X_dev': X_dev, 'X_test': X_test}

    missing_prom_count = 0
    missing_transcript_count = 0

    for dataset_name, dataset in datasets.items():
        print(f'For dataset {dataset_name}, the head is:\n', dataset.head())

        # Ensure output directory exists
        output_dir = os.path.dirname(output_file_names[dataset_name])
        os.makedirs(output_dir, exist_ok=True)

        with open(output_file_names[dataset_name], 'w') as f:
            f.write('sequence,label\n')
            list_transcripts = dataset['Gene']

            for transcript in tqdm(list_transcripts.to_list()):
                promoter_name = transcript + prom_name_ending

                if promoter_name not in promoter_dictionary:
                    missing_prom_count += 1
                    continue

                if promoter_only:
                    sequence = promoter_dictionary[promoter_name]
                    if sequence is None:
                        print(f"Sequence for {transcript} is None")
                        continue
                    if len(sequence) != expected_length:
                        print(f"Skipping {transcript}: promoter length = {len(sequence)} (expected {expected_length})")
                        continue
                else:
                    if transcript not in transcript_dictionary:
                        missing_transcript_count += 1
                        continue
                    sequence = promoter_dictionary[promoter_name] + transcript_dictionary[transcript]
                    if sequence is None:
                        print(f"Sequence for {transcript} is None")
                        continue

                # Write valid record
                expression_value = dataset.loc[dataset['Gene'] == transcript, y_column].values[0]
                f.write(f"{sequence},{expression_value}\n")

    print(f'Finished writing datasets to CSV.')
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
        malformed = df[df['sequence'].isna()]
        print(f"Found {len(malformed)} malformed sequences in {file_path}")
        # remove malformed sequences
        df = df.dropna(subset=['sequence'])
        
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
    plt.ylabel('Expression values (Log2 +1)', fontsize=11)
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
    transcript_dictionary_path=str(sys.argv[4])
    promoter_dictionary_path=str(sys.argv[5])
    metadata_path = str(sys.argv[6])
    tpm_path = str(sys.argv[7])
    tissue = str(sys.argv[8])
    output_file_directory = str(sys.argv[9])
    plot_file_path=str(sys.argv[10])
    filtering_method = str(sys.argv[11])  # "threshold" or "cv"
    lower_threshold = None if sys.argv[12] == "None" else float(sys.argv[12])
    upper_threshold = None if sys.argv[13] == "None" else float(sys.argv[13])
    promoter_only = False if sys.argv[14] == "False" else True

    transcript_dictionary = parse_fasta_transcripts(transcript_dictionary_path)
    promoter_dictionary = parse_fasta(promoter_dictionary_path) # Note the transcripts in the .fa file are named like _prom_{distance_upstream} 
    # Check dicts read in correctly
    if not promoter_dictionary:
        raise ValueError(f"No promoters loaded from {promoter_dictionary_path}")
    if not transcript_dictionary:
        raise ValueError(f"No transcripts loaded from {transcript_dictionary_path}")
    print(f"Loaded {len(promoter_dictionary)} promoters")
    print(f"Loaded {len(transcript_dictionary)} transcripts")

    output_file_names = {'X_train': f'{output_file_directory}/soy_{distance_upstream}up_{distance_downstream}down_{random_state}_log2plus1/train.csv',
                         'X_dev': f'{output_file_directory}/soy_{distance_upstream}up_{distance_downstream}down_{random_state}_log2plus1/dev.csv',
                         'X_test': f'{output_file_directory}/soy_{distance_upstream}up_{distance_downstream}down_{random_state}_log2plus1/test.csv'}
    s_numbers = get_s_numbers(metadata_path, tissue)
    matrix = tpm_matrix(tpm_path)
    average = average_expression_matrix(matrix, s_numbers) 
    expression_df = average # Columns are ['Gene', 'Mean_expression']
    #plot_interquartile_range_average_expression(expression_df, f'{plot_file_path}IQR_average_TPM.png')
    if filtering_method == "threshold":
        expression_df_filtered = filter_average_expression_dataset(expression_df, lower_threshold, upper_threshold)
        expression_df_filtered = log2plus1_transform(expression_df_filtered)
        check_log2plus1_transformed_thresholded_df(expression_df_filtered, lower_threshold, upper_threshold)
    elif filtering_method == "cv":
        expression_df_filtered = pd.read_csv('/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/stable_genes_cv.tsv', sep='\t')
        stable_genes = expression_df_filtered.query("CV < 0.2")
        print('stable_genes head', stable_genes.head())
        # rename column Mean_Expression to Mean_expression
        stable_genes = stable_genes.rename(columns={'Mean_Expression': 'Mean_expression'})
        expression_df_filtered = log2plus1_transform(stable_genes)
        print('expression_df_filtered head', expression_df_filtered.head())

    else:
        raise ValueError("Invalid filtering method. Choose 'threshold' or 'cv'")
    
    expected_length = distance_upstream + distance_downstream
    write_promoter_and_transcript_to_csv(expression_df_filtered, 'Mean_expression_log2plus1', promoter_dictionary, transcript_dictionary, output_file_names, random_state, f'_prom_up{distance_upstream}_down{distance_downstream}', promoter_only, expected_length)
    determine_max_sequence_length(output_file_names.values())
    plot_range_of_expression_values(output_file_names, f'{plot_file_path}normalised_expression_values_wang.png')
    plot_range_of_expression_values(output_file_names, f'{plot_file_path}normalised_expression_values_wang_min_max_scaler.png')    

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

