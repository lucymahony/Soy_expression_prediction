#!/bin/bash
#SBATCH -p ei-short
#SBATCH -c 1
#SBATCH --mem 1G				# Memory pool for all cores
#SBATCH --time=0-00:05:00			# Time limit
#SBATCH --output %x.out		# STDOUT and STDERR
#SBATCH --mail-type=END,FAIL	# Notifications for job done & fail
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk	# Send-to address


echo "RUNNING SCRIPT"
source ~/.bashrc 
mamba activate /hpc-home/mahony/miniforge3

file_path_to_data_that_made_the_predictions='/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/no_filtering/soy_1500up_0down_42_log2plus1/train.csv'

#file_path_to_predictions='/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/no_filtering/soy_1500up_0down_42_log2plus1/lr_3e-4_r_32_alpha_32_dropout_0.3/checkpoint-6550/predictions.csv'
#file_path_to_output_plot='/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/no_filtering/soy_1500up_0down_42_log2plus1/lr_3e-4_r_32_alpha_32_dropout_0.3/checkpoint-6550/predictions_plot.pdf'

file_path_to_predictions='/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/predictions_output/results/checkpoint-5350-eval/test_predictions.csv'
file_path_to_output_plot='/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/predictions_output/results/checkpoint-5350-eval/test_predictions.png'


python plot_pretrained_model_predictions.py $file_path_to_data_that_made_the_predictions $file_path_to_predictions $file_path_to_output_plot
