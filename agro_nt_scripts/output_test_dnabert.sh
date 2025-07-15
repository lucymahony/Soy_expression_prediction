RUNNING SCRIPT
Starting: trying_dnabert
[2025-06-19 22:13:30,058] torch.distributed.run: [WARNING] 
[2025-06-19 22:13:30,058] torch.distributed.run: [WARNING] *****************************************
[2025-06-19 22:13:30,058] torch.distributed.run: [WARNING] Setting OMP_NUM_THREADS environment variable for each process to be 1 in default, to avoid your system being overloaded, please further tune the variable for optimal performance in your application as needed. 
[2025-06-19 22:13:30,058] torch.distributed.run: [WARNING] *****************************************
WARNING:root:Perform single sequence classification...
WARNING:root:Perform single sequence classification...
WARNING:root:Perform single sequence classification...
WARNING:root:Perform single sequence classification...
WARNING:root:Perform single sequence classification...
WARNING:root:Perform single sequence classification...
WARNING:root:Perform single sequence classification...
WARNING:root:Perform single sequence classification...
WARNING:root:Perform single sequence classification...
WARNING:root:Perform single sequence classification...
WARNING:root:Perform single sequence classification...
/hpc-home/mahony/.cache/huggingface/modules/transformers_modules/DNABERT-2-117M/bert_layers.py:125: UserWarning: Unable to import Triton; defaulting MosaicBERT attention implementation to pytorch (this will reduce throughput when using this model).
  warnings.warn(
/hpc-home/mahony/.cache/huggingface/modules/transformers_modules/DNABERT-2-117M/bert_layers.py:125: UserWarning: Unable to import Triton; defaulting MosaicBERT attention implementation to pytorch (this will reduce throughput when using this model).
  warnings.warn(
/hpc-home/mahony/.cache/huggingface/modules/transformers_modules/DNABERT-2-117M/bert_layers.py:125: UserWarning: Unable to import Triton; defaulting MosaicBERT attention implementation to pytorch (this will reduce throughput when using this model).
  warnings.warn(
WARNING:root:Perform single sequence classification...
/hpc-home/mahony/.cache/huggingface/modules/transformers_modules/DNABERT-2-117M/bert_layers.py:125: UserWarning: Unable to import Triton; defaulting MosaicBERT attention implementation to pytorch (this will reduce throughput when using this model).
  warnings.warn(
Some weights of BertForSequenceClassification were not initialized from the model checkpoint at /ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/DNABERT-2-117M and are newly initialized: ['bert.pooler.dense.bias', 'bert.pooler.dense.weight', 'classifier.bias', 'classifier.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
Some weights of BertForSequenceClassification were not initialized from the model checkpoint at /ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/DNABERT-2-117M and are newly initialized: ['bert.pooler.dense.bias', 'bert.pooler.dense.weight', 'classifier.bias', 'classifier.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
Some weights of BertForSequenceClassification were not initialized from the model checkpoint at /ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/DNABERT-2-117M and are newly initialized: ['bert.pooler.dense.bias', 'bert.pooler.dense.weight', 'classifier.bias', 'classifier.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
Some weights of BertForSequenceClassification were not initialized from the model checkpoint at /ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/DNABERT-2-117M and are newly initialized: ['bert.pooler.dense.bias', 'bert.pooler.dense.weight', 'classifier.bias', 'classifier.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
Traceback (most recent call last):
Traceback (most recent call last):
  File "/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/agro_nt_scripts/train_agront_lora_regression.py", line 398, in <module>
  File "/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/agro_nt_scripts/train_agront_lora_regression.py", line 398, in <module>
Traceback (most recent call last):
  File "/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/agro_nt_scripts/train_agront_lora_regression.py", line 398, in <module>
        train()
train()
  File "/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/agro_nt_scripts/train_agront_lora_regression.py", line 299, in train
  File "/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/agro_nt_scripts/train_agront_lora_regression.py", line 299, in train
Traceback (most recent call last):
  File "/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/agro_nt_scripts/train_agront_lora_regression.py", line 398, in <module>
    train()
    model = get_peft_model(model, lora_config)
            File "/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/agro_nt_scripts/train_agront_lora_regression.py", line 299, in train
  ^^^^^    ^^model = get_peft_model(model, lora_config)^
^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/mapping.py", line 136, in get_peft_model
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/mapping.py", line 136, in get_peft_model
        model = get_peft_model(model, lora_config)
train() 
     File "/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/agro_nt_scripts/train_agront_lora_regression.py", line 299, in train
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/mapping.py", line 136, in get_peft_model
    model = get_peft_model(model, lora_config)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/mapping.py", line 136, in get_peft_model
        return MODEL_TYPE_TO_PEFT_MODEL_MAPPING[peft_config.task_type](model, peft_config, adapter_name=adapter_name)
        return MODEL_TYPE_TO_PEFT_MODEL_MAPPING[peft_config.task_type](model, peft_config, adapter_name=adapter_name)return MODEL_TYPE_TO_PEFT_MODEL_MAPPING[peft_config.task_type](model, peft_config, adapter_name=adapter_name)

return MODEL_TYPE_TO_PEFT_MODEL_MAPPING[peft_config.task_type](model, peft_config, adapter_name=adapter_name)                            ^  ^^^ ^^ ^^ ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
^^^  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/peft_model.py", line 904, in __init__
^^
^^^^^  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/peft_model.py", line 904, in __init__
^^^^^^^^^^^^^
  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/peft_model.py", line 904, in __init__

           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/peft_model.py", line 904, in __init__
        super().__init__(model, peft_config, adapter_name)
super().__init__(model, peft_config, adapter_name)    super().__init__(model, peft_config, adapter_name)
      File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/peft_model.py", line 129, in __init__

super().__init__(model, peft_config, adapter_name)  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/peft_model.py", line 129, in __init__

  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/peft_model.py", line 129, in __init__
  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/peft_model.py", line 129, in __init__
        self.base_model = cls(model, {adapter_name: peft_config}, adapter_name)
self.base_model = cls(model, {adapter_name: peft_config}, adapter_name)    
                      ^^^^^^^^^^^^^^^^^ ^^ ^ ^ ^ ^ ^ ^ ^^ ^ ^     ^self.base_model = cls(model, {adapter_name: peft_config}, adapter_name)^ 
^ ^ ^ ^^ ^ ^ ^ ^ ^^ ^ ^^^^^^^^^^^^^^ ^^^ ^^ 
^ ^ ^ ^ ^ ^ ^  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/tuners/lora/model.py", line 136, in __init__
 ^ ^^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
^^^^^^^  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/tuners/lora/model.py", line 136, in __init__
^^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/tuners/lora/model.py", line 136, in __init__
self.base_model = cls(model, {adapter_name: peft_config}, adapter_name)
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/tuners/lora/model.py", line 136, in __init__
        super().__init__(model, config, adapter_name)
        super().__init__(model, config, adapter_name)super().__init__(model, config, adapter_name)

super().__init__(model, config, adapter_name)  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/tuners/tuners_utils.py", line 148, in __init__

  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/tuners/tuners_utils.py", line 148, in __init__
  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/tuners/tuners_utils.py", line 148, in __init__
  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/tuners/tuners_utils.py", line 148, in __init__
                self.inject_adapter(self.model, adapter_name)self.inject_adapter(self.model, adapter_name)self.inject_adapter(self.model, adapter_name)


self.inject_adapter(self.model, adapter_name)
  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/tuners/tuners_utils.py", line 328, in inject_adapter
  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/tuners/tuners_utils.py", line 328, in inject_adapter
  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/tuners/tuners_utils.py", line 328, in inject_adapter
  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/tuners/tuners_utils.py", line 328, in inject_adapter
        raise ValueError(
    raise ValueError(ValueError
: Target modules {'query', 'value'} not found in the base model. Please check the target modules and try again.
ValueError: Target modules {'value', 'query'} not found in the base model. Please check the target modules and try again.    
raise ValueError(
ValueError: Target modules {'query', 'value'} not found in the base model. Please check the target modules and try again.
raise ValueError(
ValueError: Target modules {'query', 'value'} not found in the base model. Please check the target modules and try again.
[2025-06-19 22:14:15,083] torch.distributed.elastic.multiprocessing.api: [WARNING] Sending process 565948 closing signal SIGTERM
[2025-06-19 22:14:15,083] torch.distributed.elastic.multiprocessing.api: [WARNING] Sending process 565949 closing signal SIGTERM
[2025-06-19 22:14:15,199] torch.distributed.elastic.multiprocessing.api: [ERROR] failed (exitcode: 1) local_rank: 0 (pid: 565947) of binary: /hpc-home/mahony/miniforge3/envs/transformers/bin/python
Traceback (most recent call last):
  File "/hpc-home/mahony/miniforge3/envs/transformers/bin/torchrun", line 33, in <module>
    sys.exit(load_entry_point('torch==2.2.2', 'console_scripts', 'torchrun')())
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/distributed/elastic/multiprocessing/errors/__init__.py", line 347, in wrapper
    return f(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/distributed/run.py", line 812, in main
    run(args)
  File "/hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/distributed/run.py", line 803, in run
    elastic_launch(
  File "/hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/distributed/launcher/api.py", line 135, in __call__
    return launch_agent(self._config, self._entrypoint, list(args))
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/distributed/launcher/api.py", line 268, in launch_agent
    raise ChildFailedError(
torch.distributed.elastic.multiprocessing.errors.ChildFailedError: 
============================================================
/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/agro_nt_scripts/train_agront_lora_regression.py FAILED
------------------------------------------------------------
Failures:
[1]:
  time      : 2025-06-19_22:14:15
  host      : t1024n3.hpccluster
  rank      : 3 (local_rank: 3)
  exitcode  : 1 (pid: 565950)
  error_file: <N/A>
  traceback : To enable traceback see: https://pytorch.org/docs/stable/elastic/errors.html
------------------------------------------------------------
Root Cause (first observed failure):
[0]:
  time      : 2025-06-19_22:14:15
  host      : t1024n3.hpccluster
  rank      : 0 (local_rank: 0)
  exitcode  : 1 (pid: 565947)
  error_file: <N/A>
  traceback : To enable traceback see: https://pytorch.org/docs/stable/elastic/errors.html
============================================================

ERROR conda.cli.main_run:execute(47): `conda run torchrun --nproc_per_node=4 /ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/agro_nt_scripts/train_agront_lora_regression.py --model_name_or_path /ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/DNABERT-2-117M --data_path /ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/filtering_out_low_promoter_only/soy_1500up_0down_42_log2plus1/ --kmer -1 --run_name trying_dnabert --model_max_length 250 --per_device_train_batch_size 32 --per_device_eval_batch_size 32 --gradient_accumulation_steps 5 --learning_rate 3e-4 --num_train_epochs 8 --save_steps 50 --output_dir /ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/filtering_out_low_promoter_only/soy_1500up_0down_42_log2plus1//trying_dnabert --evaluation_strategy steps --eval_steps 50 --warmup_steps 5 --logging_steps 50 --overwrite_output_dir True --log_level info --find_unused_parameters False --use_lora True --lora_r 16 --lora_alpha 32 --lora_dropout 0.3 --fp16 --dataloader_pin_memory False` failed. (See above for error)
[DEBUG] Tokenizer model_max_length = 250[DEBUG] Tokenizer model_max_length = 250
[DEBUG] Tokenizer model_max_length = 250
[DEBUG] Tokenizer model_max_length = 250


parse error: Unmatched '}' at line 1, column 267
parse error: Unmatched '}' at line 1, column 267
parse error: Unmatched '}' at line 1, column 266
parse error: Unmatched '}' at line 1, column 266
