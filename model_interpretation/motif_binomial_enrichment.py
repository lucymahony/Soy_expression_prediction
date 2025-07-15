import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import binomtest
from collections import Counter
import tqdm

def find_high_attention_regions(sequence, attention, threshold):
    """Extract contiguous high-attention regions above a given threshold."""
    regions = []
    current = []
    for base, att in zip(sequence, attention):
        if att >= threshold:
            current.append(base)
        elif current:
            regions.append(''.join(current))
            current = []
    if current:
        regions.append(''.join(current))
    return regions


def get_kmers(seq, k):
    """Generate all k-mers from a sequence."""
    return [seq[i:i + k] for i in range(len(seq) - k + 1)]


def count_enriched_motifs_at_thresholds(df, k=6, thresholds=range(1, 21), cutoff=0.05):
    results = []

    for tp in tqdm.tqdm(thresholds):
        threshold = np.percentile(np.concatenate(df['attention'].values), 100 - tp)

        high_regions = []
        background_kmers = []

        for _, row in df.iterrows():
            seq = row['sequence']
            att = row['attention']
            regions = find_high_attention_regions(seq, att, threshold)
            high_regions.extend(regions)
            background_kmers.extend(get_kmers(seq, k))

        high_kmers = []
        for region in high_regions:
            high_kmers.extend(get_kmers(region, k))

        high_counts = Counter(high_kmers)
        background_counts = Counter(background_kmers)

        total_high = sum(high_counts.values())
        total_bg = sum(background_counts.values())

        motifs = []
        for motif, count in high_counts.items():
            bg_prob = background_counts.get(motif, 0) / total_bg if total_bg > 0 else 0
            pval = binomtest(count, total_high, bg_prob, alternative='greater').pvalue
            motifs.append({'motif': motif, 'count': count, 'pval': pval})

        df_motifs = pd.DataFrame(motifs)
        if df_motifs.empty:
            results.append((tp, 0))
            continue

        num_enriched = (df_motifs['pval'] < cutoff).sum()
        # Save the results for this threshold
        print(f'Threshold {tp}: {num_enriched} enriched motifs (cuttoff < {cutoff})')
        df_motifs.to_csv(f'motifs/motifs_at_threshold_{tp}.csv', index=False)

        results.append((tp, num_enriched))

    return results


def plot_enriched_motifs_vs_threshold(results, output_file=None):
    thresholds, enriched_counts = zip(*results)
    plt.figure(figsize=(7, 5))
    plt.plot(thresholds, enriched_counts, marker='o')
    plt.xlabel('Top % Attention Threshold')
    plt.ylabel('Number of Enriched Motifs (FDR < 0.05)')
    plt.title('Motif Enrichment vs. Attention Threshold')
    plt.grid(True)
    plt.tight_layout()
    if output_file:
        plt.savefig(output_file)
    plt.show()


def motifs_to_fasta(motifs, output_file):
    """Convert motifs to FASTA format and save to file."""
    with open(output_file, 'w') as f:
        for i, motif in enumerate(set(motifs)):
            f.write(f'>motif_{i}\n{motif}\n')


def read_in_attention_data(file_path):
    """Read attention data from a CSV file."""
    df = pd.read_csv(file_path, header=None, skiprows=1)
    df = df.rename(columns={0: 'sequence'})
    attention_cols = df.columns[1:]
    df['attention'] = df.apply(lambda row: [float(row[col]) for col in attention_cols], axis=1)
    
    # Clip attention length to match sequence length
    for i, row in df.iterrows():
        if len(row['sequence']) != len(row['attention']):
            row['attention'] = row['attention'][:len(row['sequence'])]
    
    return df

if __name__ == '__main__':
    df = read_in_attention_data('glycine_max_test_attention_lr_3e-5_checkpoint-18856_optim.csv')
    
    log_thresholds = np.logspace(np.log10(0.1), np.log10(20), num=10)
    results = count_enriched_motifs_at_thresholds(df, k=6, thresholds=log_thresholds, cutoff=0.05)
    plot_enriched_motifs_vs_threshold(results, output_file='motif_enrichment_curve.pdf')
    # save 0.1 motifs to fasta
    tp = 0.1
    motifs = []
    df_motifs = pd.read_csv(f'motifs/motifs_at_threshold_{tp}.csv')
    # filter for p-value < 0.05
    df_motifs = df_motifs[df_motifs['pval'] < 0.05]
    motifs.extend(df_motifs['motif'].tolist())
    motifs_to_fasta(motifs, f'motifs/enriched_motifs_{tp}.fa')