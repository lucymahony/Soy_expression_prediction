### The script plots "loss": 24050.206, "eval_loss": 14667.46875,"eval_mse": 14667.46875, by epoch

import os
import json
import pandas as pd 
import matplotlib.pyplot as plt

def parse_json_file(file_path):
    # Check file exists
    if os.path.isfile(file_path):
        with open(file_path) as file:
            data = json.load(file)
            for key in data:
                if key == "log_history":
                    log_history = data[key]
                    return log_history
    else: print('file doesnt exist')


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



def plot_results(df, title, output_path):
    # Rename the columns 

    names = {'epoch' : 'Epochs',
            'loss' : 'Training Loss',
            'eval_loss' : 'Validation Loss',
            'eval_mse' : 'Validation MSE'}

    df.rename(columns=names, inplace=True)

    fig, axs = plt.subplots(2, 2)

    axs[0, 0].plot(df['Epochs'], df['Training Loss'])
    axs[0, 0].set_title('Training Loss')
    axs[0, 1].plot(df['Epochs'], df['Validation Loss'], 'tab:orange')
    axs[0, 1].set_title('Validation Loss')
    axs[1, 0].plot(df['Epochs'], df['Validation MSE'], 'tab:green')
    axs[1, 0].set_title('Validation MSE')

    for ax in axs.flat:
        ax.set(xlabel='Epochs', ylabel='')
    # Neaten by removing the labels from the x axis of the two top plots   
    axs[0, 0].set_xticks([])
    axs[0, 0].set(xlabel='')
    axs[0, 1].set_xticks([])
    axs[0, 1].set(xlabel='')
    fig.suptitle(title)
    plt.savefig(output_path, dpi=900)


def make_plot(json_file_path, output_path, list_metrics, title):
    log_history = parse_json_file(json_file_path)
    results = collect_key_data(log_history, list_metrics)
    df = create_df(results)
    plot_results(df, title, output_path)


if __name__ == "__main__":
    json_file_path = '/home/u10093927/workspace/dagw/Soybean/tmp/soy_1500up_0down_42/checkpoint-2500/trainer_state.json'
    output_path = '/home/u10093927/workspace/dagw/Soybean/tmp/soy_1500up_0down_42/'
    list_metrics = ['epoch', 'loss','eval_loss', 'eval_mse']
    title = 'Tiny soy'
    make_plot(json_file_path, output_path, list_metrics, title)