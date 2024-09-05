#!/bin/bash
#SBATCH -p ei-gpu
#SBATCH -c 2	
#SBATCH --mem 560G				# Memory pool for all cores
#SBATCH --time=2-00:00			# Time limit
#SBATCH --output output_%x		# STDOUT and STDERR
#SBATCH --mail-type=END,FAIL	# Notifications for job done & fail
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk	# Send-to address
#SBATCH --gres=gpu:2


# Note the script that does the actual plot of the predictions is in plot_results/predicted_vs_actual_agro_results.py


# Parameters 
max_length=461 # 18432 *.025
num_gpu=2
per_device_batch_size=1
gradient_acc_steps=32 # 16 * 2 = global batch size of 32
train_epochs=12
save_steps=500
eval_steps=500 
warmup_steps=50 
logging_steps=500 

# File paths
training_script=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/agro_nt_scripts/plot_pretrained_model_predictions.py
model=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b
data=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/soy_1500up_0down_42

echo "RUNNING SCRIPT"
source ~/.bashrc 
mamba activate /hpc-home/mahony/miniforge3

lr=3e-5

outdir=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/soy_1500up_0down_42/3e-5/checkpoint-4500
# Check if the model already exists in the output directory
if [ -d "${outdir}" ] && [ "$(ls -A ${outdir})" ]; then
    echo "Pre-trained model found in ${outdir}. Loading the model..."

    conda run -n transformers torchrun --nproc_per_node=${num_gpu} ${training_script} \
                --model_name_or_path ${model} \
                --data_path ${data} \
                --kmer -1 \
                --run_name lr_experiment \
                --model_max_length ${max_length} \
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
                --use_lora True \
                --save_model True \
                --eval_and_save_results True
else
    echo "No pre-trained model found. : ( "
fi


