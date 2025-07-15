# Given a Bedgraph file of ATAC-seq coverage data 
# and a specific genomic range, this script extracts the coverage values
# IF reverse strand orientation, reversed .

import os

def extract_chromatin_coverage(region_start, region_end, region_chrom, base_dir, reverse_strand=False):
    """
    Extracts chromatin coverage from a bedgraph file for a specific genomic range.
    
    Args:
        region_start (int): Start position of the genomic range.
        region_end (int): End position of the genomic range.
        region_chrom (str): Chromosome name.
        base_dir (str): Directory containing BEDGraph files.
        reverse_strand (bool): If True, reverses the coverage values.

    Returns:
        list: Averaged coverage values for the specified range.
    """

    rep_file_prefix = {
        "rep1": "W82_v4_0505",
        "rep2": "W82_v4_0506"
    }
    rep_coverages = []

    for rep in ["rep1", "rep2"]:
        prefix = rep_file_prefix[rep]
        filename = (
            f"Wang et al. 2021 -The Plant Cell- {prefix} W82 Leaf  ATAC-seq {rep} PRJNA657728 "
            f"Wang et al. 2021 -The Plant Cell--{region_chrom}-{region_start}..{region_end}.bedgraph"
        )
        bedgraph_file_path = os.path.join(base_dir, filename)

        if not os.path.exists(bedgraph_file_path):
            print(f"File not found: {bedgraph_file_path}")
            exit()

        with open(bedgraph_file_path, 'r') as file:
            bedgraph_data = file.readlines()[1:]  # Skip header

        length = region_end - region_start
        coverage = [0.0] * length

        for line in bedgraph_data:
            chrom, line_start, line_end, value = line.strip().split()
            line_start, line_end = int(line_start), int(line_end)
            value = float(value)

            # Skip non-overlapping or wrong chromosome
            if chrom != region_chrom or line_end <= region_start or line_start >= region_end:
                continue

            overlap_start = max(line_start, region_start)
            overlap_end = min(line_end, region_end)

            for i in range(overlap_start, overlap_end):
                coverage[i - region_start] = value

        if reverse_strand:
            coverage = coverage[::-1]

        rep_coverages.append(coverage)

    if not rep_coverages:
        return [0.0] * (region_end - region_start)

    # Average across replicates
    average_coverage = [
        sum(values) / len(values) for values in zip(*rep_coverages)
    ]

    return average_coverage


if __name__ == "__main__":
    # Define region
    region_start = 31782172
    region_end = 31783672
    region_chrom = "Gm13"
    reverse_strand = True 
    
    print(extract_chromatin_coverage(region_start, region_end, region_chrom, '../input_data/ATAC_seq_data', reverse_strand))