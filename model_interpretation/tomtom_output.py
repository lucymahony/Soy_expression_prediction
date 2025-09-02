
import argparse, os
import numpy as np
import pandas as pd

def load_tomtom(path: str) -> pd.DataFrame:
    df = pd.read_csv(path, sep="\t", comment="#")
    if "Overlap" not in df.columns:
        df["Overlap"] = np.nan
    return df

def filter_hits(df: pd.DataFrame, q_thresh: float, min_length: int, require_overlap: bool, motif_name: str | None):
    df = df.copy()
    df["motif_length"] = df["Query_ID"].astype(str).str.len()
    df = df[df["motif_length"] >= min_length]
    if require_overlap:
        df = df[df["Overlap"] >= min_length]
    if motif_name:
        df = df[df["Target_ID"] == motif_name]
    sig = df[df["q-value"] < q_thresh]
    return df, sig

def summarize(sig: pd.DataFrame) -> dict:
    if sig.empty:
        return dict(total_sig_hits=0, unique_targets=0, unique_queries=0,
                    best_q=np.nan, best_p=np.nan, max_overlap=np.nan)
    return dict(
        total_sig_hits = int(len(sig)),
        unique_targets = int(sig["Target_ID"].nunique()),
        unique_queries = int(sig["Query_ID"].nunique()),
        best_q         = float(sig["q-value"].min()),
        best_p         = float(sig["p-value"].min()),
        max_overlap    = int(sig["Overlap"].max())
    )

def main():
    ap = argparse.ArgumentParser(description="Summarize Tomtom results and write CSVs.")
    ap.add_argument("--tomtom_output", required=True, help="Path to tomtom.tsv")
    ap.add_argument("--out_csv", required=True, help="Single-row run summary CSV")
    ap.add_argument("--out_targets_csv", required=True, help="Per-target summary CSV")
    ap.add_argument("--q_thresh", type=float, default=0.05)
    ap.add_argument("--min_length", type=int, default=12)
    ap.add_argument("--require_overlap", action="store_true")
    ap.add_argument("--motif_name", type=str, default=None)
    args = ap.parse_args()

    df = load_tomtom(args.tomtom_output)
    _, sig = filter_hits(df, args.q_thresh, args.min_length, args.require_overlap, args.motif_name)

    run_sum = summarize(sig)
    run_sum.update(dict(
        path=args.tomtom_output,
        q_thresh=args.q_thresh,
        min_length=args.min_length,
        require_overlap=bool(args.require_overlap),
        motif_name=args.motif_name if args.motif_name else "ALL"
    ))
    run_df = pd.DataFrame([run_sum])
    os.makedirs(os.path.dirname(args.out_csv) or ".", exist_ok=True)
    run_df.to_csv(args.out_csv, index=False)

    if sig.empty:
        tgt_df = pd.DataFrame(columns=["Target_ID","n_hits","n_unique_queries","best_q","best_p","max_overlap"])
    else:
        tgt_df = (sig.groupby("Target_ID")
                    .agg(n_hits=("Query_ID","size"),
                         n_unique_queries=("Query_ID","nunique"),
                         best_q=("q-value","min"),
                         best_p=("p-value","min"),
                         max_overlap=("Overlap","max"))
                    .sort_values(["n_unique_queries","best_q"], ascending=[False, True])
                    .reset_index())
    os.makedirs(os.path.dirname(args.out_targets_csv) or ".", exist_ok=True)
    tgt_df.to_csv(args.out_targets_csv, index=False)

    print(f"[tomtom_output] Wrote run summary → {args.out_csv}")
    print(f"[tomtom_output] Wrote per-target summary → {args.out_targets_csv}")

if __name__ == "__main__":
    main()
