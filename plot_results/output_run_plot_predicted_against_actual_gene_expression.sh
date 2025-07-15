Some weights of the model checkpoint at /ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b were not used when initializing EsmForSequenceClassification: ['lm_head.layer_norm.bias', 'lm_head.dense.weight', 'lm_head.dense.bias', 'lm_head.layer_norm.weight', 'lm_head.decoder.weight', 'lm_head.bias']
- This IS expected if you are initializing EsmForSequenceClassification from the checkpoint of a model trained on another task or with another architecture (e.g. initializing a BertForSequenceClassification model from a BertForPreTraining model).
- This IS NOT expected if you are initializing EsmForSequenceClassification from the checkpoint of a model that you expect to be exactly identical (initializing a BertForSequenceClassification model from a BertForSequenceClassification model).
Some weights of EsmForSequenceClassification were not initialized from the model checkpoint at /ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/dnabert/agro-nucleotide-transformer-1b and are newly initialized: ['classifier.out_proj.bias', 'classifier.out_proj.weight', 'classifier.dense.bias', 'classifier.dense.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
WARNING:root:Perform single sequence classification...
Traceback (most recent call last):
  File "plot_predicted_against_actual_gene_expression.py", line 47, in <module>
    predictions = trainer.predict(test_dataset)
  File "/hpc-home/mahony/.local/lib/python3.8/site-packages/transformers/trainer.py", line 3105, in predict
    output = eval_loop(
  File "/hpc-home/mahony/.local/lib/python3.8/site-packages/transformers/trainer.py", line 3210, in evaluation_loop
    loss, logits, labels = self.prediction_step(model, inputs, prediction_loss_only, ignore_keys=ignore_keys)
  File "/hpc-home/mahony/.local/lib/python3.8/site-packages/transformers/trainer.py", line 3466, in prediction_step
    loss, outputs = self.compute_loss(model, inputs, return_outputs=True)
  File "/hpc-home/mahony/.local/lib/python3.8/site-packages/transformers/trainer.py", line 2767, in compute_loss
    outputs = model(**inputs)
  File "/hpc-home/mahony/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1194, in _call_impl
    return forward_call(*input, **kwargs)
  File "/hpc-home/mahony/.local/lib/python3.8/site-packages/transformers/models/esm/modeling_esm.py", line 1157, in forward
    loss = loss_fct(logits, labels)
  File "/hpc-home/mahony/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1194, in _call_impl
    return forward_call(*input, **kwargs)
  File "/hpc-home/mahony/.local/lib/python3.8/site-packages/torch/nn/modules/loss.py", line 720, in forward
    return F.binary_cross_entropy_with_logits(input, target,
  File "/hpc-home/mahony/.local/lib/python3.8/site-packages/torch/nn/functional.py", line 3160, in binary_cross_entropy_with_logits
    raise ValueError("Target size ({}) must be the same as input size ({})".format(target.size(), input.size()))
ValueError: Target size (torch.Size([8])) must be the same as input size (torch.Size([8, 2]))

ERROR conda.cli.main_run:execute(47): `conda run python plot_predicted_against_actual_gene_expression.py` failed. (See above for error)
Directory exists
Directory exists
File exists

