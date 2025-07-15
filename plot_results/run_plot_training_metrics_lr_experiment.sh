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

location_intermediate_data='../intermediate_data/soy_1500up_0down_42_log2'
checkpoint_file_name='checkpoint-5350'
plot_output_path='../intermediate_data/soy_1500up_0down_42_log2/soy_1500up_0down_42_log2_e-4.png'
lrs='1e-4,2e-4,3e-4,4e-4,5e-4,6e-4,7e-4,8e-4,9e-4'

conda run -n miniconda_dna python plot_training_metrics_lr_experiment.py $location_intermediate_data $checkpoint_file_name $plot_output_path $lrs

