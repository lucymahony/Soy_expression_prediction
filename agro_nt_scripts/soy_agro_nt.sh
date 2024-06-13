#!/bin/bash
max_length=#
num_gpu=1
per_device_batch_size=2
gradient_acc_steps=16 # 16 * 2=global batch size of 32
lr=3e-7

echo "RUNNING SCRIPT"



qig conda run -n transformers torchrun --nproc_per_node=${num_gpu} ../../DNABERT_2/finetune/train.py



























