#!/bin/bash
#SBATCH -p ei-gpu
#SBATCH -c 1
#SBATCH --mem=650G
#SBATCH --time=1-5:10:00
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk
#SBATCH --output ../logs/output_%x
#SBATCH --gres=gpu:1

source ~/.bashrc
mamba activate transformers_py310_3

MODEL_NAME="/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b"
PYTHON_SCRIPT="../ml_scripts/agront_train_head_only.py"
data_dir=../intermediate_data/nofilter__None_None_150up_5000down/soy_150up_5000down_42_log2plus1/
train_file="$data_dir/train.csv"
dev_file="$data_dir/dev.csv"
test_file="$data_dir/test.csv"
log_file=../logs/train.log
output_dir=../intermediate_data/head

echo -e "\nRunning: $dataset_dir [$dataset_type]"
python "$PYTHON_SCRIPT" \
  --train_fasta_file "$train_file" \
  --validate_fasta_file "$dev_file" \
  --test_fasta_file "$test_file" \
  --output_dir "$output_dir" \
  --model_name "$MODEL_NAME" \
  --num_train_epochs 8 \
  --batch_size 8 \
  --learning_rate 3e-3 \
  --non_overlapping_kmers true \
  --k_folds 1 \
  --logging_dir "$log_file"
