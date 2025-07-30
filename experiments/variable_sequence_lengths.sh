#!/bin/bash
#SBATCH -p ei-gpu
#SBATCH -c 1
#SBATCH --mem=50G
#SBATCH --time=6-0:10:00
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk
#SBATCH --output ../logs/output_%x_%A_%a.out
#SBATCH --gres=gpu:1
#SBATCH --array=0-23  # 27 datasets


source ~/.bashrc
mamba activate transformers_py310_3

MODEL_NAME="/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b"
PYTHON_SCRIPT="../ml_scripts/agront_train_ia3.py"
OUTPUT_BASE="../intermediate_data/variable_input_experiment_ia3/"
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

train_file="$soy_subdir/train.csv"
dev_file="$soy_subdir/dev.csv"
test_file="$soy_subdir/test.csv"
[[ -f "$train_file" ]] || { echo "Missing train file: $train_file"; exit 1; }
[[ -f "$dev_file" ]] || { echo "Missing dev file: $dev_file"; exit 1; }
[[ -f "$test_file" ]] || { echo "Missing test file: $test_file"; exit 1; }

# Dataset type label
if [[ "$dataset_dir" == *_transcripts ]]; then
  dataset_type="promoter+transcript"
else
  dataset_type="promoter_only"
fi

# Output setup
output_dir="$OUTPUT_BASE/$(basename "$dataset_dir")"
mkdir -p "$output_dir"
log_file="$output_dir/train.log"

echo -e "\nRunning: $dataset_dir [$dataset_type]"
python "$PYTHON_SCRIPT" \
  --train_fasta_file "$train_file" \
  --validate_fasta_file "$dev_file" \
  --test_fasta_file "$test_file" \
  --output_dir "$output_dir" \
  --model_name "$MODEL_NAME" \
  --num_train_epochs 4 \
  --batch_size 8 \
  --learning_rate 3e-5 \
  --non_overlapping_kmers true > "$log_file" 2>&1

r2=$(grep "Validation R²:" "$log_file" | awk '{print $3}')
echo -e "${dataset_dir}\t${dataset_type}\t${r2}\t${output_dir}" >> "$OUTPUT_BASE/summary_results.tsv"
