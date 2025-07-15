#!/bin/bash
#SBATCH -p ei-gpu
#SBATCH -c 4
#SBATCH --mem 560G
#SBATCH --time=6-05:00:00
#SBATCH --output output_%x
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk
#SBATCH --gres=gpu:4


# This script, uses the randomly generated hyperparameters, trains the model with IA3 and saves the results to a csv file

CONFIG_FILE="/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/hyperparameter_configs.csv"
SCRIPT="/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/agro_nt_scripts/ia3/train_ia3_with_hyperparameters.py"
MODEL=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b
data_path=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/no_filtering/soy_1500up_0down_42_log2plus1
hyperparameter_results=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/hyperparameter_results.csv

source ~/.bashrc
mamba activate /hpc-home/mahony/miniforge3


# Read hyperparameter configurations (skip the first line: header)
tail -n +2 "$CONFIG_FILE" | while IFS=',' read -r trial learning_rate weight_decay batch_size gradient_accumulation_steps warmup_steps target_modules feedforward_modules; do
    # Check if this configuration already exists in results file
    if grep -q "$learning_rate,$weight_decay,$batch_size,$gradient_accumulation_steps,$warmup_steps,$target_modules,$feedforward_modules" "$hyperparameter_results"; then
        echo "Skipping existing hyperparameter set: LR=$learning_rate, WD=$weight_decay"
        continue
    fi

    echo "Running training for: LR=$learning_rate"
    echo "WD=$weight_decay"
    echo "Batch=$batch_size"
    echo "Gradient_accumulation=$gradient_accumulation_steps"
    echo "Warmup=$warmup_steps"
    echo "Target_modules=$target_modules"
    echo "Feedforward_modules=$feedforward_modules"

    if [ "$feedforward_modules" == "['esm.encoder.layer.38.output.dense/esm.encoder.layer.39.output.dense']" ] ; then
        module_strategy="balanced"
    elif [ "$feedforward_modules" == "['esm.encoder.layer.37.output.dense/esm.encoder.layer.38.output.dense/esm.encoder.layer.39.output.dense']" ] ; then
        module_strategy="aggressive"
    else
        module_strategy="minimal"
    fi

    echo "Module strategy: $module_strategy"
    outdir="${data_path}/results/LR${learning_rate}_WD${weight_decay}_B${batch_size}_GA${gradient_accumulation_steps}_W${warmup_steps}_MS${module_strategy}"
    echo "Output directory: $outdir"


    conda run -n transformers python "$SCRIPT" \
        --model_name_or_path "$MODEL" \
        --data_path ${data_path} \
        --num_train_epochs 12 \
        --learning_rate "$learning_rate" \
        --weight_decay "$weight_decay" \
        --per_device_train_batch_size "$batch_size" \
        --per_device_eval_batch_size "$batch_size" \
        --gradient_accumulation_steps "$gradient_accumulation_steps" \
        --warmup_steps "$warmup_steps" \
        --target_modules "$target_modules" \
        --feedforward_modules "$feedforward_modules" \
        --hyperparameter_results_file "$hyperparameter_results" \
        --output_dir "$outdir" \
        --overwrite_output_dir True

    echo "Finished training for: LR=$learning_rate, WD=$weight_decay"
done

