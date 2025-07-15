Wed Jun 11 14:59:58 2025       
+-----------------------------------------------------------------------------------------+
| NVIDIA-SMI 560.35.03              Driver Version: 560.35.03      CUDA Version: 12.6     |
|-----------------------------------------+------------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
|                                         |                        |               MIG M. |
|=========================================+========================+======================|
|   0  NVIDIA A100 80GB PCIe          On  |   00000000:E3:00.0 Off |                    0 |
| N/A   34C    P0             55W /  300W |       1MiB /  81920MiB |      0%      Default |
|                                         |                        |             Disabled |
+-----------------------------------------+------------------------+----------------------+
                                                                                         
+-----------------------------------------------------------------------------------------+
| Processes:                                                                              |
|  GPU   GI   CI        PID   Type   Process name                              GPU Memory |
|        ID   ID                                                               Usage      |
|=========================================================================================|
|  No running processes found                                                             |
+-----------------------------------------------------------------------------------------+
CUDA available: True
CUDA device: 0
Starting train_lora_regression script
Some weights of EsmModel were not initialized from the model checkpoint at /ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b and are newly initialized: ['esm.pooler.dense.bias', 'esm.pooler.dense.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
Loading adapter weights from /ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/filtering_out_low/soy_1500up_0down_42_log2plus1/lr_3e-8_r_32_alpha_32_dropout_0.05/checkpoint-5350/ led to unexpected keys not found in the model:  ['classifier.dense.bias', 'classifier.dense.weight', 'classifier.out_proj.bias', 'classifier.out_proj.weight', 'esm.encoder.layer.0.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.0.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.0.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.0.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.1.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.1.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.1.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.1.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.10.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.10.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.10.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.10.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.11.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.11.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.11.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.11.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.12.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.12.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.12.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.12.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.13.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.13.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.13.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.13.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.14.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.14.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.14.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.14.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.15.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.15.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.15.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.15.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.16.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.16.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.16.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.16.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.17.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.17.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.17.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.17.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.18.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.18.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.18.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.18.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.19.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.19.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.19.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.19.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.2.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.2.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.2.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.2.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.20.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.20.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.20.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.20.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.21.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.21.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.21.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.21.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.22.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.22.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.22.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.22.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.23.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.23.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.23.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.23.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.24.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.24.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.24.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.24.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.25.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.25.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.25.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.25.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.26.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.26.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.26.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.26.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.27.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.27.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.27.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.27.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.28.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.28.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.28.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.28.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.29.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.29.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.29.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.29.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.3.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.3.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.3.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.3.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.30.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.30.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.30.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.30.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.31.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.31.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.31.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.31.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.32.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.32.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.32.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.32.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.33.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.33.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.33.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.33.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.34.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.34.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.34.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.34.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.35.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.35.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.35.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.35.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.36.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.36.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.36.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.36.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.37.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.37.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.37.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.37.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.38.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.38.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.38.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.38.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.39.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.39.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.39.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.39.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.4.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.4.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.4.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.4.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.5.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.5.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.5.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.5.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.6.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.6.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.6.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.6.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.7.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.7.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.7.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.7.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.8.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.8.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.8.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.8.attention.self.value.lora_B.default.weight', 'esm.encoder.layer.9.attention.self.query.lora_A.default.weight', 'esm.encoder.layer.9.attention.self.query.lora_B.default.weight', 'esm.encoder.layer.9.attention.self.value.lora_A.default.weight', 'esm.encoder.layer.9.attention.self.value.lora_B.default.weight']. 
trainable params: 7,680,000 || all params: 992,778,102 || trainable%: 0.7735867647088776
/hpc-home/mahony/.local/lib/python3.12/site-packages/accelerate/accelerator.py:436: FutureWarning: Passing the following arguments to `Accelerator` is deprecated and will be removed in version 1.0 of Accelerate: dict_keys(['dispatch_batches', 'split_batches', 'even_batches', 'use_seedable_sampler']). Please pass an `accelerate.DataLoaderConfiguration` instead: 
dataloader_config = DataLoaderConfiguration(dispatch_batches=None, split_batches=False, even_batches=True, use_seedable_sampler=True)
  warnings.warn(
  0%|          | 0/107212 [00:00<?, ?it/s]Debugging!
<class 'peft.peft_model.PeftModelForSequenceClassification'>
Help on PeftModelForSequenceClassification in module peft.peft_model object:

class PeftModelForSequenceClassification(PeftModel)
 |  PeftModelForSequenceClassification(model: 'torch.nn.Module', peft_config: 'PeftConfig', adapter_name: 'str' = 'default') -> 'None'
 |
 |  Peft model for sequence classification tasks.
 |
 |  Args:
 |      model ([`~transformers.PreTrainedModel`]): Base transformer model.
 |      peft_config ([`PeftConfig`]): Peft config.
 |
 |  **Attributes**:
 |      - **config** ([`~transformers.PretrainedConfig`]) -- The configuration object of the base model.
 |      - **cls_layer_name** (`str`) -- The name of the classification layer.
 |
 |  Example:
 |
 |      ```py
 |      >>> from transformers import AutoModelForSequenceClassification
 |      >>> from peft import PeftModelForSequenceClassification, get_peft_config
 |
 |      >>> config = {
 |      ...     "peft_type": "PREFIX_TUNING",
 |      ...     "task_type": "SEQ_CLS",
 |      ...     "inference_mode": False,
 |      ...     "num_virtual_tokens": 20,
 |      ...     "token_dim": 768,
 |      ...     "num_transformer_submodules": 1,
 |      ...     "num_attention_heads": 12,
 |      ...     "num_layers": 12,
 |      ...     "encoder_hidden_size": 768,
 |      ...     "prefix_projection": False,
 |      ...     "postprocess_past_key_value_function": None,
 |      ... }
 |
 |      >>> peft_config = get_peft_config(config)
 |      >>> model = AutoModelForSequenceClassification.from_pretrained("bert-base-cased")
 |      >>> peft_model = PeftModelForSequenceClassification(model, peft_config)
 |      >>> peft_model.print_trainable_parameters()
 |      trainable params: 370178 || all params: 108680450 || trainable%: 0.3406113979101117
 |      ```
 |
 |  Method resolution order:
 |      PeftModelForSequenceClassification
 |      PeftModel
 |      transformers.utils.hub.PushToHubMixin
 |      torch.nn.modules.module.Module
 |      builtins.object
 |
 |  Methods defined here:
 |
 |  __init__(self, model: 'torch.nn.Module', peft_config: 'PeftConfig', adapter_name: 'str' = 'default') -> 'None'
 |      Initialize self.  See help(type(self)) for accurate signature.
 |
 |  forward(self, input_ids=None, attention_mask=None, inputs_embeds=None, labels=None, output_attentions=None, output_hidden_states=None, return_dict=None, task_ids=None, **kwargs)
 |      Forward pass of the model.
 |
 |  ----------------------------------------------------------------------
 |  Data and other attributes defined here:
 |
 |  __annotations__ = {}
 |
 |  ----------------------------------------------------------------------
 |  Methods inherited from PeftModel:
 |
 |  __getattr__(self, name: 'str')
 |      Forward missing attributes to the wrapped module.
 |
 |  add_adapter(self, adapter_name: 'str', peft_config: 'PeftConfig') -> 'None'
 |      Add an adapter to the model based on the passed configuration.
 |
 |      This adapter is not trained. To load a trained adapter, check out [`PeftModel.load_adapter`].
 |
 |      The name for the new adapter should be unique.
 |
 |      The new adapter is not automatically set as the active adapter. Use [`PeftModel.set_adapter`] to set the active
 |      adapter.
 |
 |      Args:
 |          adapter_name (`str`):
 |              The name of the adapter to be added.
 |          peft_config ([`PeftConfig`]):
 |              The configuration of the adapter to be added.
 |
 |  create_or_update_model_card(self, output_dir: 'str')
 |      Updates or create model card to include information about peft:
 |      1. Adds `peft` library tag
 |      2. Adds peft version
 |      3. Adds base model info
 |      4. Adds quantization information if it was used
 |
 |  disable_adapter(self)
 |      Context manager that disables the adapter module. Use this to run inference on the base model.
 |
 |      Example:
 |
 |      ```py
 |      >>> with model.disable_adapter():
 |      ...     model(inputs)
 |      ```
 |
 |  generate(self, *args, **kwargs)
 |
 |  get_base_model(self) -> 'torch.nn.Module'
 |      Returns the base model.
 |
 |  get_nb_trainable_parameters(self) -> 'tuple[int, int]'
 |      Returns the number of trainable parameters and the number of all parameters in the model.
 |
 |  get_prompt(self, batch_size: 'int', task_ids: 'Optional[torch.Tensor]' = None) -> 'torch.Tensor'
 |      Returns the virtual prompts to use for Peft. Only applicable when using a prompt learning method.
 |
 |  get_prompt_embedding_to_save(self, adapter_name: 'str') -> 'torch.Tensor'
 |      Returns the prompt embedding to save when saving the model. Only applicable when using a prompt learning
 |      method.
 |
 |  load_adapter(self, model_id: 'str', adapter_name: 'str', is_trainable: 'bool' = False, **kwargs: 'Any')
 |      Load a trained adapter into the model.
 |
 |      The name for the new adapter should be unique.
 |
 |      The new adapter is not automatically set as the active adapter. Use [`PeftModel.set_adapter`] to set the active
 |      adapter.
 |
 |      Args:
 |          adapter_name (`str`):
 |              The name of the adapter to be added.
 |          peft_config ([`PeftConfig`]):
 |              The configuration of the adapter to be added.
 |          is_trainable (`bool`, *optional*, defaults to `False`):
 |              Whether the adapter should be trainable or not. If `False`, the adapter will be frozen and can only be
 |              used for inference.
 |          kwargs: (`optional`):
 |              Additional arguments to modify the way the adapter is loaded, e.g. the token for Hugging Face Hub.
 |
 |  print_trainable_parameters(self) -> 'None'
 |      Prints the number of trainable parameters in the model.
 |
 |      Note: print_trainable_parameters() uses get_nb_trainable_parameters() which is different from
 |      num_parameters(only_trainable=True) from huggingface/transformers. get_nb_trainable_parameters() returns
 |      (trainable parameters, all parameters) of the Peft Model which includes modified backbone transformer model.
 |      For techniques like LoRA, the backbone transformer model is modified in place with LoRA modules. However, for
 |      prompt tuning, the backbone transformer model is unmodified. num_parameters(only_trainable=True) returns number
 |      of trainable parameters of the backbone transformer model which can be different.
 |
 |  save_pretrained(self, save_directory: 'str', safe_serialization: 'bool' = True, selected_adapters: 'Optional[list[str]]' = None, save_embedding_layers: 'Union[str, bool]' = 'auto', is_main_process: 'bool' = True, **kwargs: 'Any') -> 'None'
 |      This function saves the adapter model and the adapter configuration files to a directory, so that it can be
 |      reloaded using the [`PeftModel.from_pretrained`] class method, and also used by the [`PeftModel.push_to_hub`]
 |      method.
 |
 |      Args:
 |          save_directory (`str`):
 |              Directory where the adapter model and configuration files will be saved (will be created if it does not
 |              exist).
 |          safe_serialization (`bool`, *optional*):
 |              Whether to save the adapter files in safetensors format, defaults to `True`.
 |          selected_adapters (`List[str]`,  *optional*):
 |              A list of adapters to be saved. If `None`, will default to all adapters.
 |          save_embedding_layers (`Union[bool, str]`, *optional*, defaults to `"auto"`):
 |              If `True`, save the embedding layers in addition to adapter weights. If `auto`, checks the common
 |              embedding layers `peft.utils.other.EMBEDDING_LAYER_NAMES` in config's `target_modules` when available.
 |              and automatically sets the boolean flag. This only works for 🤗 transformers models.
 |          is_main_process (`bool`, *optional*):
 |              Whether the process calling this is the main process or not. Will default to `True`. Will not save the
 |              checkpoint if not on the main process, which is important for multi device setups (e.g. DDP).
 |          kwargs (additional keyword arguments, *optional*):
 |              Additional keyword arguments passed along to the `push_to_hub` method.
 |
 |  set_adapter(self, adapter_name: 'str') -> 'None'
 |      Sets the active adapter.
 |
 |      Only one adapter can be active at a time.
 |
 |      Additionally, this function will set the specified adapter to trainable (i.e., requires_grad=True). If this is
 |      not desired, use the following code.
 |
 |      ```py
 |      >>> for name, param in model_peft.named_parameters():
 |      ...     if ...:  # some check on name (ex. if 'lora' in name)
 |      ...         param.requires_grad = False
 |      ```
 |
 |      Args:
 |          adapter_name (`str`):
 |              The name of the adapter to be set as active. The adapter must be loaded first.
 |
 |  set_additional_trainable_modules(self, peft_config, adapter_name)
 |
 |  ----------------------------------------------------------------------
 |  Class methods inherited from PeftModel:
 |
 |  from_pretrained(model: 'torch.nn.Module', model_id: 'Union[str, os.PathLike]', adapter_name: 'str' = 'default', is_trainable: 'bool' = False, config: 'Optional[PeftConfig]' = None, **kwargs: 'Any') -> 'PeftModel' from builtins.type
 |      Instantiate a PEFT model from a pretrained model and loaded PEFT weights.
 |
 |      Note that the passed `model` may be modified inplace.
 |
 |      Args:
 |          model ([`torch.nn.Module`]):
 |              The model to be adapted. For 🤗 Transformers models, the model should be initialized with the
 |              [`~transformers.PreTrainedModel.from_pretrained`].
 |          model_id (`str` or `os.PathLike`):
 |              The name of the PEFT configuration to use. Can be either:
 |                  - A string, the `model id` of a PEFT configuration hosted inside a model repo on the Hugging Face
 |                    Hub.
 |                  - A path to a directory containing a PEFT configuration file saved using the `save_pretrained`
 |                    method (`./my_peft_config_directory/`).
 |          adapter_name (`str`, *optional*, defaults to `"default"`):
 |              The name of the adapter to be loaded. This is useful for loading multiple adapters.
 |          is_trainable (`bool`, *optional*, defaults to `False`):
 |              Whether the adapter should be trainable or not. If `False`, the adapter will be frozen and can only be
 |              used for inference.
 |          config ([`~peft.PeftConfig`], *optional*):
 |              The configuration object to use instead of an automatically loaded configuration. This configuration
 |              object is mutually exclusive with `model_id` and `kwargs`. This is useful when configuration is already
 |              loaded before calling `from_pretrained`.
 |          kwargs: (`optional`):
 |              Additional keyword arguments passed along to the specific PEFT configuration class.
 |
 |  ----------------------------------------------------------------------
 |  Readonly properties inherited from PeftModel:
 |
 |  active_adapters
 |
 |  active_peft_config
 |
 |  base_model_torch_dtype
 |
 |  ----------------------------------------------------------------------
 |  Data descriptors inherited from PeftModel:
 |
 |  peft_config
 |
 |  ----------------------------------------------------------------------
 |  Methods inherited from transformers.utils.hub.PushToHubMixin:
 |
 |  push_to_hub(self, repo_id: str, use_temp_dir: Optional[bool] = None, commit_message: Optional[str] = None, private: Optional[bool] = None, token: Union[bool, str, NoneType] = None, max_shard_size: Union[int, str, NoneType] = '5GB', create_pr: bool = False, safe_serialization: bool = True, revision: str = None, commit_description: str = None, tags: Optional[List[str]] = None, **deprecated_kwargs) -> str
 |      Upload the {object_files} to the 🤗 Model Hub.
 |
 |      Parameters:
 |          repo_id (`str`):
 |              The name of the repository you want to push your {object} to. It should contain your organization name
 |              when pushing to a given organization.
 |          use_temp_dir (`bool`, *optional*):
 |              Whether or not to use a temporary directory to store the files saved before they are pushed to the Hub.
 |              Will default to `True` if there is no directory named like `repo_id`, `False` otherwise.
 |          commit_message (`str`, *optional*):
 |              Message to commit while pushing. Will default to `"Upload {object}"`.
 |          private (`bool`, *optional*):
 |              Whether or not the repository created should be private.
 |          token (`bool` or `str`, *optional*):
 |              The token to use as HTTP bearer authorization for remote files. If `True`, will use the token generated
 |              when running `huggingface-cli login` (stored in `~/.huggingface`). Will default to `True` if `repo_url`
 |              is not specified.
 |          max_shard_size (`int` or `str`, *optional*, defaults to `"5GB"`):
 |              Only applicable for models. The maximum size for a checkpoint before being sharded. Checkpoints shard
 |              will then be each of size lower than this size. If expressed as a string, needs to be digits followed
 |              by a unit (like `"5MB"`). We default it to `"5GB"` so that users can easily load models on free-tier
 |              Google Colab instances without any CPU OOM issues.
 |          create_pr (`bool`, *optional*, defaults to `False`):
 |              Whether or not to create a PR with the uploaded files or directly commit.
 |          safe_serialization (`bool`, *optional*, defaults to `True`):
 |              Whether or not to convert the model weights in safetensors format for safer serialization.
 |          revision (`str`, *optional*):
 |              Branch to push the uploaded files to.
 |          commit_description (`str`, *optional*):
 |              The description of the commit that will be created
 |          tags (`List[str]`, *optional*):
 |              List of tags to push on the Hub.
 |
 |      Examples:
 |
 |      ```python
 |      from transformers import {object_class}
 |
 |      {object} = {object_class}.from_pretrained("google-bert/bert-base-cased")
 |
 |      # Push the {object} to your namespace with the name "my-finetuned-bert".
 |      {object}.push_to_hub("my-finetuned-bert")
 |
 |      # Push the {object} to an organization with the name "my-finetuned-bert".
 |      {object}.push_to_hub("huggingface/my-finetuned-bert")
 |      ```
 |
 |  ----------------------------------------------------------------------
 |  Data descriptors inherited from transformers.utils.hub.PushToHubMixin:
 |
 |  __dict__
 |      dictionary for instance variables
 |
 |  __weakref__
 |      list of weak references to the object
 |
 |  ----------------------------------------------------------------------
 |  Methods inherited from torch.nn.modules.module.Module:
 |
 |  __call__ = _wrapped_call_impl(self, *args, **kwargs)
 |
 |  __delattr__(self, name)
 |      Implement delattr(self, name).
 |
 |  __dir__(self)
 |      Default dir() implementation.
 |
 |  __getstate__(self)
 |      Helper for pickle.
 |
 |  __repr__(self)
 |      Return repr(self).
 |
 |  __setattr__(self, name: str, value: Union[torch.Tensor, ForwardRef('Module')]) -> None
 |      Implement setattr(self, name, value).
 |
 |  __setstate__(self, state)
 |
 |  add_module(self, name: str, module: Optional[ForwardRef('Module')]) -> None
 |      Add a child module to the current module.
 |
 |      The module can be accessed as an attribute using the given name.
 |
 |      Args:
 |          name (str): name of the child module. The child module can be
 |              accessed from this module using the given name
 |          module (Module): child module to be added to the module.
 |
 |  apply(self: ~T, fn: Callable[[ForwardRef('Module')], NoneType]) -> ~T
 |      Apply ``fn`` recursively to every submodule (as returned by ``.children()``) as well as self.
 |
 |      Typical use includes initializing the parameters of a model
 |      (see also :ref:`nn-init-doc`).
 |
 |      Args:
 |          fn (:class:`Module` -> None): function to be applied to each submodule
 |
 |      Returns:
 |          Module: self
 |
 |      Example::
 |
 |          >>> @torch.no_grad()
 |          >>> def init_weights(m):
 |          >>>     print(m)
 |          >>>     if type(m) == nn.Linear:
 |          >>>         m.weight.fill_(1.0)
 |          >>>         print(m.weight)
 |          >>> net = nn.Sequential(nn.Linear(2, 2), nn.Linear(2, 2))
 |          >>> net.apply(init_weights)
 |          Linear(in_features=2, out_features=2, bias=True)
 |          Parameter containing:
 |          tensor([[1., 1.],
 |                  [1., 1.]], requires_grad=True)
 |          Linear(in_features=2, out_features=2, bias=True)
 |          Parameter containing:
 |          tensor([[1., 1.],
 |                  [1., 1.]], requires_grad=True)
 |          Sequential(
 |            (0): Linear(in_features=2, out_features=2, bias=True)
 |            (1): Linear(in_features=2, out_features=2, bias=True)
 |          )
 |
 |  bfloat16(self: ~T) -> ~T
 |      Casts all floating point parameters and buffers to ``bfloat16`` datatype.
 |
 |      .. note::
 |          This method modifies the module in-place.
 |
 |      Returns:
 |          Module: self
 |
 |  buffers(self, recurse: bool = True) -> Iterator[torch.Tensor]
 |      Return an iterator over module buffers.
 |
 |      Args:
 |          recurse (bool): if True, then yields buffers of this module
 |              and all submodules. Otherwise, yields only buffers that
 |              are direct members of this module.
 |
 |      Yields:
 |          torch.Tensor: module buffer
 |
 |      Example::
 |
 |          >>> # xdoctest: +SKIP("undefined vars")
 |          >>> for buf in model.buffers():
 |          >>>     print(type(buf), buf.size())
 |          <class 'torch.Tensor'> (20L,)
 |          <class 'torch.Tensor'> (20L, 1L, 5L, 5L)
 |
 |  children(self) -> Iterator[ForwardRef('Module')]
 |      Return an iterator over immediate children modules.
 |
 |      Yields:
 |          Module: a child module
 |
 |  compile(self, *args, **kwargs)
 |      Compile this Module's forward using :func:`torch.compile`.
 |
 |      This Module's `__call__` method is compiled and all arguments are passed as-is
 |      to :func:`torch.compile`.
 |
 |      See :func:`torch.compile` for details on the arguments for this function.
 |
 |  cpu(self: ~T) -> ~T
 |      Move all model parameters and buffers to the CPU.
 |
 |      .. note::
 |          This method modifies the module in-place.
 |
 |      Returns:
 |          Module: self
 |
 |  cuda(self: ~T, device: Union[int, torch.device, NoneType] = None) -> ~T
 |      Move all model parameters and buffers to the GPU.
 |
 |      This also makes associated parameters and buffers different objects. So
 |      it should be called before constructing optimizer if the module will
 |      live on GPU while being optimized.
 |
 |      .. note::
 |          This method modifies the module in-place.
 |
 |      Args:
 |          device (int, optional): if specified, all parameters will be
 |              copied to that device
 |
 |      Returns:
 |          Module: self
 |
 |  double(self: ~T) -> ~T
 |      Casts all floating point parameters and buffers to ``double`` datatype.
 |
 |      .. note::
 |          This method modifies the module in-place.
 |
 |      Returns:
 |          Module: self
 |
 |  eval(self: ~T) -> ~T
 |      Set the module in evaluation mode.
 |
 |      This has any effect only on certain modules. See documentations of
 |      particular modules for details of their behaviors in training/evaluation
 |      mode, if they are affected, e.g. :class:`Dropout`, :class:`BatchNorm`,
 |      etc.
 |
 |      This is equivalent with :meth:`self.train(False) <torch.nn.Module.train>`.
 |
 |      See :ref:`locally-disable-grad-doc` for a comparison between
 |      `.eval()` and several similar mechanisms that may be confused with it.
 |
 |      Returns:
 |          Module: self
 |
 |  extra_repr(self) -> str
 |      Set the extra representation of the module.
 |
 |      To print customized extra information, you should re-implement
 |      this method in your own modules. Both single-line and multi-line
 |      strings are acceptable.
 |
 |  float(self: ~T) -> ~T
 |      Casts all floating point parameters and buffers to ``float`` datatype.
 |
 |      .. note::
 |          This method modifies the module in-place.
 |
 |      Returns:
 |          Module: self
 |
 |  get_buffer(self, target: str) -> 'Tensor'
 |      Return the buffer given by ``target`` if it exists, otherwise throw an error.
 |
 |      See the docstring for ``get_submodule`` for a more detailed
 |      explanation of this method's functionality as well as how to
 |      correctly specify ``target``.
 |
 |      Args:
 |          target: The fully-qualified string name of the buffer
 |              to look for. (See ``get_submodule`` for how to specify a
 |              fully-qualified string.)
 |
 |      Returns:
 |          torch.Tensor: The buffer referenced by ``target``
 |
 |      Raises:
 |          AttributeError: If the target string references an invalid
 |              path or resolves to something that is not a
 |              buffer
 |
 |  get_extra_state(self) -> Any
 |      Return any extra state to include in the module's state_dict.
 |
 |      Implement this and a corresponding :func:`set_extra_state` for your module
 |      if you need to store extra state. This function is called when building the
 |      module's `state_dict()`.
 |
 |      Note that extra state should be picklable to ensure working serialization
 |      of the state_dict. We only provide provide backwards compatibility guarantees
 |      for serializing Tensors; other objects may break backwards compatibility if
 |      their serialized pickled form changes.
 |
 |      Returns:
 |          object: Any extra state to store in the module's state_dict
 |
 |  get_parameter(self, target: str) -> 'Parameter'
 |      Return the parameter given by ``target`` if it exists, otherwise throw an error.
 |
 |      See the docstring for ``get_submodule`` for a more detailed
 |      explanation of this method's functionality as well as how to
 |      correctly specify ``target``.
 |
 |      Args:
 |          target: The fully-qualified string name of the Parameter
 |              to look for. (See ``get_submodule`` for how to specify a
 |              fully-qualified string.)
 |
 |      Returns:
 |          torch.nn.Parameter: The Parameter referenced by ``target``
 |
 |      Raises:
 |          AttributeError: If the target string references an invalid
 |              path or resolves to something that is not an
 |              ``nn.Parameter``
 |
 |  get_submodule(self, target: str) -> 'Module'
 |      Return the submodule given by ``target`` if it exists, otherwise throw an error.
 |
 |      For example, let's say you have an ``nn.Module`` ``A`` that
 |      looks like this:
 |
 |      .. code-block:: text
 |
 |          A(
 |              (net_b): Module(
 |                  (net_c): Module(
 |                      (conv): Conv2d(16, 33, kernel_size=(3, 3), stride=(2, 2))
 |                  )
 |                  (linear): Linear(in_features=100, out_features=200, bias=True)
 |              )
 |          )
 |
 |      (The diagram shows an ``nn.Module`` ``A``. ``A`` has a nested
 |      submodule ``net_b``, which itself has two submodules ``net_c``
 |      and ``linear``. ``net_c`` then has a submodule ``conv``.)
 |
 |      To check whether or not we have the ``linear`` submodule, we
 |      would call ``get_submodule("net_b.linear")``. To check whether
 |      we have the ``conv`` submodule, we would call
 |      ``get_submodule("net_b.net_c.conv")``.
 |
 |      The runtime of ``get_submodule`` is bounded by the degree
 |      of module nesting in ``target``. A query against
 |      ``named_modules`` achieves the same result, but it is O(N) in
 |      the number of transitive modules. So, for a simple check to see
 |      if some submodule exists, ``get_submodule`` should always be
 |      used.
 |
 |      Args:
 |          target: The fully-qualified string name of the submodule
 |              to look for. (See above example for how to specify a
 |              fully-qualified string.)
 |
 |      Returns:
 |          torch.nn.Module: The submodule referenced by ``target``
 |
 |      Raises:
 |          AttributeError: If the target string references an invalid
 |              path or resolves to something that is not an
 |              ``nn.Module``
 |
 |  half(self: ~T) -> ~T
 |      Casts all floating point parameters and buffers to ``half`` datatype.
 |
 |      .. note::
 |          This method modifies the module in-place.
 |
 |      Returns:
 |          Module: self
 |
 |  ipu(self: ~T, device: Union[int, torch.device, NoneType] = None) -> ~T
 |      Move all model parameters and buffers to the IPU.
 |
 |      This also makes associated parameters and buffers different objects. So
 |      it should be called before constructing optimizer if the module will
 |      live on IPU while being optimized.
 |
 |      .. note::
 |          This method modifies the module in-place.
 |
 |      Arguments:
 |          device (int, optional): if specified, all parameters will be
 |              copied to that device
 |
 |      Returns:
 |          Module: self
 |
 |  load_state_dict(self, state_dict: Mapping[str, Any], strict: bool = True, assign: bool = False)
 |      Copy parameters and buffers from :attr:`state_dict` into this module and its descendants.
 |
 |      If :attr:`strict` is ``True``, then
 |      the keys of :attr:`state_dict` must exactly match the keys returned
 |      by this module's :meth:`~torch.nn.Module.state_dict` function.
 |
 |      .. warning::
 |          If :attr:`assign` is ``True`` the optimizer must be created after
 |          the call to :attr:`load_state_dict`.
 |
 |      Args:
 |          state_dict (dict): a dict containing parameters and
 |              persistent buffers.
 |          strict (bool, optional): whether to strictly enforce that the keys
 |              in :attr:`state_dict` match the keys returned by this module's
 |              :meth:`~torch.nn.Module.state_dict` function. Default: ``True``
 |          assign (bool, optional): whether to assign items in the state
 |              dictionary to their corresponding keys in the module instead
 |              of copying them inplace into the module's current parameters and buffers.
 |              When ``False``, the properties of the tensors in the current
 |              module are preserved while when ``True``, the properties of the
 |              Tensors in the state dict are preserved.
 |              Default: ``False``
 |
 |      Returns:
 |          ``NamedTuple`` with ``missing_keys`` and ``unexpected_keys`` fields:
 |              * **missing_keys** is a list of str containing the missing keys
 |              * **unexpected_keys** is a list of str containing the unexpected keys
 |
 |      Note:
 |          If a parameter or buffer is registered as ``None`` and its corresponding key
 |          exists in :attr:`state_dict`, :meth:`load_state_dict` will raise a
 |          ``RuntimeError``.
 |
 |  modules(self) -> Iterator[ForwardRef('Module')]
 |      Return an iterator over all modules in the network.
 |
 |      Yields:
 |          Module: a module in the network
 |
 |      Note:
 |          Duplicate modules are returned only once. In the following
 |          example, ``l`` will be returned only once.
 |
 |      Example::
 |
 |          >>> l = nn.Linear(2, 2)
 |          >>> net = nn.Sequential(l, l)
 |          >>> for idx, m in enumerate(net.modules()):
 |          ...     print(idx, '->', m)
 |
 |          0 -> Sequential(
 |            (0): Linear(in_features=2, out_features=2, bias=True)
 |            (1): Linear(in_features=2, out_features=2, bias=True)
 |          )
 |          1 -> Linear(in_features=2, out_features=2, bias=True)
 |
 |  named_buffers(self, prefix: str = '', recurse: bool = True, remove_duplicate: bool = True) -> Iterator[Tuple[str, torch.Tensor]]
 |      Return an iterator over module buffers, yielding both the name of the buffer as well as the buffer itself.
 |
 |      Args:
 |          prefix (str): prefix to prepend to all buffer names.
 |          recurse (bool, optional): if True, then yields buffers of this module
 |              and all submodules. Otherwise, yields only buffers that
 |              are direct members of this module. Defaults to True.
 |          remove_duplicate (bool, optional): whether to remove the duplicated buffers in the result. Defaults to True.
 |
 |      Yields:
 |          (str, torch.Tensor): Tuple containing the name and buffer
 |
 |      Example::
 |
 |          >>> # xdoctest: +SKIP("undefined vars")
 |          >>> for name, buf in self.named_buffers():
 |          >>>     if name in ['running_var']:
 |          >>>         print(buf.size())
 |
 |  named_children(self) -> Iterator[Tuple[str, ForwardRef('Module')]]
 |      Return an iterator over immediate children modules, yielding both the name of the module as well as the module itself.
 |
 |      Yields:
 |          (str, Module): Tuple containing a name and child module
 |
 |      Example::
 |
 |          >>> # xdoctest: +SKIP("undefined vars")
 |          >>> for name, module in model.named_children():
 |          >>>     if name in ['conv4', 'conv5']:
 |          >>>         print(module)
 |
 |  named_modules(self, memo: Optional[Set[ForwardRef('Module')]] = None, prefix: str = '', remove_duplicate: bool = True)
 |      Return an iterator over all modules in the network, yielding both the name of the module as well as the module itself.
 |
 |      Args:
 |          memo: a memo to store the set of modules already added to the result
 |          prefix: a prefix that will be added to the name of the module
 |          remove_duplicate: whether to remove the duplicated module instances in the result
 |              or not
 |
 |      Yields:
 |          (str, Module): Tuple of name and module
 |
 |      Note:
 |          Duplicate modules are returned only once. In the following
 |          example, ``l`` will be returned only once.
 |
 |      Example::
 |
 |          >>> l = nn.Linear(2, 2)
 |          >>> net = nn.Sequential(l, l)
 |          >>> for idx, m in enumerate(net.named_modules()):
 |          ...     print(idx, '->', m)
 |
 |          0 -> ('', Sequential(
 |            (0): Linear(in_features=2, out_features=2, bias=True)
 |            (1): Linear(in_features=2, out_features=2, bias=True)
 |          ))
 |          1 -> ('0', Linear(in_features=2, out_features=2, bias=True))
 |
 |  named_parameters(self, prefix: str = '', recurse: bool = True, remove_duplicate: bool = True) -> Iterator[Tuple[str, torch.nn.parameter.Parameter]]
 |      Return an iterator over module parameters, yielding both the name of the parameter as well as the parameter itself.
 |
 |      Args:
 |          prefix (str): prefix to prepend to all parameter names.
 |          recurse (bool): if True, then yields parameters of this module
 |              and all submodules. Otherwise, yields only parameters that
 |              are direct members of this module.
 |          remove_duplicate (bool, optional): whether to remove the duplicated
 |              parameters in the result. Defaults to True.
 |
 |      Yields:
 |          (str, Parameter): Tuple containing the name and parameter
 |
 |      Example::
 |
 |          >>> # xdoctest: +SKIP("undefined vars")
 |          >>> for name, param in self.named_parameters():
 |          >>>     if name in ['bias']:
 |          >>>         print(param.size())
 |
 |  parameters(self, recurse: bool = True) -> Iterator[torch.nn.parameter.Parameter]
 |      Return an iterator over module parameters.
 |
 |      This is typically passed to an optimizer.
 |
 |      Args:
 |          recurse (bool): if True, then yields parameters of this module
 |              and all submodules. Otherwise, yields only parameters that
 |              are direct members of this module.
 |
 |      Yields:
 |          Parameter: module parameter
 |
 |      Example::
 |
 |          >>> # xdoctest: +SKIP("undefined vars")
 |          >>> for param in model.parameters():
 |          >>>     print(type(param), param.size())
 |          <class 'torch.Tensor'> (20L,)
 |          <class 'torch.Tensor'> (20L, 1L, 5L, 5L)
 |
 |  register_backward_hook(self, hook: Callable[[ForwardRef('Module'), Union[Tuple[torch.Tensor, ...], torch.Tensor], Union[Tuple[torch.Tensor, ...], torch.Tensor]], Union[NoneType, Tuple[torch.Tensor, ...], torch.Tensor]]) -> torch.utils.hooks.RemovableHandle
 |      Register a backward hook on the module.
 |
 |      This function is deprecated in favor of :meth:`~torch.nn.Module.register_full_backward_hook` and
 |      the behavior of this function will change in future versions.
 |
 |      Returns:
 |          :class:`torch.utils.hooks.RemovableHandle`:
 |              a handle that can be used to remove the added hook by calling
 |              ``handle.remove()``
 |
 |  register_buffer(self, name: str, tensor: Optional[torch.Tensor], persistent: bool = True) -> None
 |      Add a buffer to the module.
 |
 |      This is typically used to register a buffer that should not to be
 |      considered a model parameter. For example, BatchNorm's ``running_mean``
 |      is not a parameter, but is part of the module's state. Buffers, by
 |      default, are persistent and will be saved alongside parameters. This
 |      behavior can be changed by setting :attr:`persistent` to ``False``. The
 |      only difference between a persistent buffer and a non-persistent buffer
 |      is that the latter will not be a part of this module's
 |      :attr:`state_dict`.
 |
 |      Buffers can be accessed as attributes using given names.
 |
 |      Args:
 |          name (str): name of the buffer. The buffer can be accessed
 |              from this module using the given name
 |          tensor (Tensor or None): buffer to be registered. If ``None``, then operations
 |              that run on buffers, such as :attr:`cuda`, are ignored. If ``None``,
 |              the buffer is **not** included in the module's :attr:`state_dict`.
 |          persistent (bool): whether the buffer is part of this module's
 |              :attr:`state_dict`.
 |
 |      Example::
 |
 |          >>> # xdoctest: +SKIP("undefined vars")
 |          >>> self.register_buffer('running_mean', torch.zeros(num_features))
 |
 |  register_forward_hook(self, hook: Union[Callable[[~T, Tuple[Any, ...], Any], Optional[Any]], Callable[[~T, Tuple[Any, ...], Dict[str, Any], Any], Optional[Any]]], *, prepend: bool = False, with_kwargs: bool = False, always_call: bool = False) -> torch.utils.hooks.RemovableHandle
 |      Register a forward hook on the module.
 |
 |      The hook will be called every time after :func:`forward` has computed an output.
 |
 |      If ``with_kwargs`` is ``False`` or not specified, the input contains only
 |      the positional arguments given to the module. Keyword arguments won't be
 |      passed to the hooks and only to the ``forward``. The hook can modify the
 |      output. It can modify the input inplace but it will not have effect on
 |      forward since this is called after :func:`forward` is called. The hook
 |      should have the following signature::
 |
 |          hook(module, args, output) -> None or modified output
 |
 |      If ``with_kwargs`` is ``True``, the forward hook will be passed the
 |      ``kwargs`` given to the forward function and be expected to return the
 |      output possibly modified. The hook should have the following signature::
 |
 |          hook(module, args, kwargs, output) -> None or modified output
 |
 |      Args:
 |          hook (Callable): The user defined hook to be registered.
 |          prepend (bool): If ``True``, the provided ``hook`` will be fired
 |              before all existing ``forward`` hooks on this
 |              :class:`torch.nn.modules.Module`. Otherwise, the provided
 |              ``hook`` will be fired after all existing ``forward`` hooks on
 |              this :class:`torch.nn.modules.Module`. Note that global
 |              ``forward`` hooks registered with
 |              :func:`register_module_forward_hook` will fire before all hooks
 |              registered by this method.
 |              Default: ``False``
 |          with_kwargs (bool): If ``True``, the ``hook`` will be passed the
 |              kwargs given to the forward function.
 |              Default: ``False``
 |          always_call (bool): If ``True`` the ``hook`` will be run regardless of
 |              whether an exception is raised while calling the Module.
 |              Default: ``False``
 |
 |      Returns:
 |          :class:`torch.utils.hooks.RemovableHandle`:
 |              a handle that can be used to remove the added hook by calling
 |              ``handle.remove()``
 |
 |  register_forward_pre_hook(self, hook: Union[Callable[[~T, Tuple[Any, ...]], Optional[Any]], Callable[[~T, Tuple[Any, ...], Dict[str, Any]], Optional[Tuple[Any, Dict[str, Any]]]]], *, prepend: bool = False, with_kwargs: bool = False) -> torch.utils.hooks.RemovableHandle
 |      Register a forward pre-hook on the module.
 |
 |      The hook will be called every time before :func:`forward` is invoked.
 |
 |
 |      If ``with_kwargs`` is false or not specified, the input contains only
 |      the positional arguments given to the module. Keyword arguments won't be
 |      passed to the hooks and only to the ``forward``. The hook can modify the
 |      input. User can either return a tuple or a single modified value in the
 |      hook. We will wrap the value into a tuple if a single value is returned
 |      (unless that value is already a tuple). The hook should have the
 |      following signature::
 |
 |          hook(module, args) -> None or modified input
 |
 |      If ``with_kwargs`` is true, the forward pre-hook will be passed the
 |      kwargs given to the forward function. And if the hook modifies the
 |      input, both the args and kwargs should be returned. The hook should have
 |      the following signature::
 |
 |          hook(module, args, kwargs) -> None or a tuple of modified input and kwargs
 |
 |      Args:
 |          hook (Callable): The user defined hook to be registered.
 |          prepend (bool): If true, the provided ``hook`` will be fired before
 |              all existing ``forward_pre`` hooks on this
 |              :class:`torch.nn.modules.Module`. Otherwise, the provided
 |              ``hook`` will be fired after all existing ``forward_pre`` hooks
 |              on this :class:`torch.nn.modules.Module`. Note that global
 |              ``forward_pre`` hooks registered with
 |              :func:`register_module_forward_pre_hook` will fire before all
 |              hooks registered by this method.
 |              Default: ``False``
 |          with_kwargs (bool): If true, the ``hook`` will be passed the kwargs
 |              given to the forward function.
 |              Default: ``False``
 |
 |      Returns:
 |          :class:`torch.utils.hooks.RemovableHandle`:
 |              a handle that can be used to remove the added hook by calling
 |              ``handle.remove()``
 |
 |  register_full_backward_hook(self, hook: Callable[[ForwardRef('Module'), Union[Tuple[torch.Tensor, ...], torch.Tensor], Union[Tuple[torch.Tensor, ...], torch.Tensor]], Union[NoneType, Tuple[torch.Tensor, ...], torch.Tensor]], prepend: bool = False) -> torch.utils.hooks.RemovableHandle
 |      Register a backward hook on the module.
 |
 |      The hook will be called every time the gradients with respect to a module
 |      are computed, i.e. the hook will execute if and only if the gradients with
 |      respect to module outputs are computed. The hook should have the following
 |      signature::
 |
 |          hook(module, grad_input, grad_output) -> tuple(Tensor) or None
 |
 |      The :attr:`grad_input` and :attr:`grad_output` are tuples that contain the gradients
 |      with respect to the inputs and outputs respectively. The hook should
 |      not modify its arguments, but it can optionally return a new gradient with
 |      respect to the input that will be used in place of :attr:`grad_input` in
 |      subsequent computations. :attr:`grad_input` will only correspond to the inputs given
 |      as positional arguments and all kwarg arguments are ignored. Entries
 |      in :attr:`grad_input` and :attr:`grad_output` will be ``None`` for all non-Tensor
 |      arguments.
 |
 |      For technical reasons, when this hook is applied to a Module, its forward function will
 |      receive a view of each Tensor passed to the Module. Similarly the caller will receive a view
 |      of each Tensor returned by the Module's forward function.
 |
 |      .. warning ::
 |          Modifying inputs or outputs inplace is not allowed when using backward hooks and
 |          will raise an error.
 |
 |      Args:
 |          hook (Callable): The user-defined hook to be registered.
 |          prepend (bool): If true, the provided ``hook`` will be fired before
 |              all existing ``backward`` hooks on this
 |              :class:`torch.nn.modules.Module`. Otherwise, the provided
 |              ``hook`` will be fired after all existing ``backward`` hooks on
 |              this :class:`torch.nn.modules.Module`. Note that global
 |              ``backward`` hooks registered with
 |              :func:`register_module_full_backward_hook` will fire before
 |              all hooks registered by this method.
 |
 |      Returns:
 |          :class:`torch.utils.hooks.RemovableHandle`:
 |              a handle that can be used to remove the added hook by calling
 |              ``handle.remove()``
 |
 |  register_full_backward_pre_hook(self, hook: Callable[[ForwardRef('Module'), Union[Tuple[torch.Tensor, ...], torch.Tensor]], Union[NoneType, Tuple[torch.Tensor, ...], torch.Tensor]], prepend: bool = False) -> torch.utils.hooks.RemovableHandle
 |      Register a backward pre-hook on the module.
 |
 |      The hook will be called every time the gradients for the module are computed.
 |      The hook should have the following signature::
 |
 |          hook(module, grad_output) -> tuple[Tensor] or None
 |
 |      The :attr:`grad_output` is a tuple. The hook should
 |      not modify its arguments, but it can optionally return a new gradient with
 |      respect to the output that will be used in place of :attr:`grad_output` in
 |      subsequent computations. Entries in :attr:`grad_output` will be ``None`` for
 |      all non-Tensor arguments.
 |
 |      For technical reasons, when this hook is applied to a Module, its forward function will
 |      receive a view of each Tensor passed to the Module. Similarly the caller will receive a view
 |      of each Tensor returned by the Module's forward function.
 |
 |      .. warning ::
 |          Modifying inputs inplace is not allowed when using backward hooks and
 |          will raise an error.
 |
 |      Args:
 |          hook (Callable): The user-defined hook to be registered.
 |          prepend (bool): If true, the provided ``hook`` will be fired before
 |              all existing ``backward_pre`` hooks on this
 |              :class:`torch.nn.modules.Module`. Otherwise, the provided
 |              ``hook`` will be fired after all existing ``backward_pre`` hooks
 |              on this :class:`torch.nn.modules.Module`. Note that global
 |              ``backward_pre`` hooks registered with
 |              :func:`register_module_full_backward_pre_hook` will fire before
 |              all hooks registered by this method.
 |
 |      Returns:
 |          :class:`torch.utils.hooks.RemovableHandle`:
 |              a handle that can be used to remove the added hook by calling
 |              ``handle.remove()``
 |
 |  register_load_state_dict_post_hook(self, hook)
 |      Register a post hook to be run after module's ``load_state_dict`` is called.
 |
 |      It should have the following signature::
 |          hook(module, incompatible_keys) -> None
 |
 |      The ``module`` argument is the current module that this hook is registered
 |      on, and the ``incompatible_keys`` argument is a ``NamedTuple`` consisting
 |      of attributes ``missing_keys`` and ``unexpected_keys``. ``missing_keys``
 |      is a ``list`` of ``str`` containing the missing keys and
 |      ``unexpected_keys`` is a ``list`` of ``str`` containing the unexpected keys.
 |
 |      The given incompatible_keys can be modified inplace if needed.
 |
 |      Note that the checks performed when calling :func:`load_state_dict` with
 |      ``strict=True`` are affected by modifications the hook makes to
 |      ``missing_keys`` or ``unexpected_keys``, as expected. Additions to either
 |      set of keys will result in an error being thrown when ``strict=True``, and
 |      clearing out both missing and unexpected keys will avoid an error.
 |
 |      Returns:
 |          :class:`torch.utils.hooks.RemovableHandle`:
 |              a handle that can be used to remove the added hook by calling
 |              ``handle.remove()``
 |
 |  register_module(self, name: str, module: Optional[ForwardRef('Module')]) -> None
 |      Alias for :func:`add_module`.
 |
 |  register_parameter(self, name: str, param: Optional[torch.nn.parameter.Parameter]) -> None
 |      Add a parameter to the module.
 |
 |      The parameter can be accessed as an attribute using given name.
 |
 |      Args:
 |          name (str): name of the parameter. The parameter can be accessed
 |              from this module using the given name
 |          param (Parameter or None): parameter to be added to the module. If
 |              ``None``, then operations that run on parameters, such as :attr:`cuda`,
 |              are ignored. If ``None``, the parameter is **not** included in the
 |              module's :attr:`state_dict`.
 |
 |  register_state_dict_pre_hook(self, hook)
 |      Register a pre-hook for the :meth:`~torch.nn.Module.load_state_dict` method.
 |
 |      These hooks will be called with arguments: ``self``, ``prefix``,
 |      and ``keep_vars`` before calling ``state_dict`` on ``self``. The registered
 |      hooks can be used to perform pre-processing before the ``state_dict``
 |      call is made.
 |
 |  requires_grad_(self: ~T, requires_grad: bool = True) -> ~T
 |      Change if autograd should record operations on parameters in this module.
 |
 |      This method sets the parameters' :attr:`requires_grad` attributes
 |      in-place.
 |
 |      This method is helpful for freezing part of the module for finetuning
 |      or training parts of a model individually (e.g., GAN training).
 |
 |      See :ref:`locally-disable-grad-doc` for a comparison between
 |      `.requires_grad_()` and several similar mechanisms that may be confused with it.
 |
 |      Args:
 |          requires_grad (bool): whether autograd should record operations on
 |                                parameters in this module. Default: ``True``.
 |
 |      Returns:
 |          Module: self
 |
 |  set_extra_state(self, state: Any)
 |      Set extra state contained in the loaded `state_dict`.
 |
 |      This function is called from :func:`load_state_dict` to handle any extra state
 |      found within the `state_dict`. Implement this function and a corresponding
 |      :func:`get_extra_state` for your module if you need to store extra state within its
 |      `state_dict`.
 |
 |      Args:
 |          state (dict): Extra state from the `state_dict`
 |
 |  share_memory(self: ~T) -> ~T
 |      See :meth:`torch.Tensor.share_memory_`.
 |
 |  state_dict(self, *args, destination=None, prefix='', keep_vars=False)
 |      Return a dictionary containing references to the whole state of the module.
 |
 |      Both parameters and persistent buffers (e.g. running averages) are
 |      included. Keys are corresponding parameter and buffer names.
 |      Parameters and buffers set to ``None`` are not included.
 |
 |      .. note::
 |          The returned object is a shallow copy. It contains references
 |          to the module's parameters and buffers.
 |
 |      .. warning::
 |          Currently ``state_dict()`` also accepts positional arguments for
 |          ``destination``, ``prefix`` and ``keep_vars`` in order. However,
 |          this is being deprecated and keyword arguments will be enforced in
 |          future releases.
 |
 |      .. warning::
 |          Please avoid the use of argument ``destination`` as it is not
 |          designed for end-users.
 |
 |      Args:
 |          destination (dict, optional): If provided, the state of module will
 |              be updated into the dict and the same object is returned.
 |              Otherwise, an ``OrderedDict`` will be created and returned.
 |              Default: ``None``.
 |          prefix (str, optional): a prefix added to parameter and buffer
 |              names to compose the keys in state_dict. Default: ``''``.
 |          keep_vars (bool, optional): by default the :class:`~torch.Tensor` s
 |              returned in the state dict are detached from autograd. If it's
 |              set to ``True``, detaching will not be performed.
 |              Default: ``False``.
 |
 |      Returns:
 |          dict:
 |              a dictionary containing a whole state of the module
 |
 |      Example::
 |
 |          >>> # xdoctest: +SKIP("undefined vars")
 |          >>> module.state_dict().keys()
 |          ['bias', 'weight']
 |
 |  to(self, *args, **kwargs)
 |      Move and/or cast the parameters and buffers.
 |
 |      This can be called as
 |
 |      .. function:: to(device=None, dtype=None, non_blocking=False)
 |         :noindex:
 |
 |      .. function:: to(dtype, non_blocking=False)
 |         :noindex:
 |
 |      .. function:: to(tensor, non_blocking=False)
 |         :noindex:
 |
 |      .. function:: to(memory_format=torch.channels_last)
 |         :noindex:
 |
 |      Its signature is similar to :meth:`torch.Tensor.to`, but only accepts
 |      floating point or complex :attr:`dtype`\ s. In addition, this method will
 |      only cast the floating point or complex parameters and buffers to :attr:`dtype`
 |      (if given). The integral parameters and buffers will be moved
 |      :attr:`device`, if that is given, but with dtypes unchanged. When
 |      :attr:`non_blocking` is set, it tries to convert/move asynchronously
 |      with respect to the host if possible, e.g., moving CPU Tensors with
 |      pinned memory to CUDA devices.
 |
 |      See below for examples.
 |
 |      .. note::
 |          This method modifies the module in-place.
 |
 |      Args:
 |          device (:class:`torch.device`): the desired device of the parameters
 |              and buffers in this module
 |          dtype (:class:`torch.dtype`): the desired floating point or complex dtype of
 |              the parameters and buffers in this module
 |          tensor (torch.Tensor): Tensor whose dtype and device are the desired
 |              dtype and device for all parameters and buffers in this module
 |          memory_format (:class:`torch.memory_format`): the desired memory
 |              format for 4D parameters and buffers in this module (keyword
 |              only argument)
 |
 |      Returns:
 |          Module: self
 |
 |      Examples::
 |
 |          >>> # xdoctest: +IGNORE_WANT("non-deterministic")
 |          >>> linear = nn.Linear(2, 2)
 |          >>> linear.weight
 |          Parameter containing:
 |          tensor([[ 0.1913, -0.3420],
 |                  [-0.5113, -0.2325]])
 |          >>> linear.to(torch.double)
 |          Linear(in_features=2, out_features=2, bias=True)
 |          >>> linear.weight
 |          Parameter containing:
 |          tensor([[ 0.1913, -0.3420],
 |                  [-0.5113, -0.2325]], dtype=torch.float64)
 |          >>> # xdoctest: +REQUIRES(env:TORCH_DOCTEST_CUDA1)
 |          >>> gpu1 = torch.device("cuda:1")
 |          >>> linear.to(gpu1, dtype=torch.half, non_blocking=True)
 |          Linear(in_features=2, out_features=2, bias=True)
 |          >>> linear.weight
 |          Parameter containing:
 |          tensor([[ 0.1914, -0.3420],
 |                  [-0.5112, -0.2324]], dtype=torch.float16, device='cuda:1')
 |          >>> cpu = torch.device("cpu")
 |          >>> linear.to(cpu)
 |          Linear(in_features=2, out_features=2, bias=True)
 |          >>> linear.weight
 |          Parameter containing:
 |          tensor([[ 0.1914, -0.3420],
 |                  [-0.5112, -0.2324]], dtype=torch.float16)
 |
 |          >>> linear = nn.Linear(2, 2, bias=None).to(torch.cdouble)
 |          >>> linear.weight
 |          Parameter containing:
 |          tensor([[ 0.3741+0.j,  0.2382+0.j],
 |                  [ 0.5593+0.j, -0.4443+0.j]], dtype=torch.complex128)
 |          >>> linear(torch.ones(3, 2, dtype=torch.cdouble))
 |          tensor([[0.6122+0.j, 0.1150+0.j],
 |                  [0.6122+0.j, 0.1150+0.j],
 |                  [0.6122+0.j, 0.1150+0.j]], dtype=torch.complex128)
 |
 |  to_empty(self: ~T, *, device: Union[int, str, torch.device, NoneType], recurse: bool = True) -> ~T
 |      Move the parameters and buffers to the specified device without copying storage.
 |
 |      Args:
 |          device (:class:`torch.device`): The desired device of the parameters
 |              and buffers in this module.
 |          recurse (bool): Whether parameters and buffers of submodules should
 |              be recursively moved to the specified device.
 |
 |      Returns:
 |          Module: self
 |
 |  train(self: ~T, mode: bool = True) -> ~T
 |      Set the module in training mode.
 |
 |      This has any effect only on certain modules. See documentations of
 |      particular modules for details of their behaviors in training/evaluation
 |      mode, if they are affected, e.g. :class:`Dropout`, :class:`BatchNorm`,
 |      etc.
 |
 |      Args:
 |          mode (bool): whether to set training mode (``True``) or evaluation
 |                       mode (``False``). Default: ``True``.
 |
 |      Returns:
 |          Module: self
 |
 |  type(self: ~T, dst_type: Union[torch.dtype, str]) -> ~T
 |      Casts all parameters and buffers to :attr:`dst_type`.
 |
 |      .. note::
 |          This method modifies the module in-place.
 |
 |      Args:
 |          dst_type (type or string): the desired type
 |
 |      Returns:
 |          Module: self
 |
 |  xpu(self: ~T, device: Union[int, torch.device, NoneType] = None) -> ~T
 |      Move all model parameters and buffers to the XPU.
 |
 |      This also makes associated parameters and buffers different objects. So
 |      it should be called before constructing optimizer if the module will
 |      live on XPU while being optimized.
 |
 |      .. note::
 |          This method modifies the module in-place.
 |
 |      Arguments:
 |          device (int, optional): if specified, all parameters will be
 |              copied to that device
 |
 |      Returns:
 |          Module: self
 |
 |  zero_grad(self, set_to_none: bool = True) -> None
 |      Reset gradients of all model parameters.
 |
 |      See similar function under :class:`torch.optim.Optimizer` for more context.
 |
 |      Args:
 |          set_to_none (bool): instead of setting to zero, set the grads to None.
 |              See :meth:`torch.optim.Optimizer.zero_grad` for details.
 |
 |  ----------------------------------------------------------------------
 |  Data and other attributes inherited from torch.nn.modules.module.Module:
 |
 |  T_destination = ~T_destination
 |
 |  call_super_init = False
 |
 |  dump_patches = False

None
Finished this debugging
Traceback (most recent call last):
  File "/ei/.project-scratch/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/repos/Soy_expression_prediction/agro_nt_scripts/train_lora_regression.py", line 154, in <module>
    main()
  File "/ei/.project-scratch/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/repos/Soy_expression_prediction/agro_nt_scripts/train_lora_regression.py", line 142, in main
    trainer.train()
  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/transformers/trainer.py", line 1780, in train
    return inner_training_loop(
           ^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/transformers/trainer.py", line 2118, in _inner_training_loop
    tr_loss_step = self.training_step(model, inputs)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/transformers/trainer.py", line 3036, in training_step
    loss = self.compute_loss(model, inputs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/transformers/trainer.py", line 3059, in compute_loss
    outputs = model(**inputs)
              ^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/nn/modules/module.py", line 1511, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/nn/modules/module.py", line 1520, in _call_impl
    return forward_call(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/nn/parallel/distributed.py", line 1523, in forward
    else self._run_ddp_forward(*inputs, **kwargs)
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/nn/parallel/distributed.py", line 1359, in _run_ddp_forward
    return self.module(*inputs, **kwargs)  # type: ignore[index]
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/nn/modules/module.py", line 1511, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/nn/modules/module.py", line 1520, in _call_impl
    return forward_call(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/accelerate/utils/operations.py", line 825, in forward
    return model_forward(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/accelerate/utils/operations.py", line 813, in __call__
    return convert_to_fp32(self.model_forward(*args, **kwargs))
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/amp/autocast_mode.py", line 16, in decorate_autocast
    return func(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/peft_model.py", line 937, in forward
    return self.base_model(
           ^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/nn/modules/module.py", line 1511, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/nn/modules/module.py", line 1520, in _call_impl
    return forward_call(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/tuners/tuners_utils.py", line 161, in forward
    return self.model.forward(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/ei/.project-scratch/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/repos/Soy_expression_prediction/agro_nt_scripts/train_lora_regression.py", line 64, in forward
    outputs = self.backbone(input_ids=input_ids, attention_mask=attention_mask, **{k: v for k, v in kwargs.items() if k != "labels"})
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/nn/modules/module.py", line 1511, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/nn/modules/module.py", line 1520, in _call_impl
    return forward_call(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/peft_model.py", line 937, in forward
    return self.base_model(
           ^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/nn/modules/module.py", line 1511, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/miniforge3/envs/transformers/lib/python3.12/site-packages/torch/nn/modules/module.py", line 1520, in _call_impl
    return forward_call(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/hpc-home/mahony/.local/lib/python3.12/site-packages/peft/tuners/tuners_utils.py", line 161, in forward
    return self.model.forward(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
TypeError: EsmModel.forward() got an unexpected keyword argument 'labels'
  0%|          | 0/107212 [00:00<?, ?it/s]
[2025-06-11 15:01:15,036] torch.distributed.elastic.multiprocessing.api: [ERROR] failed (exitcode: 1) local_rank: 0 (pid: 1366391) of binary: /hpc-home/mahony/miniforge3/envs/transformers/bin/python
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
train_lora_regression.py FAILED
------------------------------------------------------------
Failures:
  <NO_OTHER_FAILURES>
------------------------------------------------------------
Root Cause (first observed failure):
[0]:
  time      : 2025-06-11_15:01:15
  host      : t1024n2.hpccluster
  rank      : 0 (local_rank: 0)
  exitcode  : 1 (pid: 1366391)
  error_file: <N/A>
  traceback : To enable traceback see: https://pytorch.org/docs/stable/elastic/errors.html
============================================================
