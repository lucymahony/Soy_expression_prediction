import os
import json
import pandas as pd
import matplotlib.pyplot as plt
import sys
from matplotlib.ticker import MaxNLocator, FuncFormatter
import numpy as np
from itertools import product  # To handle combinations of hyperparameters

def parse_json_file(file_path):
    # Check file exists
    if os.path.isfile(file_path):
        with open(file_path) as file:
            data = json.load(file)
            for key in data:
                if key == "log_history":
                    log_history = data[key]
                    return log_history
    else: 
        print(f'File {file_path} doesn\'t exist')

def collect_key_data(list_of_logging_dicts, list_metrics):
    """
    Input list_of_logging_dicts - 
    list_metrics - list of the metrics you want to plot e.g. ['epoch', 'loss','eval_loss', 'eval_f1', 'eval_matthews_correlation']
    """
    # For each metric collect all instances of its values 
    results = {}
    for metric in list_metrics:
        values = []
        for log_dict in list_of_logging_dicts:
            if metric in log_dict:
                values.append(log_dict[metric])
        results[metric] = values
    return results 

def create_df(dictionary_of_results):
    print(f'The dictionary of results key {dictionary_of_results.keys()}')
    print(f'The dictionary of results values {dictionary_of_results.values()}')
    print(f'epoch = {dictionary_of_results["epoch"]}, length of epoch = {len(dictionary_of_results["epoch"])}')
    print(f'loss = {dictionary_of_results["loss"]}, length of loss = {len(dictionary_of_results["loss"])}')
    # Remove epoch duplication as it will have been added twice due to the layout of the trainer_state.json file 
    #if 'epoch' in dictionary_of_results:
    #    epoch = dictionary_of_results['epoch']
    #    dictionary_of_results['epoch'] = epoch[0::2]
    #
    for k, v in dictionary_of_results.items():
        print('lengths!!!')
        print(len(v))
        print(len(dictionary_of_results['epoch']))
        assert len(v) == len(dictionary_of_results['epoch'])
    df = pd.DataFrame.from_dict(dictionary_of_results)
    return df 

def plot_results_multiple_experiments(dataframes, output_path, experiment_names, title, log_y_axis=False):
    col_names = {
        'epoch': 'Epochs',
        'loss': 'Training Loss',
        'eval_mae': 'Validation MAE',
        'eval_mse': 'Validation MSE',
        'eval_r2': 'Validation R-squared'
    }
    for df in dataframes:
        df.rename(columns=col_names, inplace=True)
    
    # Print the lowest Validation MSE and the corresponding epoch for each experiment
    for i, df in enumerate(dataframes):
        min_mse = df['Validation MSE'].min()
        min_mse_epoch = df.loc[df['Validation MSE'].idxmin()]['Epochs']
        print(f'Experiment {experiment_names[i]}: Lowest Validation MSE = {min_mse} at epoch {min_mse_epoch}')


    fig, axs = plt.subplots(2, 2, figsize=(10, 10))
    for i, df in enumerate(dataframes):
        name = experiment_names[i]
        axs[0, 0].plot(df['Epochs'], df['Training Loss'], label=name)
        axs[0, 1].plot(df['Epochs'], df['Validation MSE'], label=name)
        axs[1, 0].plot(df['Epochs'], df['Validation MAE'], label=name)
        axs[1, 1].plot(df['Epochs'], df['Validation R-squared'], label=name)

    axs[0, 0].set_title('Training Loss')
    axs[0, 1].set_title('Validation MSE')
    axs[1, 0].set_title('Validation MAE')
    axs[1, 1].set_title('Validation R-squared')

    for ax in axs.flat:
        ax.set_xlabel('Epochs')
        if log_y_axis:
            ax.set_yscale('log')

    # Rename the experiment names to be more readable in the legend
    # no_filtering = 'No Filtering', filtering_out_low = 'Filtering Out Low', filtering_out_high_and_low = 'Filtering Out High and Low', cv = 'Cross Validation'
    

    fig.legend(labels=experiment_names, loc='lower center', ncol=len(experiment_names), fontsize="11")
    fig.suptitle(title)
    plt.savefig(output_path, dpi=900)
    print(f'Plot saved to {output_path}')


def plot_just_loss(df, output_path, experiment_names, title, log_y_axis=False):
    col_names = {
        'epoch': 'Epochs',
        'loss': 'Training Loss'}
    df.rename(columns=col_names, inplace=True)

    fig, ax = plt.subplots(figsize=(10, 5))
    name = experiment_names[0]
    ax.plot(df['Epochs'], df['Training Loss'], label=name)
    ax.set_title('Training Loss')
    ax.set_xlabel('Epochs')
    if log_y_axis:
        ax.set_yscale('log')

    fig.legend(labels=experiment_names, loc='lower center', ncol=len(experiment_names), fontsize="11")
    fig.suptitle(title)
    plt.savefig(output_path, dpi=900)
    print(f'Plot saved to {output_path}')








