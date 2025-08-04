#!/bin/bash
#SBATCH -p ei-gpu
#SBATCH -c 1
#SBATCH --mem=50G
#SBATCH --time=6-0:10:00
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk
#SBATCH --output ../logs/output_%x%A_%a.out
#SBATCH --gres=gpu:1
#SBATCH --array=0-2  # 3 datasets

source ~/.bashrc
mamba activate transformers_py310_3

MODEL_NAME="/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b"
PYTHON_SCRIPT="../ml_scripts/agront_lora.py"
OUTPUT_BASE="../intermediate_data/filtering_experiment_lora/"
mkdir -p "$OUTPUT_BASE"

dataset_dirs=(
  ../intermediate_data/threshold_0.5_None_5000up_1000down
  ../intermediate_data/nofilter__None_None_5000up_1000down
  ../intermediate_data/cv_5000up_1000down/)

dataset_dir="${dataset_dirs[$SLURM_ARRAY_TASK_ID]}"
[[ -d "$dataset_dir" ]] || { echo "Not a directory: $dataset_dir"; exit 1; }

soy_subdir=$(find "$dataset_dir" -maxdepth 1 -type d -name "soy_*" | head -n 1)
[[ -d "$soy_subdir" ]] || { echo "Missing soy_* subdir in $dataset_dir"; exit 1; }


output_dir="$OUTPUT_BASE/$(basename "$dataset_dir")"
mkdir -p "$output_dir"
log_file="$output_dir/train.log"

python "$PYTHON_SCRIPT" \
  --data_path "$soy_subdir" \
  --model_name "$MODEL_NAME" \
  --learning_rate 3e-5 \
  --batch_size 8 \
  --weight_decay 0.01 \
  --num_train_epochs 8 \
  --use_kmers true \
  --kmer 6 \
  --k_folds 1 \
  --output_dir "$output_dir" \
  >> "$log_file" 2>&1


r2=$(grep "Validation R²:" "$log_file" | awk '{print $3}')
echo -e "${dataset_dir}\t${r2}\t${output_dir}" >> "$OUTPUT_BASE/summary_results.tsv"
