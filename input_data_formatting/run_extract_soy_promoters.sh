#!/bin/bash
#SBATCH -c 1					# number of cores
#SBATCH --mem 56G				# memory pool for all cores
#SBATCH --time=1-00:00				# time limit
#SBATCH --output output_%x		# STDOUT and STDERR
#SBATCH --mail-type=END,FAIL			# notifications for job done & fail
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk	# send-to address

# Parameters
distance_upstream=1500
distance_downstream=0

# File pathsdataset.to_list
gene_list_file_path='/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/input_data/PRJNA657728_TPM.tsv'
gff3_file_path='/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/input_data/Gmax_508_Wm82.a4.v1.gene.gff3'
genome_file_path='/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/input_data/Gmax_508_v4.0.fa'
out_file_path="/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/promoters_${distance_upstream}up_${distance_downstream}down_soy.fa"

source ~/.bashrc
mamba activate /hpc-home/mahony/miniforge3
conda run -n miniconda_dna python extract_soy_promoters.py $distance_upstream $distance_downstream $gene_list_file_path $gff3_file_path $genome_file_path $out_file_path 

