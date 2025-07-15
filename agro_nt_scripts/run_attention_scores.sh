#!/bin/bash
#SBATCH -p ei-gpu
#SBATCH -c 1	
#SBATCH --mem 6G				# Memory pool for all cores
#SBATCH --time=0-10:00			# Time limit
#SBATCH --output output_%x		# STDOUT and STDERR
#SBATCH --mail-type=END,FAIL	# Notifications for job done & fail
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk	# Send-to address
#SBATCH --gres=gpu:2

# Parameters and file paths 
model_path=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/soy_1500up_0down_42_log2/3e-4/checkpoint-3900
output_dir=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/soy_1500up_0down_42_log2/3e-4/checkpoint-3900/layers
max_seq_length=1008

num_gpu=1
attention_scores_script=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/agro_nt_scripts/attention_scores.py
data=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/soy_1500up_0down_42_log2/
model_name_or_path=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/soy_1500up_0down_42_log2/3e-4/checkpoint-3900
cache_dir="/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/cache"

echo "RUNNING SCRIPT"
source ~/.bashrc 
mamba activate /hpc-home/mahony/miniforge3
conda run -n transformers torchrun \
    --nproc_per_node=${num_gpu} \
    ${attention_scores_script} \
    --model_path ${model_path} \
    --output_dir ${output_dir} \
    --max_seq_length ${max_seq_length} \
    --cache_dir ${cache_dir}


#--data_path ${data} \
#--kmer -1 \