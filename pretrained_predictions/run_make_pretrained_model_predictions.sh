#!/bin/bash
#SBATCH -p ei-gpu
#SBATCH -c 1
#SBATCH --mem=50G
#SBATCH --time=12:10:00
#SBATCH --gres=gpu:1
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk
#SBATCH --output ../logs/output_%x


source ~/.bashrc
mamba activate transformers_py310_3

BASE_MODEL="/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b"
input_data_dir="../intermediate_data/nofilter__None_None_150up_4500down/soy_150up_4500down_42_log2plus1/"
output_dir="../intermediate_data/making_predictions_merged"
mkdir -p "$output_dir"
log_file="${output_dir}/run.log"

train_file="$input_data_dir/train.csv"
dev_file="$input_data_dir/dev.csv"
test_file="$input_data_dir/test.csv"

# === Hyperparameters ===
learning_rate=3e-3
batch_size=8
weight_decay=0.1
best_trained_model="../intermediate_data/hyperparameter_tuning_ia3/nofilter__None_None_150up_5000down_lr_${learning_rate}_bs_${batch_size}_wd_${weight_decay}/best_model_lr0.003_bs8/"
best_trained_model="../intermediate_data/nofilter__None_None_150up_5000down/best_model_lr0.003_bs8/merged_to_full/"

python ../ml_scripts/old_make_predictions.py \
  --base_model "$BASE_MODEL" \
  --trained_model "$best_trained_model" \
  --train_fasta_file "$train_file" \
  --test_fasta_file "$test_file" \
  --validate_fasta_file "$dev_file" \
  --output_dir "$output_dir" \
  --learning_rate "$learning_rate" \
  --batch_size "$batch_size" \
  --weight_decay "$weight_decay" 
#

#python ../ml_scripts/preds_test.py \
#--base_model "$BASE_MODEL" \
#--model "$best_trained_model" \
#--validation_data "$train_file" \
#--output_path "$output_dir"

# OLD 

# Parameters 
#max_length=1008 # 18432 *.025
#num_gpu=1
#per_device_batch_size=1
#gradient_acc_steps=5 # 16 * 2 = global batch size of 32
#train_epochs=4
#save_steps=50
#eval_steps=50 
#warmup_steps=5 
#logging_steps=50 
#
## File paths
#training_script=../ml_scripts/old_make_predictions.py
#data="../intermediate_data/nofilter__None_None_150up_4500down/soy_150up_4500down_42_log2plus1/"
#echo "RUNNING SCRIPT"
#lr=3e-4
#lora_r=32
#lora_a=32
#lora_d=0.3
#adapter="../intermediate_data/hyperparameter_tuning_ia3/nofilter__None_None_150up_5000down_lr_${learning_rate}_bs_${batch_size}_wd_${weight_decay}/best_model_lr0.003_bs8/"
## Check if the model already exists in the output directory
#if [ -d "${adapter}" ] && [ "$(ls -A ${adapter})" ]; then
#    echo "Pre-trained model found in ${adapter}. Loading the model..."
#
#    python ${training_script} \
#                --model_name_or_path ${adapter} \
#                --data_path ${data} \
#                --kmer -1 \
#                --run_name lr_experiment \
#                --model_max_length ${max_length} \
#                --per_device_train_batch_size $per_device_batch_size \
#                --per_device_eval_batch_size $per_device_batch_size \
#                --gradient_accumulation_steps $gradient_acc_steps \
#                --learning_rate $lr \
#                --num_train_epochs $train_epochs \
#                --fp16 \
#                --save_steps $save_steps \
#                --output_dir "${adapter}" \
#                --base_model "${BASE_MODEL}" \
#                --adapter_model "${adapter}" \
#                --evaluation_strategy steps \
#                --eval_steps $eval_steps \
#                --warmup_steps $warmup_steps \
#                --logging_steps $logging_steps \
#                --overwrite_output_dir True \
#                --log_level info \
#                --find_unused_parameters False \
#                --use_lora True \
#                --save_model True \
#                --eval_and_save_results True \
#                --lora_r ${lora_r} \
#                --lora_alpha ${lora_a} \
#                --lora_dropout ${lora_d}
#else
#    echo "No pre-trained model found. : ( "
#fi
#
#