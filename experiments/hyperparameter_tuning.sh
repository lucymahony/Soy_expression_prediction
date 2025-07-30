#!/bin/bash
#SBATCH -p ei-gpu
#SBATCH -c 1
#SBATCH --mem=50G
#SBATCH --time=6-0:10:00
#SBATCH --gres=gpu:1
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk
#SBATCH --output ../logs/output_%x_%A_%a.out
#SBATCH --array=0-35

source ~/.bashrc
mamba activate transformers_py310_3

MODEL_NAME="/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b"
PYTHON_SCRIPT="../ml_scripts/agront_train_ia3.py"
OUTPUT_BASE="../intermediate_data/hyperparameter_tuning_ia3"
filtering_dataset="nofilter__None_None_150up_5000down"
input_data_dir="../intermediate_data/${filtering_dataset}/soy_150up_5000down_42_log2plus1"
train_file="$input_data_dir/train.csv"
dev_file="$input_data_dir/dev.csv"
test_file="$input_data_dir/test.csv"

# === Hyperparameter grid ===
learning_rates=(3e-3 3e-4 3e-5 3e-6)
batch_sizes=(4 8 16)
weight_decays=(0 0.01 0.1)

# === Flatten grid and select based on SLURM_ARRAY_TASK_ID ===
combinations=()
for lr in "${learning_rates[@]}"; do
  for bs in "${batch_sizes[@]}"; do
    for wd in "${weight_decays[@]}"; do
      combinations+=("$lr,$bs,$wd")
    done
  done
done

# === Parse the combination for this task ===
combo="${combinations[$SLURM_ARRAY_TASK_ID]}"
IFS=',' read -r lr bs wd <<< "$combo"

# === Output and log paths ===
combo_name="${filtering_dataset}_lr_${lr}_bs_${bs}_wd_${wd}"
output_dir="${OUTPUT_BASE}/${combo_name}"
mkdir -p "$output_dir"
log_file="${output_dir}/run.log"

# === Check if parameter combo already run ===
if compgen -G "${output_dir}/best_model*" > /dev/null && grep -q "Final validation R²:" "${output_dir}/run.log"; then
  echo "Skipping: Completed output found for LR=$lr, BS=$bs, WD=$wd"
  exit 0
fi

echo "Combination not run ..."


# === Run training ===
echo "Running: LR=$lr, BS=$bs, WD=$wd" | tee "$log_file"

python "$PYTHON_SCRIPT" \
  --train_fasta_file "$train_file" \
  --validate_fasta_file "$dev_file" \
  --test_fasta_file "$test_file" \
  --model_name "$MODEL_NAME" \
  --learning_rate "$lr" \
  --batch_size "$bs" \
  --weight_decay "$wd" \
  --num_train_epochs 8 \
  --non_overlapping_kmers true \
  --output_dir "$output_dir" \
  >> "$log_file" 2>&1

# === Extract R² and append to summary ===
r2=$(grep "Final validation R²:" "$log_file" | awk '{print $NF}')
echo -e "${filtering_dataset}\tLR=${lr}\tBS=${bs}\tWD=${wd}\tR2=${r2}\tOutput=${output_dir}" >> "$OUTPUT_BASE/summary_results.tsv"
