#!/bin/bash
#SBATCH -p ei-gpu
#SBATCH -c 1
#SBATCH --mem=560G
#SBATCH --time=6:10:00
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk
#SBATCH --output output_%x
#SBATCH --gres=gpu:1

source ~/.bashrc
mamba activate agront_ia3_peft


LEARNING_RATES=(3e-3)
BATCH_SIZES=(8)

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
PYTHON_SCRIPT="testing_ia3.py"
OUTPUT_BASE="../intermediate_data/testing_ia3/"
mkdir -p "$OUTPUT_BASE"

output_dir="${OUTPUT_BASE}/lr${lr}_bs${bs}"
mkdir -p "$output_dir"
log_file="$output_dir/train.log"

echo "Running config: LR=$lr | BS=$bs | Dataset: $DATASET_DIR"
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
  --use_ia3 \
  > "$log_file" 2>&1
