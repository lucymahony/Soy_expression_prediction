#!/bin/bash
#SBATCH -p ei-medium
#SBATCH -c 1	
#SBATCH --mem 6G				# Memory pool for all cores
#SBATCH --time=0-10:00			# Time limit
#SBATCH --output output_%x		# STDOUT and STDERR
#SBATCH --mail-type=END,FAIL	# Notifications for job done & fail
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk	# Send-to address

# Once run_attention_scores has been run and there are layer_39_attention.pt  e.c.t generated. 

attention_layers_directory=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/soy_1500up_0down_42_log2/3e-4/checkpoint-3900/layers


echo "RUNNING SCRIPT"
source ~/.bashrc 
mamba activate /hpc-home/mahony/miniforge3
conda activate miniconda_dna
python plot_attention_scores.py 