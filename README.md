# Soy_expression_prediction
Predicting gene expression patterns in the Soy bean variety williams82

# Order of running script 

# Generate input data 
1. run_process_rna_seq_data.sh  - Generate scatter plots and average expression matrixes.
2. run_extract_soy_promoters.sh - Generates the promoter sequences 
2. run_generate_soy_input_data.sh - Generates the matrix required for LLM using the promoter sequences and average expression matrixes. 

# Pedict Expression Values 
1. run_make_pretrained_model_predictions.sh - Runs make_pretrained_model_predictions.py which predicts the validation data values
2. plot_pretrained_model_predictions.py - Plots the results of the predictions
