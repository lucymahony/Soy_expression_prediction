#!/bin/bash
#SBATCH -p ei-gpu
#SBATCH -c 1
#SBATCH --mem=50G
#SBATCH --time=2-0:10:00
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk
#SBATCH --output ../logs/output_%x
#SBATCH --gres=gpu:1


source ~/.bashrc
mamba activate transformers_py310_3

MODEL_NAME="/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b"
PYTHON_SCRIPT="../ml_scripts/agront_train_ia3.py"
OUTPUT_BASE="../intermediate_data/"
mkdir -p "$OUTPUT_BASE"

dataset_dir=(
  ../intermediate_data/nofilter__None_None_150up_5000down)

soy_subdir=$(find "$dataset_dir" -maxdepth 1 -type d -name "soy_*" | head -n 1)
[[ -d "$soy_subdir" ]] || { echo "Missing soy_* subdir in $dataset_dir"; exit 1; }

train_file="$soy_subdir/train.csv"
dev_file="$soy_subdir/dev.csv"
test_file="$soy_subdir/test.csv"
output_dir="$OUTPUT_BASE/$(basename "$dataset_dir")"
mkdir -p "$output_dir"
log_file="$output_dir/train.log"

echo -e "\nRunning: $dataset_dir [$dataset_type]"
python "$PYTHON_SCRIPT" \
  --train_fasta_file "$train_file" \
  --validate_fasta_file "$dev_file" \
  --test_fasta_file "$test_file" \
  --model_name "$MODEL_NAME" \
  --learning_rate 3e-3 \
  --batch_size 8 \
  --weight_decay 0.01 \
  --num_train_epochs 8 \
  --non_overlapping_kmers true \
  --output_dir "$output_dir" \
  >> "$log_file" 2>&1


r2=$(grep "Validation R²:" "$log_file" | awk '{print $3}')
echo -e "${dataset_dir}\t${dataset_type}\t${r2}\t${output_dir}" >> "$OUTPUT_BASE/summary_results.tsv"