def make_plot_multiple_experiments(location_intermediate_data, checkpoint_file_name, output_path, list_metrics, params, title, log_y_scale=False):
    """
    params = Dictionary containing parameter names and their values.
             E.g., {'lr': ['1e-4', '1e-5'], 'r': [16, 32], 'alpha': [0.05, 0.1], 'dropout': [0.1, 0.3]}
    """
    # Generate all combinations of hyperparameters
    param_names = list(params.keys())
    param_values = list(product(*params.values()))
    param_combinations = [dict(zip(param_names, values)) for values in param_values]

    dfs = []
    experiment_names = []

    for param_set in param_combinations:
        # Build the directory path based on the parameter combination
        param_str = '_'.join([f'{k}_{v}' for k, v in param_set.items()])
        json_file_path = os.path.join(location_intermediate_data, param_str, checkpoint_file_name, 'trainer_state.json')

        log_history = parse_json_file(json_file_path)
        if log_history:
            results = collect_key_data(log_history, list_metrics)
            df = create_df(results)
            dfs.append(df)
            experiment_names.append(param_str)

    plot_results_multiple_experiments(dfs, output_path, experiment_names, title, log_y_scale)


def make_plot_multiple_inputs(list_data_paths, list_data_names,  output_path, list_metrics, title, log_y_scale=False):
    """
    params = Dictionary containing parameter names and their values.
             E.g., {'lr': ['1e-4', '1e-5'], 'r': [16, 32], 'alpha': [0.05, 0.1], 'dropout': [0.1, 0.3]}
    """
    
    dfs = []
    for data_path in list_data_paths:
        # Build the directory path based on the parameter combination
        json_file_path = os.path.join(data_path, 'trainer_state.json')
        print(f'json_file_path is {json_file_path}')
        log_history = parse_json_file(json_file_path)
        if log_history:
            results = collect_key_data(log_history, list_metrics)
            df = create_df(results)
            dfs.append(df)
    plot_results_multiple_experiments(dfs, output_path, list_data_names, title, log_y_scale)


if __name__ == "__main__":
    location_intermediate_data = str(sys.argv[1])
    checkpoint_file_name = str(sys.argv[2])
    plot_output_path = str(sys.argv[3])

    # Accept hyperparameters as key-value pairs from command-line arguments
    hyperparams = json.loads(sys.argv[4])  # Pass as a JSON string for flexibility

    #list_metrics = ['epoch', 'loss', 'eval_mae', 'eval_mse', 'eval_r2']
    #title = 'Hyperparameter Tuning Results'
    #make_plot_multiple_experiments(location_intermediate_data, checkpoint_file_name, plot_output_path, list_metrics, hyperparams, title, log_y_scale=False)

    directory='/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/'
    #list_data_paths=('no_filtering/soy_1500up_0down_42_log2plus1/lr_3e-4_r_32_alpha_32_dropout_0.3',
    #'filtering_out_low/soy_1500up_0down_42_log2plus1/lr_3e-4_r_16_alpha_32_dropout_0.3/',
    #'filtering_out_high_and_low/soy_1500up_0down_42_log2plus1/lr_3e-4_r_32_alpha_32_dropout_0.3',
    #'cv/soy_1500up_0down_42_log2plus1/lr_3e-4_r_32_alpha_32_dropout_0.3')
    #checkpoint_file_names=('checkpoint-8550', 'checkpoint-5350', 'checkpoint-4250', 'checkpoint-1650')
    #list_data_names=('No filtering', 'Filtered low','Filtered low and high', 'Coef. of Variation')
    # Make list_data_paths which is directory + list_data_paths[i] + checkpoint_file_names[i] for i in range(len(list_data_paths))
    #list_data_paths = [os.path.join(directory, list_data_paths[i], checkpoint_file_names[i]) for i in range(len(list_data_paths))]
    list_metrics = ['epoch', 'loss']
    data_names=('IA3')
    data_paths = [os.path.join(directory, 'no_filtering/soy_1500up_0down_42_log2plus1/ia3_lr_3e-4/', 'checkpoint-8550')]    
    title=''
    plot_output_path='/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/IA3_metrics.png'
    log_history = parse_json_file('/ei/projects/c/c3109f4b-0db1-43ec-8cb5-df48d8ea89d0/scratch/repos/Soy_expression_prediction/intermediate_data/no_filtering/soy_1500up_0down_42_log2plus1/ia3_lr_3e-4/checkpoint-8550/trainer_state.json')
    results = collect_key_data(log_history, list_metrics)
    print('Creating dfs !!!!')
    df = create_df(results)
    print(df)
    plot_just_loss(df, plot_output_path, data_names, title, log_y_axis=False)
