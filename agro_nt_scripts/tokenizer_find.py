from transformers import AutoTokenizer

# Define the correct paths
cache_dir = "/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/cache"
model_path = "/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/soy_1500up_0down_42_log2/3e-4/checkpoint-3900"

# Load the tokenizer from the model directory
tokenizer = AutoTokenizer.from_pretrained(model_path, cache_dir=cache_dir)

# Check special tokens
print("Special Tokens Map:")
print(tokenizer.special_tokens_map)

print("\nAll Special Tokens:")
print(tokenizer.all_special_tokens)

# Check if <cis> is a special token
if "<cis>" in tokenizer.all_special_tokens:
    print("\n<cis> is a special token!")
else:
    print("\n<cis> is not a special token.")
