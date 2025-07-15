import pandas as pd
import torch
from torch import nn
from torch.utils.data import Dataset, DataLoader
from transformers import AutoTokenizer, AutoModel
from tqdm import tqdm
import argparse
from scipy.stats import pearsonr
from sklearn.metrics import r2_score

# === Config ===
# Argument parser
print(">> Script started. Loading config...", flush=True)
parser = argparse.ArgumentParser(description="Train AgroNT regression model.")
parser.add_argument("--test_run", action="store_true", help="Run in fast test mode.")
args = parser.parse_args()
if args.test_run:
    print(">> Running in test mode (subset + faster config).", flush=True)
else:
    print(">> Running in full mode.", flush=True)



MODEL_NAME = "/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/filtering_out_low/soy_1500up_0down_42_log2plus1/lr_3e-8_r_32_alpha_32_dropout_0.05/checkpoint-5350/"
CSV_PATH = "/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/filtering_out_low/soy_1500up_0down_42_log2plus1/train.csv"
VALIDATE_CSV_PATH = "/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/filtering_out_low/soy_1500up_0down_42_log2plus1/dev.csv"
EPOCHS = 1 if args.test_run else 5
BATCH_SIZE = 32 if args.test_run else 8
SUBSET_SIZE = 1000 if args.test_run else None
LR = 1e-4
MAX_LEN = 1024  # AgroNT max token length
DEVICE = "cuda" if torch.cuda.is_available() else "cpu"

# === Dataset ===
class AgroNTDataset(Dataset):
    def __init__(self, csv_path, tokenizer, max_len, subset=None):
        df = pd.read_csv(csv_path)
        if subset is not None:
            df = df.sample(n=subset, random_state=42)
        self.labels = torch.tensor(df["label"].values, dtype=torch.float32)
        self.inputs = tokenizer(
            df["sequence"].tolist(),
            padding="max_length",
            truncation=True,
            max_length=max_len,
            return_tensors="pt"
        )

    def __len__(self):
        return len(self.labels)

    def __getitem__(self, idx):
        return {
            "input_ids": self.inputs["input_ids"][idx],
            "attention_mask": self.inputs["attention_mask"][idx],
            "label": self.labels[idx]
        }


# === Model ===
class AgroNTRegressor(nn.Module):
    def __init__(self, model_name):
        super().__init__()
        self.backbone = AutoModel.from_pretrained(model_name, output_hidden_states=True)
        self.reg_head = nn.Linear(self.backbone.config.hidden_size, 1)

    def forward(self, input_ids, attention_mask):
        outputs = self.backbone(input_ids=input_ids, attention_mask=attention_mask)
        cls_embedding = outputs.hidden_states[-1][:, 0, :]  # CLS token
        return self.reg_head(cls_embedding).squeeze(-1)

# === Load ===
tokenizer = AutoTokenizer.from_pretrained(MODEL_NAME)
dataset = AgroNTDataset(CSV_PATH, tokenizer, MAX_LEN, subset=SUBSET_SIZE)
dataloader = DataLoader(dataset, batch_size=BATCH_SIZE, shuffle=True)
# Load validation dataset
val_dataset = AgroNTDataset(VALIDATE_CSV_PATH, tokenizer, MAX_LEN)
val_dataloader = DataLoader(val_dataset, batch_size=BATCH_SIZE)


model = AgroNTRegressor(MODEL_NAME).to(DEVICE)
optimizer = torch.optim.AdamW(model.parameters(), lr=LR)
loss_fn = nn.MSELoss()

# === Training Loop ===
loss_history = []
print(">> Starting training...", flush=True)
model.train()
for epoch in range(EPOCHS):
    print(f"Epoch {epoch+1}/{EPOCHS}", flush=True)
    total_loss = 0.0
    for batch in tqdm(dataloader, desc=f"Epoch {epoch+1}"):

        input_ids = batch["input_ids"].to(DEVICE)
        attention_mask = batch["attention_mask"].to(DEVICE)
        labels = batch["label"].to(DEVICE)

        preds = model(input_ids=input_ids, attention_mask=attention_mask)
        loss = loss_fn(preds, labels)

        optimizer.zero_grad()
        loss.backward()
        optimizer.step()
        total_loss += loss.item()

    epoch_loss = total_loss / len(dataloader)
    loss_history.append({"epoch": epoch + 1, "loss": epoch_loss})
    print(f"Epoch {epoch+1} Loss: {epoch_loss:.4f}")

loss_df = pd.DataFrame(loss_history)
loss_df.to_csv("training_loss_tiny_agro.csv", index=False)
# === Save model ===
torch.save(model.state_dict(), "agroNT_regressor.pt")
tokenizer.save_pretrained("tokenizer/")

# === Evaluation ===
def evaluate(model, dataloader):
    model.eval()
    preds, true = [], []
    with torch.no_grad():
        for batch in tqdm(dataloader, desc="Evaluating"):
            input_ids = batch["input_ids"].to(DEVICE)
            attention_mask = batch["attention_mask"].to(DEVICE)
            labels = batch["label"].to(DEVICE)

            outputs = model(input_ids, attention_mask)
            preds.extend(outputs.cpu().numpy())
            true.extend(labels.cpu().numpy())

    return pd.DataFrame({"true": true, "pred": preds})

# 
eval_df = evaluate(model, val_dataloader)
eval_df.to_csv("evaluation_preds_on_valid.csv", index=False)


pearson, _ = pearsonr(eval_df["true"], eval_df["pred"])
r2 = r2_score(eval_df["true"], eval_df["pred"])
print(f">> Pearson r: {pearson:.3f}, R2: {r2:.3f}")
