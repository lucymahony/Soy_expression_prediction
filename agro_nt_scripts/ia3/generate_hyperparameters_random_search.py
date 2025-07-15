import random
import pandas as pd
import sys 

def generate_hyperparameter_combinations(num_trails, output_csv_file_path):
    module_strategies = {
        'minimal' : {
            'target_modules': 'esm.encoder.layer.38.attention.self.key/esm.encoder.layer.38.attention.self.value/esm.encoder.layer.39.attention.self.key/esm.encoder.layer.39.attention.self.value',
            'feedforward_modules':''},
        'balanced' : {
            'target_modules':'esm.encoder.layer.38.attention.self.key/esm.encoder.layer.38.attention.self.value/esm.encoder.layer.39.attention.self.key/esm.encoder.layer.39.attention.self.value/esm.encoder.layer.38.output.dense/esm.encoder.layer.39.output.dense',
            'feedforward_modules': 'esm.encoder.layer.38.output.dense/esm.encoder.layer.39.output.dense'},
        'aggressive' : {
            'target_modules':'esm.encoder.layer.37.attention.self.key/esm.encoder.layer.37.attention.self.value/esm.encoder.layer.38.attention.self.key/esm.encoder.layer.38.attention.self.value/esm.encoder.layer.39.attention.self.key/esm.encoder.layer.39.attention.self.value/esm.encoder.layer.37.intermediate.dense/esm.encoder.layer.37.output.dense/esm.encoder.layer.38.intermediate.dense/esm.encoder.layer.38.output.dense/esm.encoder.layer.39.intermediate.dense/esm.encoder.layer.39.output.dense',
            'feedforward_modules': 'esm.encoder.layer.37.output.dense/esm.encoder.layer.38.output.dense/esm.encoder.layer.39.output.dense'}
    }

    # Generate random hyperparameter configurations
    hyperparameter_space = {
    "learning_rate": [3e-2, 3e-4, 3e-6],
    "weight_decay": [0.001, 0.01, 0.05],
    "batch_size": [4, 8, 16],
    "gradient_accumulation_steps": [2, 4, 8],
    "warmup_steps": [0, 5]
    }
    configs = []
    for trial in range(num_trails):
        module_strategy = random.choice(list(module_strategies.keys()))
        config = {
            "trial": trial,
            "learning_rate": random.choice(hyperparameter_space["learning_rate"]),
            "weight_decay": random.choice(hyperparameter_space["weight_decay"]),
            "batch_size": random.choice(hyperparameter_space["batch_size"]),
            "gradient_accumulation_steps": random.choice(hyperparameter_space["gradient_accumulation_steps"]),
            "warmup_steps": random.choice(hyperparameter_space["warmup_steps"]),
            # Pick target and feed forward from module_strategies so that they are always in concert
            "target_modules": module_strategies[module_strategy]["target_modules"],
            "feedforward_modules": module_strategies[module_strategy]["feedforward_modules"]
        }
        configs.append(config)
    df = pd.DataFrame(configs)
    df.to_csv(output_csv_file_path, index=False)

    print(f"Generated {num_trails} hyperparameter configurations and saved to {output_csv_file_path}")

if __name__ == "__main__":
    # parse arguments
    number_trails = int(sys.argv[1])  # e.g. 50
    output_csv_file_path = str(sys.argv[2]) # e.g. # /ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/hyperparameter_configs.csv
    seed = 0
    random.seed(seed)

    generate_hyperparameter_combinations(number_trails, output_csv_file_path)
