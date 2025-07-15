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

SCRIPT="/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/agro_nt_scripts/ia3/train_ia3_with_hyperparameters.py"
MODEL=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b
data_path=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/no_filtering/soy_1500up_0down_42_log2plus1

source ~/.bashrc
mamba activate /hpc-home/mahony/miniforge3

learning_rate=0.000003
weight_decay=0.01
batch_size=8
gradient_accumulation_steps=8
warmup_steps=5
target_modules="['esm.encoder.layer.37.attention.self.key/esm.encoder.layer.37.attention.self.value/esm.encoder.layer.38.attention.self.key/esm.encoder.layer.38.attention.self.value/esm.encoder.layer.39.attention.self.key/esm.encoder.layer.39.attention.self.value/esm.encoder.layer.37.intermediate.dense/esm.encoder.layer.37.output.dense/esm.encoder.layer.38.intermediate.dense/esm.encoder.layer.38.output.dense/esm.encoder.layer.39.intermediate.dense/esm.encoder.layer.39.output.dense']"
feedforward_modules="['esm.encoder.layer.37.output.dense/esm.encoder.layer.38.output.dense/esm.encoder.layer.39.output.dense']"

#    module_strategies = {
#        'minimal' : {
#            'target_modules': 'esm.encoder.layer.38.attention.self.key/esm.encoder.layer.38.attention.self.value/esm.encoder.layer.39.attention.self.key/esm.encoder.layer.39.attention.self.value',
#            'feedforward_modules':''},
#        'balanced' : {
#            'target_modules':'esm.encoder.layer.38.attention.self.key/esm.encoder.layer.38.attention.self.value/esm.encoder.layer.39.attention.self.key/esm.encoder.layer.39.attention.self.value/esm.encoder.layer.38.output.dense/esm.encoder.layer.39.output.dense',
#            'feedforward_modules': 'esm.encoder.layer.38.output.dense/esm.encoder.layer.39.output.dense'},
#        'aggressive' : {
#            'target_modules':'esm.encoder.layer.37.attention.self.key/esm.encoder.layer.37.attention.self.value/esm.encoder.layer.38.attention.self.key/esm.encoder.layer.38.attention.self.value/esm.encoder.layer.39.attention.self.key/esm.encoder.layer.39.attention.self.value/esm.encoder.layer.37.intermediate.dense/esm.encoder.layer.37.output.dense/esm.encoder.layer.38.intermediate.dense/esm.encoder.layer.38.output.dense/esm.encoder.layer.39.intermediate.dense/esm.encoder.layer.39.output.dense',
#            'feedforward_modules': 'esm.encoder.layer.37.output.dense/esm.encoder.layer.38.output.dense/esm.encoder.layer.39.output.dense'}
#    }
#


echo "Running training for: LR=$learning_rate"
echo "WD=$weight_decay"
echo "Batch=$batch_size"
echo "Gradient_accumulation=$gradient_accumulation_steps"
echo "Warmup=$warmup_steps"
echo "Target_modules=$target_modules"
echo "Feedforward_modules=$target_modules"

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
    --output_dir "$outdir" \
    --overwrite_output_dir True


