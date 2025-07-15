#!/bin/bash
#SBATCH -p ei-gpu
#SBATCH -c 1
#SBATCH --mem 56G				# Memory pool for all cores
#SBATCH --time=1-10:00			# Time limit
#SBATCH --output output_%x		# STDOUT and STDERR
#SBATCH --mail-type=END,FAIL	# Notifications for job done & fail
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk	# Send-to address
#SBATCH --gres=gpu:1


data=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/filtering_out_low/soy_1500up_0down_42_log2plus1
model=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/filtering_out_low/soy_1500up_0down_42_log2plus1/lr_3e-8_r_32_alpha_32_dropout_0.05/checkpoint-5350/
outdir=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/filtering_out_low/soy_1500up_0down_42_log2plus1/lora

source ~/.bashrc
mamba activate transformers

nvidia-smi
python -c "import torch; print('CUDA available:', torch.cuda.is_available()); print('CUDA device:', torch.cuda.current_device())"

torchrun --nproc_per_node=1 train_lora_regression.py \
  --model_name_or_path $model \
  --data_path $data \
  --run_name run1 \
  --per_device_train_batch_size 1 \
  --per_device_eval_batch_size 1 \
  --learning_rate 3e-4 \
  --num_train_epochs 4 \
  --fp16 \
  --logging_steps 50 \
  --eval_steps 50 \
  --save_steps 50 \
  --output_dir $outdir  \
  --use_lora True \
  --lora_r 32 \
  --lora_alpha 32 \
  --lora_dropout 0.3