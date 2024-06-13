#!/bin/bash

# Parameters 
max_length=46 # 18432 *.025
num_gpu=1
per_device_batch_size=2
gradient_acc_steps=16 # 16 * 2=global batch size of 32
lr=3e-4
train_epochs=2
save_steps=500
eval_steps=500 
warmup_steps=50 
logging_steps=500 

# File paths
training_script=/home/u10093927/workspace/dagw/Soybean/src/Soy_expression_prediction/agro_nt_scripts/train_ia3_regression.py
model=/home/u10093927/workspace/dagw/DNABERT2/src/agro-nucleotide-transformer-1b
data=/home/u10093927/workspace/dagw/Soybean/tmp/soy_1500up_0down_42
outdir=/home/u10093927/workspace/dagw/Soybean/tmp/soy_1500up_0down_42

echo "RUNNING SCRIPT"
qig conda run -n transformers torchrun --nproc_per_node=${num_gpu} ${training_script} \
            --model_name_or_path ${model} \
            --data_path ${data} \
            --kmer -1 \
            --run_name ia3 \
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
            -zslot 1 \
            -zmem 64G \
            -zgpu \
            -zgpuslots 1 \
            -zo tiny_soy_agro.log -ze tiny_soy_agro.err \
            -zjobid -zmailaddrs lucy.mahony@partners.basf.com \
            -zqueue gpu.h100 -zasync










