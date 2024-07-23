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
random_state=42 

# File paths
# wang_bn = 'PRJNA657728' 



transcript_dictionary_path='/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/input_data/Gmax_508_Wm82.a4.v1.transcript.fa'
promoter_dictionary_path="/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/promoters_1500up_0down_soy.fa"
metadata_path='/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/input_data/PRJNA657728_metadata.tsv'
tpm_path='/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/input_data/PRJNA657728_TPM.tsv'
tissue='leaf'
output_file_directory='/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/'
plot_file_path='/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/normalised_expression_values_wang.png'

source ~/.bashrc
mamba activate /hpc-home/mahony/miniforge3
conda run -n miniconda_dna python generate_soy_input_data.py $distance_upstream $distance_downstream $random_state $transcript_dictionary_path $promoter_dictionary_path $metadata_path $tpm_path $tissue $output_file_directory $plot_file_path













