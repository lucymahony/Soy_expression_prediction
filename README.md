# Soy_expression_prediction
Predicting gene expression patterns in the Soybean variety williams82

# Order of running script 

# Generate model input data 
In `data_preprocessing`
1. run_process_rna_seq_data.sh  - Generate scatter plots and average expression matrixes.  
2. run_extract_soy_promoters.sh - Generates the promoter sequences fasta files.
3. run_generate_soy_input_data.sh or run_generate_soy_input_data_with_transcript.sh - Generates the input csvs required for LLM using the promoter sequences and average expression matrixes log2(x+1) transformed

# Variable input sequence experiment
In `variable_input`
1. 

# Tune learning rate
1. run_tuning_lr_agro.sh - Alter script with lr or other parameters to tune
2. Determine the best model with the lowest "eval_loss" 'cat */results/lr_experiment/eval_results.json'
and the best model checkpoint for those parameters with grep "best" output_run_tuning_lr_agro.sh
3. Plot the training metrics with plot_results/run_plot_training_metrics.sh - update the lrs and the end checkpoint. 

# Predict Expression Values 
1. run_make_pretrained_model_predictions.sh - Runs make_pretrained_model_predictions.py which predicts the validation data values. Location of predicted values printed in output_run_make_pretrained_model_predictions.sh
2. run_plot_pretrained_model_predictions.py - Plots the results of the predictions

# Visualise attention layers
1. run__attention_scores.sh - Generates the average attention across all of the layers of a given sequence
2. run_plot_attention_scores.sh - Plots the aiverage attention scores 


# Datasets 
/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/data/plant-genomic-benchmark/ - Benchmark datasets

