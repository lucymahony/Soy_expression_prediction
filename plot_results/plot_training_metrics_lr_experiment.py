### The script plots "loss": 24050.206, "eval_loss": 14667.46875,"eval_mse": 14667.46875, by epoch

import os
import json
import pandas as pd 
import matplotlib.pyplot as plt
import sys
from matplotlib.ticker import MaxNLocator, FuncFormatter
import numpy as np

def parse_json_file(file_path):
    # Check file exists
    if os.path.isfile(file_path):
        with open(file_path) as file:
            data = json.load(file)
            for key in data:
                if key == "log_history":
                    log_history = data[key]
                    print(f'The log history is {log_history}')
                    return log_history
    else: print(f'file {file_path} doesnt exist')


def collect_key_data(list_of_logging_dicts, list_metrics):
    """
    Input list_of_logging_dicts - 
    list_metrics - list of the metrics you want to plot e.g. ['epoch', 'loss','eval_loss', 'eval_f1', 'eval_matthews_correlation']
    """

    # For each metric collect all instances of its values 
    results = {}

    for metric in list_metrics:
        values = []
        for dict in list_of_logging_dicts:
            for k, v in dict.items():
                if k == metric:
                    values.append(dict[k])
        results[metric] = values
    return results 


def create_df(dictionary_of_results):
    # Remove epoch duplication as it will have been added twice due to the lay out of the trainer_state.json file 
    epoch = dictionary_of_results['epoch']
    epoch = epoch[0::2]
    dictionary_of_results['epoch'] = epoch

    print(dictionary_of_results)
    # Check all values have the same length 
    length = len(dictionary_of_results['epoch'])
    print(epoch, length)
    for k, v in dictionary_of_results.items():
        assert len(v) == length
    df = pd.DataFrame.from_dict(dictionary_of_results)
    print(f'The columns are {df.columns}')
    return df 



def plot_results_one_experiment(df, title, output_path):
    # Rename the columns 

    names = {'epoch' : 'Epochs',
            'loss' : 'Training Loss',
            'eval_mae' : 'Validation MAE',
            'eval_mse' : 'Validation MSE', 
            'eval_rmse': 'Validation RMSE'}

    df.rename(columns=names, inplace=True)

    fig, axs = plt.subplots(2, 2)

    axs[0, 0].plot(df['Epochs'], df['Training Loss'])
    axs[0, 0].set_title('Training Loss - MAE')
    axs[0, 1].plot(df['Epochs'], df['Validation MAE'], 'tab:orange')
    axs[0, 1].set_title('Validation Loss - MAE')
    axs[1, 0].plot(df['Epochs'], df['Validation MSE'], 'tab:green')
    axs[1, 0].set_title('Validation MSE')
    axs[1, 1].plot(df['Epochs'], df['Validation RMSE'], 'tab:green')
    axs[1, 1].set_title('Validation RMSE')

    for ax in axs.flat:
        ax.set(xlabel='Epochs', ylabel='')
    # Neaten by removing the labels from the x axis of the two top plots   
    axs[0, 0].set_xticks([])
    axs[0, 0].set(xlabel='')
    axs[0, 1].set_xticks([])
    axs[0, 1].set(xlabel='')
    fig.suptitle(title)
    plt.tight_layout() 
    print(f'The plot is going to be saved as {output_path}')
    plt.savefig(output_path, dpi=900)



