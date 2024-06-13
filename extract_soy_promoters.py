from tqdm import tqdm
import pandas as pd
from Bio import SeqIO
from Bio.SeqRecord import SeqRecord
from Bio.Seq import Seq
import logging

__doc__ = """
Script to extract promoter regions from Soy genes.
"""

def parse_gff3(gff3_file):
    """
    Returns a dictionary where the keys are the transcript with the value being a dictionary of {'chrom':  'start': 'end': 'strand': } for each transcript 

    """

    print('Parsing the soy gff file')
    transcripts = {}
        #  awk -F '\t' '{print $3}' /data/prod/Formatted/gene_model/GLYMA_Williams82_JGI_pseudomolecule_Wm82a4v1_cpmt_1_1_JGI_GM_a4v1_1_1  | sort | uniq -c | sort -nr)
        #  560910 exon
        #  516059 CDS
        #  107929 five_prime_UTR
        #   93760 three_prime_UTR
        #   86256 mRNA
        #   52872 gene
        #       1
        # Without those mentioned as being removed in the supplementary material (removing ncRNA, snoRNA and lncRNA’s)
    names_of_transcripts = ['mRNA']
    names_of_transcripts = [x.lower() for x in names_of_transcripts]
    with open(gff3_file, 'r', errors='ignore') as file:
        for line in file:
            if line.startswith('#') or line.startswith('\n'):
                continue
            parts = line.strip().split('\t')
            names_of_transcripts
            if parts[2].lower() in names_of_transcripts:
                # Stop at the second . ID=Glyma.U005100.
                transcript_id = [x for x in parts[8].split(';') if x.startswith('ID=')][0].split('=')[1]
                transcript_id = '.'.join(transcript_id.split('.', 2)[:2])# Stop at the second . ID=Glyma.U005100.
                transcripts[transcript_id] = {'chrom': parts[0], 'start': int(parts[3]), 'end': int(parts[4]),
                                                'strand': parts[6]}
    return transcripts


def extract_promoters_only(genome, gene_info_dict, gene_list,  distance_upstream, distance_downstream):
    """
    :param genome: The genome in fasta format
    :param gene_info_dict: A dict of gene_info_dict as keys and the chromosome, start, end, and strand as values
    :param gene_list: list of gene names to extract the promoters for
    :param distance_upstream: The length of the promoter upstream of the TSS 
    :param distance_downstream: The length of the promoter downstream of the TSS, this should be set to 0 if combining with transcript/gene as otherwise there might be
    repeated sections of the genome. 
    :return: A dictionary of gene ids as keys and the promoter sequences as values
    """

    
    gene_info_dict_filtered = {key: gene_info_dict[key] for key in gene_list if key in gene_info_dict}
    genome_seq = SeqIO.to_dict(SeqIO.parse(genome, 'fasta'))
    promoters = {}
    for gene_id, gene_info in tqdm(gene_info_dict_filtered.items()):
        if gene_info['strand'] == '-':
            start = gene_info['end'] - distance_downstream
            end = min(len(genome_seq[gene_info['chrom']]), gene_info['end'] + distance_upstream)
            chrom_seq = genome_seq[gene_info['chrom']]
            seq = chrom_seq.seq[start:end]
            rev_seq = seq.reverse_complement()
            promoters[gene_id] = str(rev_seq) # from Seq object to string
        else:

            start = max(1, gene_info['start'] - distance_upstream) - 1
            end = gene_info['start'] - 1 + distance_downstream
            promoters[gene_id] = genome_seq[gene_info['chrom']].seq[start:end]
    #print(f'The resulting dictionary of promoters is length {len(list(gene_info_dict_filtered.keys()))}')
    return promoters


def gene_list(file_path):
    df = pd.read_csv(file_path, sep='\t')
    gene_list = df['Gene'].to_list()
    return gene_list


def report_length_sequences(dict_of_sequences):
    """
    :param dict_of_sequences: A dictionary of sequences
    :return: A dictionary of gene ids as keys and the length of the sequence as values
    """
    total_leng = 0
    num_sequences = 0
    for gene_id, sequence in dict_of_sequences.items():
        total_leng += len(sequence)
        num_sequences += 1
    average_length = total_leng / num_sequences
    print(f'There is a total of {num_sequences} sequences in the dictionary')
    print(f'The average length of the sequences is {average_length} bp')


def write_fasta_file(sequences_dictionary, out_file_name, distance_upstream):
    with open(out_file_name, "w") as file:
        for gid, seq in tqdm(sequences_dictionary.items()):
            SeqIO.write(SeqRecord(Seq(seq), id=f"{gid}_prom_{distance_upstream}", description=""), file, "fasta")


def main():
    # Set parameters and file paths python extract_promoters.py local 1500 50 promoters wheat

    distance_upstream = 1500
    distance_downstream = 0

    gene_list_file_path = '/home/u10093927/workspace/dagw/Soybean/data/PRJNA657728_TPM.tsv' # Expression data from Soy atlas
    gff3_file_path = '/data/prod/Formatted/gene_model/GLYMA_Williams82_JGI_pseudomolecule_Wm82a4v1_cpmt_1_1_JGI_GM_a4v1_1_1' # Annotation 
    genome_file_path = '/data/prod/Formatted/fasta/GLYMA_Williams82_JGI_pseudomolecule_Wm82a4v1_cpmt_1_1' # Assembly
    out_file_path = f'promoters_{distance_upstream}up_{distance_downstream}down_soy.fa'
    

    soy_gene_list = gene_list(gene_list_file_path) 
    logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
    logger = logging.getLogger(__name__)

    logger.info("Parsing GFF3 file")
    gene_info_dict = parse_gff3(gff3_file_path)

    logger.info("Extracting promoter sequences")
    sequences = extract_promoters_only(genome_file_path, gene_info_dict, soy_gene_list, distance_upstream, distance_downstream)

    report_length_sequences(sequences)
    write_fasta_file(sequences, out_file_path, distance_upstream)

    logger.info("Finished extracting sequences")


if __name__ == "__main__":
    main()