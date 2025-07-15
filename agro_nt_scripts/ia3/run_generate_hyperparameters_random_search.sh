#!/bin/bash
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH --mem 5G
#SBATCH --time=0-00:10:00
#SBATCH --output output_%x
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk

number_trails=50
hyper_param_csv_file_path=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/hyperparameter_configs.csv

source ~/.bashrc
mamba activate /hpc-home/mahony/miniforge3
conda run -n transformers python generate_hyperparameters_random_search.py $number_trails $hyper_param_csv_file_path 
