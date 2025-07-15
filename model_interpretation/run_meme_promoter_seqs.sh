#!/bin/bash
#SBATCH --cpus-per-task=1
#SBATCH -c 1
#SBATCH -p ei-medium 
#SBATCH --mem  64G
#SBATCH --output output_%x

meme_image=../../arabidopsis_circadian_binary_classicalML/statistical_distributions/memesuite.img
JASPAR=../../arabidopsis_circadian_binary_classicalML/statistical_distributions/input_matrixes/JASPAR_PFMs_non_redundant_meme.txt 
promoter_seqs=/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/data/plant-genomic-benchmark/gene_exp/glycine_max_test.fa

singularity exec $meme_image fimo --o  meme_out_prom/ $JASPAR $promoter_seqs

 
