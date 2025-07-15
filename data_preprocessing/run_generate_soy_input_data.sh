#!/bin/bash
#SBATCH -c 1                      
#SBATCH --mem 5G 
#SBATCH --time=0-00:30                   
#SBATCH -p ei-short                  
#SBATCH --output logs/output_%x
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

# Set TPM filtereing thresholds
thresholds=(
  "threshold,0.5,None"
  "threshold,0.07,9.17"
  "threshold,None,None"
  "cv,None,None"
)
output_names=(
  "threshold__0.5_None"
  "threshold__0.07_9.17"
  "nofilter__None_None"
  "cv__None_None"
)

# Set up and downstream input sequence parameters [options are 150, 1,5, 5, 10]
upstream_values=(150 1000 5000 10000)
downstream_values=(150 1000 5000 10000)
upstream_values=(150)
downstream_values=(5000)

# Loop over upstream and downstream combinations
for distance_upstream in "${upstream_values[@]}"; do
  for distance_downstream in "${downstream_values[@]}"; do

    # Determine if promoter-only - Yes as I am defining relative to the TSS 
    # Set promoter_only to "False" to include the transcript sequences. 
    promoter_only="True"


    # Build promoter dictionary path dynamically
    promoter_dictionary_path="${repo}/intermediate_data/promoter_sequences/promoters_${distance_upstream}up_${distance_downstream}down_soy.fa"

    # Loop over thresholding strategies
    for i in "${!thresholds[@]}"; do
      IFS="," read -r filtering_method lower_threshold upper_threshold <<< "${thresholds[$i]}"
      output_name="${output_names[$i]}"
      
      # Build output directory and plot path
      output_file_directory="${repo}/intermediate_data/${output_name}_${distance_upstream}up_${distance_downstream}down"
      plot_file_path="${output_file_directory}/"

      # Create output directory
      mkdir -p "$output_file_directory"

      # Log parameters to file for reproducibility
      cat << EOF > "${output_file_directory}/params.log"

distance_upstream: $distance_upstream
distance_downstream: $distance_downstream
promoter_only: $promoter_only
filtering_method: $filtering_method
lower_threshold: $lower_threshold
upper_threshold: $upper_threshold
random_state: $random_state
tissue: $tissue
EOF

      echo "======================================"
      echo "Running with:"
      echo "  Upstream: $distance_upstream"
      echo "  Downstream: $distance_downstream"
      echo "  Promoter only: $promoter_only"
      echo "  Filtering method: $filtering_method"
      echo "  Thresholds: lower=$lower_threshold, upper=$upper_threshold"
      echo "  Output dir: $output_file_directory"
      echo "======================================"

      # Run Python script
      conda run -n miniconda_dna python generate_soy_input_data.py \
        "$distance_upstream" "$distance_downstream" "$random_state" \
        "$transcript_dictionary_path" "$promoter_dictionary_path" \
        "$metadata_path" "$tpm_path" "$tissue" "$output_file_directory" \
        "$plot_file_path" "$filtering_method" "$lower_threshold" "$upper_threshold" "$promoter_only"

    done
  done
done