def plot_results_multiple_experiments(dataframes, output_path, data_names, title, log_y_axis=False):
    col_names = {
        'epoch': 'Epochs',
        'loss': 'Training Loss',
        'eval_mae': 'Validation MAE',
        'eval_mse': 'Validation MSE',
        'eval_r2': 'Validation R-squared'
    }
    for df in dataframes:
        df.rename(columns=col_names, inplace=True)
    colors = ['#ff8389', '#ff7eb6', '#be95ff', '#78a9ff', '#33b1ff', '#08bdba', '#42be65', '#a2a9b0', '#3ddbd9'] # Light
    dashes = [(5, 1), (1, 1), (3, 1, 1, 1), (3, 1, 1, 1, 1, 1), (3, 5, 1, 5, 1, 5), (3, 5, 1, 5), (1, 1), (3, 1, 1, 1), (3, 1, 1, 1, 1, 1), (3, 5, 1, 5, 1, 5)]
    print(f"Colour pallet and dashes contain {len(colors)} and {len(dashes)}")
    fig, axs = plt.subplots(2, 2, figsize=(8, 8))
    # Determine global y-limits and round to nearest integers
    ylims = {
        'Loss': (int(np.floor(df['Training Loss'].min())), int(np.ceil(df['Training Loss'].max()))),
        'Validation MAE': (int(np.floor(df['Validation MAE'].min())), int(np.ceil(df['Validation MAE'].max()))),
        'Validation R-squared': (int(np.floor(df['Validation R-squared'].min())), int(np.ceil(df['Validation R-squared'].max())))
    }
    print(f'The y lims are {ylims}')

    for i, df in enumerate(dataframes):
        name = data_names[i]
        axs[0, 0].plot(df['Epochs'], df['Training Loss'], dashes=dashes[i], label=name, color=colors[i])
        axs[0, 0].set_title('Training Loss - MSE')
        axs[0, 0].set_ylim(ylims['Loss'])

        axs[0, 1].plot(df['Epochs'], df['Validation MSE'], dashes=dashes[i], label=name, color=colors[i])
        axs[0, 1].set_title('Validation Loss - MSE')
        axs[0, 1].set_ylim(ylims['Loss'])

        axs[1, 0].plot(df['Epochs'], df['Validation MAE'], dashes=dashes[i], label=name, color=colors[i])
        axs[1, 0].set_title('Validation MAE')
        axs[1, 0].set_ylim(ylims['Validation MAE'])

        axs[1, 1].plot(df['Epochs'], df['Validation R-squared'], dashes=dashes[i], label=name, color=colors[i])
        axs[1, 1].set_title('Validation R-squared')
        axs[1, 1].set_ylim(ylims['Validation R-squared'])

        if log_y_axis:
            for ax in axs.flat:
                ax.set_yscale('log')
        else:
            for ax in axs.flat:
                ax.yaxis.set_major_formatter(FuncFormatter(lambda x, _: f'{x:.2f}'))
                ax.yaxis.set_major_locator(MaxNLocator(5, prune='both'))
    axs[0, 0].set(xlabel='')
    axs[0, 1].set(xlabel='')
    fig.tight_layout()
    fig.subplots_adjust(bottom=0.1)
    fig.legend(labels=data_names, loc='lower center', ncol=len(data_names), fontsize="11")
    fig.suptitle(title)
    plt.savefig(output_path, dpi=900)




def make_plot_one_experiment(json_file_path, output_path, list_metrics, title):
    log_history = parse_json_file(json_file_path)
    results = collect_key_data(log_history, list_metrics)
    df = create_df(results)
    plot_results_one_experiment(df, title, output_path)


def make_plot_multiple_experiments(list_of_json_file_paths, output_path, list_metrics, lrs, title, log_y_scale=False):
    """
    lrs = list of learning rate e.g. ['3e-4', '3e-5', '3e-6', '3e-7']
    """
    dfs =[]
    for json in list_of_json_file_paths:
        log_history = parse_json_file(json)
        results = collect_key_data(log_history, list_metrics)
        df = create_df(results)
        dfs.append(df)
    plot_results_multiple_experiments(dfs, output_path, lrs, title, log_y_scale)
    
        
if __name__ == "__main__":
    # Plotting one experiment example :
    #json_file_path = '../intermediate_data/soy_1500up_0down_42/3e-5/checkpoint-4500/trainer_state.json'
    #output_path = '../intermediate_data/soy_1500up_0down_42/3e-5/3e-5_soy_1500up_0down_42.png'
    #title = ''
    #list_metrics = ['epoch', 'loss', 'eval_mae', 'eval_mse', 'eval_rmse']
    #make_plot_one_experiment(json_file_path, output_path, list_metrics, title)

    # Plotting multiple experiments:
    location_intermediate_data = str(sys.argv[1])
    checkpoint_file_name= str(sys.argv[2])
    plot_output_path = str(sys.argv[3])
    lrs = str(sys.argv[4]) # This passes it in as a str 
    lrs = map(str, lrs.split(',')) # This splits the string into a list of strings 
    lrs = list(lrs) # This converts the list of strings into a list of strings
    print(f'The learning rates are {lrs}')
    print(f'The type of lrs is {type(lrs)}')
    json_file_paths = [f'{location_intermediate_data}/{lr}/{checkpoint_file_name}/trainer_state.json' for lr in lrs]
    # Note eval_loss = eval_mse
    list_metrics = ['epoch', 'loss', 'eval_mae', 'eval_mse', 'eval_r2']
    title = 'Tuning Learning Rate'
    make_plot_multiple_experiments(json_file_paths, plot_output_path, list_metrics, lrs, title, log_y_scale=False)
    print(f'The plot has been saved to {plot_output_path}')
    