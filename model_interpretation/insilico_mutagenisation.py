# This script generates the input for an insilico mutagenisation experiment
# 1. - Replace nuceotide at every location with another nucleotide
import random
sequence_id = "test_sequences"
starting_sequence ="TTCACACTCATCTTTACTTTACCCAAACCCAACCACTTACTTGATAATATGTTGTGGACCCATTTTGTGTGGTGGGGATAATACAGCCACCATGTCTTCATCCCTACCTAACCTAACCACTTTAGTTTGGAAAGCTCCATCAACGAAAACTTCAACCTTAAACAAAATATGTATAACCAATATACATGGAATAATAGGAATTGGAAGCTACAACCAACTGAACCATTAGTTCGTCGCAGTAGTTAAAAAATTCTACCTGATGTTGAATCCCTAAAAAATATTGGTTTATATTTTAAGAGAATCTTTACACGCATCCATAACTTAAGACATTAATTAAAAAATTTAGCGAACACACATAATATTAAATAGTAAATTAAAATATAAGTAAAGTAATAAAACAGCATATTTAAATTCAATTATAAATTTATAAGTTTATAATATTGAGAAATTTACTTTAGTTTAGTAAAAAATACGACAATATTTATAATGGTAGTACTTTTCAAGTTTTTGTTTTTTCTCTTTCAGAAAAAGTTAAAAGCAATATCTTATGAGCCAATCTTTTATAGTTTTTATAGCTTTGATGGGATATCTTCTAAACAAAGTTTGGAACAGTTTCCAAGACAAAAATCTCAAAGAAAAAACTAATTGTTGCCAAAGAAATAGAATTTGAACTTTGAAGTACAACTATAATACAAACAGAAGCTTAATTGGTCCTCTACCTATTCTTTTTTATTAATCCACATTTATAAAATAAAGTTTATTATTTTTGTTTCAAAAAGGCTGGTCAGTGTAATCCCATTCCCATTTTCTTCGCGTTAATGATTGTCAAAATAGCATATAAACTGCTCTATTCCCTCCCTACAAACTCATAATTGCCTTGGCCATACCAACCTACTAACGCCGAGAATGAAAATTTTCCAATCTATGAAATTACAATCCAACCCTTTTTCAACAACGTAACATCATTTCAGTTAGATAGCGTGGATATGAATAATGTATCCGCCTTCGATGCTCTCATCAATATATCAATATATAAAGACATCAACTCTTTATATTTATCATTTATTTTCTATAAAAAAAAATTAATGATTAAGATTAATTATTCCCTGTAAAATAAATGGTGTGAACTAAAAATAACATTTTAAAAGAGTTATTTTTTATTAAAAGTAACATGATCTCTTTTAATATATATTTAATCTTATTTAAAAACAAAGATATAAGATTAATTGAGTAGTTAACCATTAACATTTACGGTTAAAAAAGAATCTTGGTTTAACCACTTATTTTAATCTTTATCATGTATTCAACACACTTGTTAGAAATACAAAATTACTCTATCATACACGAACTTGGATGCTAAAGTCTTTGCAAATATACCTCCTTCAATGCACCAAGCTAATTCACATGGACGGAAACTAGATGGAGATCTTACAACCAAACACTATAGCGATTCCTTCAAAACATTAGGCAATTTATTTGAGTAGGATTACAATTCACAAT"

def generate_mutagenesis_inputs(sequence):
    """
    Generate inputs for insilico mutagenisation by replacing each nucleotide with the others.
    
    Args:
        sequence (str): The original nucleotide sequence.
        
    Returns:
        list: A list of mutated sequences.
    """
    nucleotides = ['A', 'C', 'G', 'T']
    mutated_sequences = []
    
    for i, original_nucleotide in enumerate(sequence):
        # randomly pick a nucleotide to replace the original one
        replacement = random.choice([n for n in nucleotides if n != original_nucleotide])
        # create a new sequence with the replacement
        mutated_sequence = sequence[:i] + replacement + sequence[i+1:]
        mutated_sequences.append(mutated_sequence)
    
    # Check number of mutated sequences == len(sequence)
    if len(mutated_sequences) != len(sequence):
        raise ValueError("Number of mutated sequences does not match the length of the original sequence.")
    
    return mutated_sequences

output_file_path = '../intermediate_data/insilico_mutants/mutated_sequences.csv'
mutated_sequences = generate_mutagenesis_inputs(starting_sequence)


with open(output_file_path, 'w') as file:
    file.write("sequence,label\n")
    for seq in mutated_sequences:
        file.write(f"{seq},0.0\n")
print(f"Mutated sequences saved to {output_file_path}")