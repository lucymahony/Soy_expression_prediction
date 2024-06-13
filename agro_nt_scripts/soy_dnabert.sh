#!/bin/bash

# Parameters 
max_length=4608 # 18432 *.25
num_gpu=1
per_device_batch_size=2
gradient_acc_steps=16 # 16 * 2=global batch size of 32
lr=3e-7
train_epochs=6
save_steps=500
eval_steps=500 
warmup_steps=50 
logging_steps=500 

# File paths
training_script=/home/u10093927/workspace/dagw/DNABERT2/src/DNABERT_2/finetune/train.py
model=/home/u10093927/workspace/dagw/DNABERT2/src/agro-nucleotide-transformer-1b
data=/home/u10093927/workspace/dagw/Soybean/tmp/soy_1500up_0down_42
outdir=/home/u10093927/workspace/dagw/Soybean/tmp/soy_1500up_0down_42/dnabert

echo "RUNNING SCRIPT"
qig conda run -n transformers torchrun --nproc_per_node=${num_gpu} ${training_script} \



python run_pretrain.py \
    --output_dir $OUTPUT_PATH \
    --model_type=dna \
    --tokenizer_name=dna$KMER \
    --config_name=$SOURCE/src/transformers/dnabert-config/bert-config-$KMER/config.json \
    --do_train \
    --train_data_file=$TRAIN_FILE \
    --do_eval \
    --eval_data_file=$TEST_FILE \
    --mlm \
    --gradient_accumulation_steps 25 \
    --per_gpu_train_batch_size 10 \
    --per_gpu_eval_batch_size 6 \
    --save_steps 500 \
    --save_total_limit 20 \
    --max_steps 200000 \
    --evaluate_during_training \
    --logging_steps 500 \
    --line_by_line \
    --learning_rate 4e-4 \
    --block_size 512 \
    --adam_epsilon 1e-6 \
    --weight_decay 0.01 \
    --beta1 0.9 \
    --beta2 0.98 \
    --mlm_probability 0.025 \
    --warmup_steps 10000 \
    --overwrite_output_dir \
    --n_process 24