Running training for: LR=0.003
WD=0.001
Batch=8
Gradient_accumulation=8
Warmup=5
Target_modules=['esm.encoder.layer.37.attention.self.key/esm.encoder.layer.37.attention.self.value/esm.encoder.layer.38.attention.self.key/esm.encoder.layer.38.attention.self.value/esm.encoder.layer.39.attention.self.key/esm.encoder.layer.39.attention.self.value/esm.encoder.layer.37.intermediate.dense/esm.encoder.layer.37.output.dense/esm.encoder.layer.38.intermediate.dense/esm.encoder.layer.38.output.dense/esm.encoder.layer.39.intermediate.dense/esm.encoder.layer.39.output.dense']
Feedforward_modules=['esm.encoder.layer.37.attention.self.key/esm.encoder.layer.37.attention.self.value/esm.encoder.layer.38.attention.self.key/esm.encoder.layer.38.attention.self.value/esm.encoder.layer.39.attention.self.key/esm.encoder.layer.39.attention.self.value/esm.encoder.layer.37.intermediate.dense/esm.encoder.layer.37.output.dense/esm.encoder.layer.38.intermediate.dense/esm.encoder.layer.38.output.dense/esm.encoder.layer.39.intermediate.dense/esm.encoder.layer.39.output.dense']
Module strategy: aggressive
Output directory: /ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/no_filtering/soy_1500up_0down_42_log2plus1/results/LR0.003_WD0.001_B8_GA8_W5_MSaggressive
Some weights of EsmForSequenceClassification were not initialized from the model checkpoint at /ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b and are newly initialized: ['classifier.dense.bias', 'classifier.dense.weight', 'classifier.out_proj.bias', 'classifier.out_proj.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
Traceback (most recent call last):
  File "/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/agro_nt_scripts/ia3/train_ia3_with_hyperparameters.py", line 213, in <module>
    train()
  File "/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/agro_nt_scripts/ia3/train_ia3_with_hyperparameters.py", line 166, in train
    ia3_config = IA3Config(
                 ^^^^^^^^^^
  File "<string>", line 14, in __init__
  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/tuners/ia3/config.py", line 98, in __post_init__
    raise ValueError("`feedforward_modules` should be a subset of `target_modules`")
ValueError: `feedforward_modules` should be a subset of `target_modules`

ERROR conda.cli.main_run:execute(47): `conda run python /ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/agro_nt_scripts/ia3/train_ia3_with_hyperparameters.py --model_name_or_path /ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b --data_path /ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/no_filtering/soy_1500up_0down_42_log2plus1 --num_train_epochs 12 --learning_rate 0.003 --weight_decay 0.001 --per_device_train_batch_size 8 --per_device_eval_batch_size 8 --gradient_accumulation_steps 8 --warmup_steps 5 --target_modules ['esm.encoder.layer.37.attention.self.key/esm.encoder.layer.37.attention.self.value/esm.encoder.layer.38.attention.self.key/esm.encoder.layer.38.attention.self.value/esm.encoder.layer.39.attention.self.key/esm.encoder.layer.39.attention.self.value/esm.encoder.layer.37.intermediate.dense/esm.encoder.layer.37.output.dense/esm.encoder.layer.38.intermediate.dense/esm.encoder.layer.38.output.dense/esm.encoder.layer.39.intermediate.dense/esm.encoder.layer.39.output.dense'] --feedforward_modules ['esm.encoder.layer.37.output.dense/esm.encoder.layer.38.output.dense/esm.encoder.layer.39.output.dense'] --output_dir /ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/no_filtering/soy_1500up_0down_42_log2plus1/results/LR0.003_WD0.001_B8_GA8_W5_MSaggressive --overwrite_output_dir True` failed. (See above for error)
starting python script
Training func
Before convert
✅ CONVERSION SUCCESSFUL!
CONVERTING FINISHED
Target Modules: ['esm.encoder.layer.37.attention.self.key/esm.encoder.layer.37.attention.self.value/esm.encoder.layer.38.attention.self.key/esm.encoder.layer.38.attention.self.value/esm.encoder.layer.39.attention.self.key/esm.encoder.layer.39.attention.self.value/esm.encoder.layer.37.intermediate.dense/esm.encoder.layer.37.output.dense/esm.encoder.layer.38.intermediate.dense/esm.encoder.layer.38.output.dense/esm.encoder.layer.39.intermediate.dense/esm.encoder.layer.39.output.dense']
Type of Target Modules: <class 'list'>
Target Modules: ['esm.encoder.layer.37.attention.self.key/esm.encoder.layer.37.attention.self.value/esm.encoder.layer.38.attention.self.key/esm.encoder.layer.38.attention.self.value/esm.encoder.layer.39.attention.self.key/esm.encoder.layer.39.attention.self.value/esm.encoder.layer.37.intermediate.dense/esm.encoder.layer.37.output.dense/esm.encoder.layer.38.intermediate.dense/esm.encoder.layer.38.output.dense/esm.encoder.layer.39.intermediate.dense/esm.encoder.layer.39.output.dense']
Type of Target Modules: <class 'list'>
Evaluation Strategy (Before Conversion): IntervalStrategy.STEPS (Type: <enum 'IntervalStrategy'>)
Evaluation Strategy (After Conversion): IntervalStrategy.STEPS (Type: <class 'str'>)

/var/spool/slurmd/job10657906/slurm_script: line 76: syntax error near unexpected token `done'
/var/spool/slurmd/job10657906/slurm_script: line 76: `done'
