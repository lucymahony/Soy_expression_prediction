#!/bin/bash
#SBATCH -p ei-gpu
#SBATCH -c 1	
#SBATCH --mem 1G				# Memory pool for all cores
#SBATCH --time=0-10:00			# Time limit
#SBATCH --output output_%x		# STDOUT and STDERR
#SBATCH --mail-type=END,FAIL	# Notifications for job done & fail
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk	# Send-to address
#SBATCH --gres=gpu:1


echo "RUNNING SCRIPT"
source ~/.bashrc 
mamba activate /hpc-home/mahony/miniforge3
conda run -n transformers torchrun tokenizer_find.py