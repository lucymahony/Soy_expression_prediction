Running global analysis
Script started
Parsing arguments
Some weights of EsmModel were not initialized from the model checkpoint at /ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/replicate_AgroNT/sweep_logs/lr_3e-5/checkpoint-18856/ and are newly initialized: ['esm.pooler.dense.bias', 'esm.pooler.dense.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
Loading model
Model loaded successfully
The models max length is 1024
Using model from: /ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/replicate_AgroNT/sweep_logs/lr_3e-5/checkpoint-18856/
Test passed!
 There are 4803 sequences
Attention scores for multiple sequences saved to glycine_max_test_attention_lr_3e-5_checkpoint-18856.csv
Attention matrices computed for
Line plot saved to test_histogram.png
ATCGGA: count=3, p-value=2.91e-10
GCTTGA: count=2, p-value=8.93e-07
CGATTA: count=1, p-value=1.46e-03
