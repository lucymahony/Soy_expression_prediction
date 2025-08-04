#!/bin/bash
#SBATCH -c 1                      
#SBATCH --mem 5G 
#SBATCH --time=0-10:30                   
#SBATCH -p ei-medium                  
#SBATCH --output ../logs/output_%x
#SBATCH --mail-type=END,FAIL         
#SBATCH --mail-user=lucy.mahony@earlham.ac.uk  

# Load environment
source ~/.bashrc
mamba activate /hpc-home/mahony/miniforge3

# Fixed parameters
random_state=42
tissue="leaf"
repo="/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction"
transcript_dictionary_path="${repo}/input_data/Gmax_508_Wm82.a4.v1.transcript.fa"
metadata_path="${repo}/input_data/PRJNA657728_metadata.tsv"
tpm_path="${repo}/input_data/PRJNA657728_TPM.tsv"


thresholds=("threshold,0.5,None" "cv,None,None")
output_names=("threshold_0.5_None" "cv")
thresholds=("threshold,None,None")
output_names=("nofilter__None_None")
upstream_values=(0 150 1500 4500 6000)
downstream_values=(0 150 1500 4500 6000)
upstream_values=(5000)
downstream_values=(1000)

for distance_upstream in "${upstream_values[@]}"; do
  for distance_downstream in "${downstream_values[@]}"; do
    total=$((distance_upstream + distance_downstream))
    if [ "$total" -le 6000 ]; then
      promoter_only="True"
      promoter_dictionary_path="${repo}/intermediate_data/promoter_sequences/promoters_${distance_upstream}up_${distance_downstream}down_soy.fa"
      
      for i in "${!thresholds[@]}"; do
        IFS="," read -r filtering_method lower_threshold upper_threshold <<< "${thresholds[$i]}"
        output_name="${output_names[$i]}"
        output_file_directory="${repo}/intermediate_data/${output_name}_${distance_upstream}up_${distance_downstream}down"
        plot_file_path="${output_file_directory}/"
        mkdir -p "$output_file_directory"

        conda run -n miniconda_dna python generate_soy_input_data.py \
          "$distance_upstream" "$distance_downstream" "$random_state" \
          "$transcript_dictionary_path" "$promoter_dictionary_path" \
          "$metadata_path" "$tpm_path" "$tissue" "$output_file_directory" \
          "$plot_file_path" "$filtering_method" "$lower_threshold" "$upper_threshold" "$promoter_only"
      done 
    fi      
  done
done
