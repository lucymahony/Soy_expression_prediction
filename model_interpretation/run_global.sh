#!/bin/bash
#SBATCH -c 4	
#SBATCH --partition=ei-gpu
#SBATCH --mem=56G				# memory pool for all cores	
#SBATCH --time=2-00:30:00			
#SBATCH --output output_%x		
#SBATCH --mail-type=END,FAIL			
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk	
#SBATCH --gres=gpu:4

fine_tuned_model=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/replicate_AgroNT/sweep_logs/lr_3e-5/checkpoint-18856/
output_path='glycine_max_test_attention_lr_3e-5_checkpoint-18856.csv' 
kmer=6
sequence_fasta_file='/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/data/plant-genomic-benchmark/gene_exp/glycine_max_test.fa'

source ~/.bashrc 
mamba activate /hpc-home/mahony/miniforge3
conda activate transformers
export CUDA_VISIBLE_DEVICES=0
export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True

echo 'Running global analysis'

python global_analysis_of_TFBS.py \
    --model ${fine_tuned_model} \
    --output_path ${output_path} \
    --kmer ${kmer} \
    --sequence_fasta_file ${sequence_fasta_file}
