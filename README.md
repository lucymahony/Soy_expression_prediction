# Soy_expression_prediction
Predicting gene expression patterns in the Soy bean variety williams82

# Order of running script 

# Generate input data 
1. run_process_rna_seq_data.sh  - Generate scatter plots and average expression matrixes.
2. run_extract_soy_promoters.sh - Generates the promoter sequences 
2. run_generate_soy_input_data.sh - Generates the matrix required for LLM using the promoter sequences and average expression matrixes. 

