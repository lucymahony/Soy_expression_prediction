#!/bin/bash
#SBATCH -c 1
#SBATCH --partition=ei-medium
#SBATCH --mem=56G				# memory pool for all cores	
#SBATCH --time=0-01:30:00			
#SBATCH --output output_%x		
#SBATCH --mail-type=END,FAIL			
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk	

source ~/.bashrc 
mamba activate /hpc-home/mahony/miniforge3
conda activate transformers

python variable_motif_enrichment.py

