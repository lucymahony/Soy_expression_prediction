#!/bin/bash
#SBATCH -c 1					# number of cores
#SBATCH --mem 5G				# memory pool for all cores
#SBATCH --time=1-00:00				# time limit
#SBATCH --output output_%x		# STDOUT and STDERR
#SBATCH --mail-type=END,FAIL			# notifications for job done & fail
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk	# send-to address

source ~/.bashrc
mamba activate /hpc-home/mahony/miniforge3

location_intermediate_data='../intermediate_data/soy_1500up_0down_42_log2'
checkpoint_file_name='checkpoint-5000'
plot_output_path='../intermediate_data/soy_1500up_0down_42/soy_1500up_0down_42_log2.png'
lrs='3e-4,3e-5,3e-6,3e-7'


conda run -n miniconda_dna python plot_training_metrics.py $location_intermediate_data $checkpoint_file_name $plot_output_path $lrs

