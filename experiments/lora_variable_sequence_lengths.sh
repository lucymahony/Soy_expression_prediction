#!/bin/bash
#SBATCH -p ei-gpu
#SBATCH -c 1
#SBATCH --mem=50G
#SBATCH --time=2-8:10:00
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk
#SBATCH --output ../logs/output_%x_%A_%a.out
#SBATCH --gres=gpu:1
#SBATCH --array=0-30 


source ~/.bashrc
mamba activate transformers_py310_3

MODEL_NAME="/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b"
PYTHON_SCRIPT="../ml_scripts/agront_lora.py"
OUTPUT_BASE="../intermediate_data/variable_input_experiment_lora/"
mkdir -p "$OUTPUT_BASE"
repo="../intermediate_data"
threshold_name="nofilter__None_None"
upstream_values=(0 150 1500 4500 6000)
downstream_values=(0 150 1500 4500 6000)
dataset_dirs=()
for up in "${upstream_values[@]}"; do
  for down in "${downstream_values[@]}"; do
    total=$((up + down))
    if [ "$total" -le 6000 ] && [ "$total" -gt 0 ]; then
      dir="${repo}/${threshold_name}_${up}up_${down}down"
      dataset_dirs+=("$dir")
    fi
  done
done

dataset_dir="${dataset_dirs[$SLURM_ARRAY_TASK_ID]}"
[[ -d "$dataset_dir" ]] || { echo "Not a directory: $dataset_dir"; exit 1; }

soy_subdir=$(find "$dataset_dir" -maxdepth 1 -type d -name "soy_*" | head -n 1)
[[ -d "$soy_subdir" ]] || { echo "Missing soy_* subdir in $dataset_dir"; exit 1; }

dataset_name=$(basename "$dataset_dir")
soy_name=$(basename "$soy_subdir")
outdir="${OUTPUT_BASE}/${dataset_name}/${soy_name}"
log_csv="${outdir}/log.csv"
mkdir -p "$outdir"

# Parameters
max_length=1008
per_device_batch_size=1
gradient_acc_steps=5
train_epochs=8
save_steps=50
eval_steps=50
warmup_steps=5
logging_steps=50
lr=3e-5
lora_r=32
lora_alpha=32
lora_dropout=0.3


python ${PYTHON_SCRIPT} \
    --model_name_or_path ${MODEL_NAME} \
    --data_path ${soy_subdir} \
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
    --run_name "trying_lora_${dataset_name}_${soy_name}" \
    --find_unused_parameters False \
    --use_lora True \
    --lora_r ${lora_r} \
    --lora_alpha ${lora_alpha} \
    --lora_dropout ${lora_dropout} \
    --seed 42 \
    --k_folds 1
