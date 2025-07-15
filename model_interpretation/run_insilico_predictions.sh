#!/bin/bash
#SBATCH -p ei-gpu
#SBATCH -c 4	
#SBATCH --mem 560G				# memory pool for all cores
#SBATCH --time=0-05:00:00				# time limit
#SBATCH --output output_%x		# STDOUT and STDERR
#SBATCH --mail-type=END,FAIL			# notifications for job done & fail
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk	# send-to address
#SBATCH --gres=gpu:4

# File paths
training_script=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/model_interpretation/agro_nt_predictions.py

echo "RUNNING SCRIPT"
source ~/.bashrc 
mamba activate /hpc-home/mahony/miniforge3
num_gpu=4
conda run -n transformers torchrun --nproc_per_node=${num_gpu} ${training_script} 


