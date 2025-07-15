#!/bin/bash
#SBATCH -p ei-gpu
#SBATCH -c 1
#SBATCH --mem=50G
#SBATCH --time=6-0:10:00
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk
#SBATCH --output logs/output_%x_%A_%a.out
#SBATCH --gres=gpu:1
#SBATCH --array=0-8  # 3 LRs × 3 BSs = 9 total jobs


source ~/.bashrc
mamba activate transformers_py310_3

# === Hyperparameter Grid ===
LEARNING_RATES=(1e-5 3e-5 1e-4)
BATCH_SIZES=(4 8 16)

# === Decode array index
config_id=$SLURM_ARRAY_TASK_ID
total_lr=${#LEARNING_RATES[@]}
total_bs=${#BATCH_SIZES[@]}

bs_index=$(( config_id % total_bs ))
lr_index=$(( config_id / total_bs ))

lr="${LEARNING_RATES[$lr_index]}"
bs="${BATCH_SIZES[$bs_index]}"

# === Fixed dataset path
DATASET_DIR="../intermediate_data/cv__None_None_150up_5000down"
soy_subdir=$(find "$DATASET_DIR" -maxdepth 1 -type d -name "soy_*" | head -n 1)

if [[ ! -d "$soy_subdir" ]]; then
  echo "Could not find soy_* subdirectory in $DATASET_DIR"
  exit 1
fi

train_file="$soy_subdir/train.csv"
dev_file="$soy_subdir/dev.csv"
test_file="$soy_subdir/test.csv"

for f in "$train_file" "$dev_file" "$test_file"; do
  [[ -f "$f" ]] || { echo "Missing file: $f"; exit 1; }
done

# === Run training
MODEL_NAME="/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b"
PYTHON_SCRIPT="../variable_input/regression_agroNT.py"
OUTPUT_BASE="../intermediate_data/hyperparameter_experiment/"
mkdir -p "$OUTPUT_BASE"

output_dir="${OUTPUT_BASE}/lr${lr}_bs${bs}"
mkdir -p "$output_dir"
log_file="$output_dir/train.log"

echo "🚀 Running config: LR=$lr | BS=$bs | Dataset: $DATASET_DIR"
python "$PYTHON_SCRIPT" \
  --train_fasta_file "$train_file" \
  --validate_fasta_file "$dev_file" \
  --test_fasta_file "$test_file" \
  --output_dir "$output_dir" \
  --model_name "$MODEL_NAME" \
  --num_train_epochs 5 \
  --batch_size "$bs" \
  --learning_rate "$lr" \
  --non_overlapping_kmers \
  > "$log_file" 2>&1

# === Extract Validation R²
r2=$(grep "Validation R²:" "$log_file" | awk '{print $3}')
summary_file="${OUTPUT_BASE}/summary_results.tsv"
[[ ! -f "$summary_file" ]] && echo -e "LR\tBS\tR2\tOutputDir" > "$summary_file"
echo -e "$lr\t$bs\t$r2\t$output_dir" >> "$summary_file"

