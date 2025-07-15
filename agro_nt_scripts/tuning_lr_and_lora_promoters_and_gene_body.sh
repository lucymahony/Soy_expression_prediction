#!/bin/bash
#SBATCH -p ei-gpu
#SBATCH -c 4	
#SBATCH --mem 560G				# memory pool for all cores
#SBATCH --time=6-05:00:00				# time limit
#SBATCH --output output_%x		# STDOUT and STDERR
#SBATCH --mail-type=END,FAIL			# notifications for job done & fail
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk	# send-to address
#SBATCH --gres=gpu:4


# This is very similar to the tuning lr script but it also tunes LoRA parameters
# performed on the fitering_out_low data fro now 

# Parameters - max length #1500/6 - FIND 12962/6 = 2160.33
max_length=2161
num_gpu=4
per_device_batch_size=32
gradient_acc_steps=5
train_epochs=8
save_steps=50
eval_steps=50 
warmup_steps=5 
logging_steps=50 

# File paths
training_script=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/agro_nt_scripts/train_agront_lora_regression.py
model=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b
data=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/filtering_out_low/soy_1500up_0down_42_log2plus1/
out_dir_data=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/filtering_out_low/soy_1500up_0down_42_log2plus1/promoter_and_gene_body
echo "RUNNING SCRIPT"
source ~/.bashrc 
mamba activate /hpc-home/mahony/miniforge3

learning_rates=(3e-3 3e-4 3e-5 3e-6)
lora_rs=(4 8 16 )
lora_alphas=(8 16 32)
lora_dropouts=(0.1 0.3)


# Iterate through parameter combinations
for lr in "${learning_rates[@]}"; do
    for lora_r in "${lora_rs[@]}"; do
        for lora_alpha in "${lora_alphas[@]}"; do
            for lora_dropout in "${lora_dropouts[@]}"; do

                # Define output directory
                RUN_NAME="lr_${lr}_r_${lora_r}_alpha_${lora_alpha}_dropout_${lora_dropout}"
                echo "Starting: $RUN_NAME"

                outdir="${out_dir_data}/${RUN_NAME}"

                LOGFILE="${out_dir_data}/train_${RUN_NAME}.log"

                # Run training command
                conda run -n transformers torchrun --nproc_per_node=${num_gpu} ${training_script} \
                    --model_name_or_path ${model} \
                    --data_path ${data} \
                    --kmer -1 \
                    --run_name ${RUN_NAME} \
                    --model_max_length ${max_length} \
                    --per_device_train_batch_size ${per_device_batch_size} \
                    --per_device_eval_batch_size ${per_device_batch_size} \
                    --gradient_accumulation_steps ${gradient_acc_steps} \
                    --learning_rate ${lr} \
                    --num_train_epochs ${train_epochs} \
                    --save_steps ${save_steps} \
                    --output_dir ${outdir} \
                    --evaluation_strategy steps \
                    --eval_steps ${eval_steps} \
                    --warmup_steps ${warmup_steps} \
                    --logging_steps ${logging_steps} \
                    --overwrite_output_dir True \
                    --log_level info \
                    --find_unused_parameters False \
                    --use_lora True \
                    --lora_r ${lora_r} \
                    --lora_alpha ${lora_alpha} \
                    --lora_dropout ${lora_dropout} \
                    --fp16 \
                    --dataloader_pin_memory False |& tee "${LOGFILE}" 
            done
        done
    done
done




