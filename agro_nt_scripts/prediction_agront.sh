#!/bin/bash
#SBATCH -p ei-gpu
#SBATCH -c 4	
#SBATCH --mem 560G				# memory pool for all cores
#SBATCH --time=6-05:00:00				# time limit
#SBATCH --output output_%x		# STDOUT and STDERR
#SBATCH --mail-type=END,FAIL			# notifications for job done & fail
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk	# send-to address
#SBATCH --gres=gpu:4



# File paths
training_script=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/agro_nt_scripts/train_ia3_regression.py

echo "RUNNING SCRIPT"
source ~/.bashrc 
mamba activate /hpc-home/mahony/miniforge3
num_gpu=1
conda run -n transformers torchrun --nproc_per_node=${num_gpu} ${training_script} 