#!/bin/bash
#SBATCH -p ei-gpu
#SBATCH -c 4
#SBATCH --mem 560G
#SBATCH --time=6-05:00:00
#SBATCH --output output_%x
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk
#SBATCH --gres=gpu:4

# Parameters
max_length=1008
num_gpu=4
per_device_batch_size=1
gradient_acc_steps=5
train_epochs=4
save_steps=50
eval_steps=50
warmup_steps=5
logging_steps=50
learning_rate=3e-4
use_ia3=True

# File paths
training_script=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/agro_nt_scripts/ia3/train_my_ia3_regression.py
model=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b

echo "RUNNING IA3 TRAINING SCRIPT"
source ~/.bashrc
mamba activate /hpc-home/mahony/miniforge3

data_paths=(/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/no_filtering/soy_1500up_0down_42_log2plus1)

for data in "${data_paths[@]}"; do
    outdir="${data}/ia3_lr_${learning_rate}"
    conda run -n transformers torchrun --nproc_per_node=${num_gpu} ${training_script} \
        --model_name_or_path ${model} \
        --data_path ${data} \
        --kmer -1 \
        --run_name "ia3_lr_${learning_rate}" \
        --use_ia3 ${use_ia3} \
        --output_dir ${outdir} \
       	--evaluation_strategy "steps" 
done


