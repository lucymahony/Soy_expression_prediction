#!/bin/bash
#SBATCH -p ei-gpu
#SBATCH -c 1
#SBATCH --mem=50G
#SBATCH --time=3-0:10:00
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk
#SBATCH --output ../logs/output_%x%A_%a.out
#SBATCH --gres=gpu:1
#SBATCH --array=0-35

source ~/.bashrc
mamba activate transformers_py310_3

MODEL_NAME="/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b"
PYTHON_SCRIPT="../ml_scripts/agront_lora.py"
OUTPUT_BASE="../intermediate_data/hyperparameter_tuning_lora/"
mkdir -p "$OUTPUT_BASE"
GRID_CSV="$OUTPUT_BASE/lora_grid_config.csv"
SUMMARY_FILE="$OUTPUT_BASE/summary_results.tsv"

# RUN THIS FIRST ON THE COMMAND LINE
#       # Define hyperparamter grid for LoRA
#       ranks=(4,8,16)
#       alphas=(8,16)
#       dropouts=(0.01,0.05)
#       lrs=(3e-3,3e-4,3e-5)
#        
#       # Genearte hyperparamter array grid 
#       python ../ml_scripts/generate_lora_grid.py \
#         --ranks ${ranks} \
#         --alphas ${alphas} \
#         --dropouts ${dropouts} \
#         --lrs ${lrs} \
#         --output ../intermediate_data/hyperparameter_tuning_lora/lora_grid_config.csv

# Extract parameteres from lora_grid_config.csv
LINE=$(sed -n "$((SLURM_ARRAY_TASK_ID + 2))p" "$GRID_CSV")  # +2 to skip header and get correct row
IFS=',' read -r lora_rank lora_alpha lora_dropout lr id exp_name <<< "$LINE"

DATASET_DIR='../intermediate_data/nofilter__None_None_1500up_4500down/soy_1500up_4500down_42_log2plus1'
OUTPUT_DIR="$OUTPUT_BASE/$exp_name"
mkdir -p "$OUTPUT_DIR"
LOG_FILE="$OUTPUT_DIR/train.log"

# Run training
echo "Running $exp_name with: r=$lora_rank, alpha=$lora_alpha, dropout=$lora_dropout, lr=$lr"
python "$PYTHON_SCRIPT" \
  --data_path "$DATASET_DIR" \
  --model_name "$MODEL_NAME" \
  --learning_rate "$lr" \
  --per_device_train_batch_size 8 \
  --per_device_eval_batch_size 8 \
  --weight_decay 0.01 \
  --num_train_epochs 8 \
  --use_kmers true \
  --kmer 6 \
  --k_folds 1 \
  --use_lora true \
  --lora_r $lora_rank \
  --lora_alpha "$lora_alpha" \
  --lora_dropout "$lora_dropout" \
  --output_dir "$OUTPUT_DIR" \
  >> "$LOG_FILE" 2>&1

# Extract final R² 
r2=$(grep "Validation R²:" "$LOG_FILE" | awk '{print $3}' | sort -nr | head -1)


# Record summary
echo -e "${exp_name}\t${r2}\t${OUTPUT_DIR}" >> "$SUMMARY_FILE"