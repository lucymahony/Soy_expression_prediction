# This script creates the input data for the LLM e.g.
# sequence, label
# AAGGCCCA, 0.677

from tqdm import tqdm
from Bio import SeqIO
import pandas as pd

from sklearn.model_selection import train_test_split
from process_rna_seq_data import tpm_matrix, average_expression_matrix, get_s_numbers


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


def split_datasets(df, y_column, random_state):
    """
    Split the circadian data into the train, dev, and test set. 90% of the data is used for training
    :return: List of transcripts for the train, dev, and test set
    """
    X = df['Gene'] # Gene name 
    y = df[y_column] # Expression value 
    # Split into train and temporary test
    X_temp, X_test, y_temp, y_test = train_test_split(X, y, test_size=0.1, random_state=random_state)
    # Split the temporary test set into dev and test
    X_train, X_dev, y_train, y_dev = train_test_split(X_temp, y_temp, test_size=0.1, random_state=random_state)
    return X_train, X_dev, X_test


def write_promoter_and_transcript_to_csv(df, y_column, promoter_dictionary, transcript_dictionary, output_file_names, random_state, prom_name_ending):
    """
    Split the transcripts into the three different datasets and write to a csv file.
    Get the promoter and transcript sequences and write to a csv file.
    :return: None
    """

    X_train, X_dev, X_test = split_datasets(df, y_column, random_state)
    datasets = {'X_train': X_train.to_list(), 'X_dev': X_dev.to_list(), 'X_test': X_test.to_list()}
    missing_prom_count = 0
    missing_transcript_count = 0

    for dataset_name, dataset_list in datasets.items():
        with open(output_file_names[dataset_name], 'w') as f:
            f.write('sequence,label\n')
            for transcript in tqdm(dataset_list):
                promoter_name = transcript + prom_name_ending

                if promoter_name not in promoter_dictionary:
                    missing_prom_count += 1
                if transcript not in transcript_dictionary:
                    missing_transcript_count += 1
                    print(transcript)
                    exit()
                if promoter_name in promoter_dictionary and transcript in transcript_dictionary:
                    
                    sequence = promoter_dictionary[promoter_name] + transcript_dictionary[transcript]
                    expression_value = df[df['Gene'] == transcript]['Mean_expression'].values[0]
                    
                    f.write(f"{sequence},{expression_value}\n")


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




def main():
    distance_upstream = 1500
    distance_downstream = 0
    random_state = 42 

    transcript_dictionary = parse_fasta_transcripts('../../data/Gmax_508_Wm82.a4.v1.transcript.fa')

    promoter_dictionary = parse_fasta(f'promoters_{distance_upstream}up_{distance_downstream}down_soy.fa') # Note the transcripts in the .fa file are named like _prom_{distance_upstream} 

    metadata_path = '/home/u10093927/workspace/dagw/Soybean/data/PRJNA657728_metadata.tsv'
    tpm_path = '/home/u10093927/workspace/dagw/Soybean/data/PRJNA657728_TPM.tsv'
    tissue = 'leaf'
    output_file_names = {'X_train': f'../../rr/soy_train_circ_{distance_upstream}up_{distance_downstream}down_{random_state}.csv',
                         'X_dev': f'../../rr/soy_dev_circ_{distance_upstream}up_{distance_downstream}down_{random_state}.csv',
                         'X_test': f'../../rr/soy_test_circ_{distance_upstream}up_{distance_downstream}down_{random_state}.csv'}

    s_numbers = get_s_numbers(metadata_path, tissue)
    matrix = tpm_matrix(tpm_path)
    average = average_expression_matrix(matrix, s_numbers) 
    expression_df = average # Columns are ['Gene', 'Mean_expression']

    #write_promoter_and_transcript_to_csv(expression_df, 'Mean_expression', promoter_dictionary, transcript_dictionary, output_file_names, random_state, f'_prom_{distance_upstream}')

    determine_max_sequence_length(output_file_names.values())

if __name__ == "__main__":
    main()

