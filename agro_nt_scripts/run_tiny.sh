#!/bin/bash
#SBATCH -p ei-gpu
#SBATCH -c 4                          
#SBATCH --gres=gpu:1                  
#SBATCH --mem=32G                      
#SBATCH --time=10:00:00                 # Up to 10 hours for full training
#SBATCH --output=output_%x_%j.log       # Helpful logging
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=you@ei.ac.uk

echo "Running tiny test script on GPU"
source ~/.bashrc
mamba activate transformers
torchrun tiny_test_script.py 
