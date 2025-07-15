#!/bin/bash
#SBATCH -p ei-medium				# partition (queue)
#SBATCH -c 1					# number of cores
#SBATCH --mem 5G				# memory pool for all cores
#SBATCH --time=0-00:30:00			# time limit
#SBATCH --output output_%x		        # STDOUT and STDERR
#SBATCH --mail-type=END,FAIL			# notifications for job done & fail
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk	# send-to address

source ~/.bashrc
mamba activate /hpc-home/mahony/miniforge3

location_intermediate_data='../intermediate_data/filtering_out_low/soy_1500up_0down_42_log2plus1/'
checkpoint_file_name='checkpoint-5350'
plot_output_path='../intermediate_data/filtering_out_low/soy_1500up_0down_42_log2plus1/hyperparam_tuning_results_lr_and_lora.png'


conda run -n miniconda_dna python plot_training_metrics_lr_lora_experiment.py \
    $location_intermediate_data \
    $checkpoint_file_name \
    $plot_output_path \
    '{"lr": ["3e-4", "3e-6", "3e-8"], "r": [8, 16, 32], "alpha": [16, 32], "dropout": [0.1, 0.3, 0.05]}'
