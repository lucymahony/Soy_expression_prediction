#!/bin/bash
#SBATCH -p ei-gpu
#SBATCH -c 4	
#SBATCH --mem 560G				# memory pool for all cores
#SBATCH --time=1-05:00:00				# time limit
#SBATCH --output output_%x		# STDOUT and STDERR
#SBATCH --mail-type=END,FAIL			# notifications for job done & fail
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk	# send-to address
#SBATCH --gres=gpu:4

# Parameters 
max_length=1008 
num_gpu=4
per_device_batch_size=1
gradient_acc_steps=5 
train_epochs=4
save_steps=50
eval_steps=50 
warmup_steps=5 
logging_steps=50 

# File paths
training_script=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/agro_nt_scripts/train_ia3_regression.py
model=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b
data=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/soy_1500up_0down_42_log2/

echo "RUNNING SCRIPT"
source ~/.bashrc 
mamba activate /hpc-home/mahony/miniforge3

#for lr in 2e-4 3e-4 4e-4 5e-4 6e-4 7e-4 8e-4 9e-4
for lr in 3e-4
do
    outdir=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/soy_1500up_0down_42_log2/${lr}
    conda run -n transformers torchrun --nproc_per_node=${num_gpu} ${training_script} \
                --model_name_or_path ${model} \
                --data_path ${data} \
                --kmer -1 \
                --run_name lr_experiment \
                --model_max_length ${max_length}\
                --per_device_train_batch_size $per_device_batch_size \
                --per_device_eval_batch_size $per_device_batch_size \
                --gradient_accumulation_steps $gradient_acc_steps \
                --learning_rate $lr \
                --num_train_epochs $train_epochs \
                --fp16 \
                --save_steps $save_steps \
                --output_dir ${outdir} \
                --evaluation_strategy steps \
                --eval_steps $eval_steps \
                --warmup_steps $warmup_steps \
                --logging_steps $logging_steps \
                --overwrite_output_dir True \
                --log_level info \
                --find_unused_parameters False \
                --use_lora True
done










