#!/bin/bash
#SBATCH -p ei-gpu
#SBATCH -c 1
#SBATCH --mem=50G
#SBATCH --time=2-0:10:00
#SBATCH --gres=gpu:1
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk
#SBATCH --output ../logs/output_%x

source ~/.bashrc
mamba activate transformers_py310_3

MODEL_NAME="/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b"
PYTHON_SCRIPT="../ml_scripts/agront_train_head.py"
data_dir=../intermediate_data/threshold__0.5_None_5000up_1000down/soy_5000up_1000down_42_log2plus1/
train_file="$data_dir/train.csv"
dev_file="$data_dir/dev.csv"
test_file="$data_dir/test.csv"
output_dir=../intermediate_data/head_cv
log_file="${output_dir}/run.log"

python "$PYTHON_SCRIPT" \
  --train_fasta_file "$train_file" \
  --validate_fasta_file "$dev_file" \
  --test_fasta_file "$test_file" \
  --output_dir "$output_dir" \
  --model_name "$MODEL_NAME" \
  --num_train_epochs 16 \
  --batch_size 6 \
  --learning_rate 1e-4 \
  --weight_decay 0.01 \
  --non_overlapping_kmers true \
  --k_folds 3 \
  --logging_dir "$log_file"
