#!/bin/bash
#SBATCH --cpus-per-task=1
#SBATCH -c 1
#SBATCH -p ei-medium 
#SBATCH --mem  64G
#SBATCH --output output_%x

meme_image=../../arabidopsis_circadian_binary_classicalML/statistical_distributions/memesuite.img
JASPAR=../../arabidopsis_circadian_binary_classicalML/statistical_distributions/input_matrixes/JASPAR_PFMs_non_redundant_meme.txt 


singularity exec $meme_image fimo --thresh 1e-1 --o  meme_out/ $JASPAR motifs/enriched_motifs_0.1.fa

 
