#!/bin/bash
#SBATCH -p ei-gpu
#SBATCH -c 2
#SBATCH --mem=50G
#SBATCH --time=6:10:00
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk
#SBATCH --output ../logs/output_%x
#SBATCH --gres=gpu:2

source ~/.bashrc
mamba activate transformers_py310_3
set -ueo pipefail

max_length=1008
per_device_batch_size=1
gradient_acc_steps=5
train_epochs=2
save_steps=50
eval_steps=50
warmup_steps=5
logging_steps=50
lr=3e-4
lora_r=32
lora_alpha=32
lora_dropout=0.3

MODEL_NAME="/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b"
PYTHON_SCRIPT="../ml_scripts/agront_lora.py"
data_dir=../intermediate_data/threshold__0.5_None_5000up_1000down/soy_5000up_1000down_42_log2plus1/
train_file="$data_dir/train.csv"
dev_file="$data_dir/dev.csv"
test_file="$data_dir/test.csv"
outdir=../intermediate_data/lora_cv
log_csv="${outdir}/log.csv"

mkdir -p ${outdir}

echo "outdir=${outdir}"
echo "log_csv=${log_csv}" 

torchrun --nproc_per_node=2 ${PYTHON_SCRIPT} \
    --model_name_or_path ${MODEL_NAME} \
    --data_path ${data_dir} \
    --use_kmers True \
    --model_max_length ${max_length} \
    --per_device_train_batch_size ${per_device_batch_size} \
    --per_device_eval_batch_size ${per_device_batch_size} \
    --gradient_accumulation_steps ${gradient_acc_steps} \
    --learning_rate ${lr} \
    --num_train_epochs ${train_epochs} \
    --fp16 \
    --save_strategy epoch \
    --evaluation_strategy epoch \
    --logging_steps ${logging_steps} \
    --overwrite_output_dir True \
    --output_dir ${outdir} \
    --log_csv_path ${log_csv} \
    --run_name "trying_lora" \
    --find_unused_parameters False \
    --use_lora True \
    --lora_r ${lora_r} \
    --lora_alpha ${lora_alpha} \
    --lora_dropout ${lora_dropout} \
    --seed 42 \
    --k_folds 3
