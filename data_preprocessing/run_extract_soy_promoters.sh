#!/bin/bash
#SBATCH -c 1                              # number of cores
#SBATCH --mem 56G                         # memory pool for all cores
#SBATCH --time=5-10:00                    # time limit
#SBATCH --output ../logs/extract_promoters.out    # STDOUT and STDERR
#SBATCH --mail-type=END,FAIL              # notifications for job done & fail
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk   # send-to address
#SBATCH --partition=ei-medium

source ~/.bashrc
mamba activate /hpc-home/mahony/miniforge3

repo="/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction"
gene_list_file_path="${repo}/input_data/PRJNA657728_TPM.tsv"
gff3_file_path="${repo}/input_data/Gmax_508_Wm82.a4.v1.gene.gff3"
genome_file_path="${repo}/input_data/Gmax_508_v4.0.fa"

distances=(0 150 1500 4500 6000)

# Loop over all valid combinations
for up in "${distances[@]}"; do
    for down in "${distances[@]}"; do
        total=$((up + down))
        if [ "$total" -le 6000 ]; then
            out_file_path="${repo}/intermediate_data/promoter_sequences/promoters_${up}up_${down}down_soy.fa"
            echo "Generating promoters for ${up} upstream and ${down} downstream..."
            conda run -n miniconda_dna python extract_soy_promoters.py \
                "$up" "$down" \
                "$gene_list_file_path" \
                "$gff3_file_path" \
                "$genome_file_path" \
                "$out_file_path"
        fi
    done
done
