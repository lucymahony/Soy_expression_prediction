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

conda run -n miniconda_dna python plotting_lora_metrics.py 