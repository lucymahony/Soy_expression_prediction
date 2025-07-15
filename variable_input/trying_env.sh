#!/bin/bash
#SBATCH -p ei-gpu
#SBATCH -c 1
#SBATCH --mem=50G
#SBATCH --time=6-0:10:00
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk
#SBATCH --output logs/output_%x
#SBATCH --gres=gpu:1

source ~/.bashrc
mamba activate transformers_py310_3
python -c "import transformers; print(transformers.__file__)" #/hpc-home/mahony/miniforge3/envs/transformers_py310_3/lib/python3.10/site-packages/transformers/__init__.py
python -c "import transformers, torch, accelerate; print('Transformers:', transformers.__version__); print('Torch:', torch.__version__); print('Accelerate:', accelerate.__version__)"
#Transformers: 4.53.2
#Torch: 2.7.1+cu126
#Accelerate: 1.8.1





dataset_dir=../intermediate_data/threshold__0.5_None_150up_150down
soy_subdir=$(find "$dataset_dir" -maxdepth 1 -type d -name "soy_*" | head -n 1)
train_file="$soy_subdir/train.csv"
dev_file="$soy_subdir/dev.csv"
test_file="$soy_subdir/test.csv"
MODEL_NAME="/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b"
PYTHON_SCRIPT="regression_agroNT.py"
output_dir="../intermediate_data/variable_input_experiment/"

python "$PYTHON_SCRIPT" \
  --train_fasta_file "$train_file" \
  --validate_fasta_file "$dev_file" \
  --test_fasta_file "$test_file" \
  --output_dir "$output_dir" \
  --model_name "$MODEL_NAME"
