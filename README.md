# Soy_expression_prediction
Predicting gene expression patterns in the Soybean variety williams82

# Generate model input data 
In `data_preprocessing`
1. run_process_rna_seq_data.sh  - Generate scatter plots and average expression matrixes.  
2. run_extract_soy_promoters.sh - Generates the promoter sequences fasta files.
3. run_generate_soy_input_data.sh or run_generate_soy_input_data_with_transcript.sh - Generates the input csvs required for LLM using the promoter sequences and average expression matrixes log2(x+1) transformed

# Experiments

1. all_cv.sh - Fine tuning all parameters 
2. ia3_cv.sh - Fine tuning using IA3
3. head_cv.sh - Fine tuning head only

4. filtering.sh - Runs IA3 fine tuning on input datasets that have been filtered based on different input TPM criteria. 
5. variable_sequence_lengths.py - Runs IA3 fine tuning on different input sequence lengths
6. hyperparameter_tuning.sh - Grid searching IA3 fine tuning with different hyperparameters. 


# Plot experiment results
In `plot_results`
1.  head_vs_ia3_comparison.py - comparing different training methods
2.  plot_filtering_results.py - comparing different data processing filtering of input genes
3.  plot_hyperparameters.py - results of diff ia3 parameters
4.  plot_loss_over_training

# Predict Expression Values 
1. run_make_pretrained_model_predictions.sh - Runs make_pretrained_model_predictions.py which predicts the validation data values. Location of predicted values printed in output_run_make_pretrained_model_predictions.sh
2. run_plot_pretrained_model_predictions.py - Plots the results of the predictions

# Visualise attention layers
1. run_attention_scores.sh - Generates the average attention across all of the layers of a given sequence
2. run_plot_attention_scores.sh - Plots the aiverage attention scores 


# Datasets 
/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/data/plant-genomic-benchmark/ - Benchmark datasets

