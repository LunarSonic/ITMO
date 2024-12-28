import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from matplotlib.ticker import MultipleLocator
def create_box_and_whisker(csv_file):
    try:
        data = pd.read_csv(csv_file, sep=';', encoding='utf-8')
        #пробуем найти столбец с датой
        potential_data_column = data.select_dtypes(include=['object']).columns
        data_column = None
        for i in potential_data_column:
            try:
                data[i] = pd.to_datetime(data[i], dayfirst=True)
                data_column = i
                break
            except ValueError:
                continue
        if data_column is None:
            raise ValueError("Ошибка! Не удалось определить столбец с датой")
        #определяем столбцы с числовыми данными
        value_columns = data.select_dtypes(include=['int64', 'float64']).columns.tolist() #список, содержащий названия столбцов с числами
        if not value_columns:
            raise ValueError("Числовые столбцы не были найдены")
        #преобразуем данные в длинный формат, чтобы потом использовать их для seaborn
        new_data = pd.melt(data, id_vars=[data_column], value_vars=value_columns)
        plt.figure(figsize=(14, 7))
        sns.boxplot(data=new_data, x=new_data[data_column].dt.strftime('%d.%m.%Y'), y='value', hue='variable', palette='husl')
        plt.title('Ящик с усами', fontsize=15, x=0.5, y=1.09)
        plt.xlabel('')
        plt.ylabel('')
        plt.legend(loc='upper center', bbox_to_anchor=(0.5, 1.08), ncol=4, title=None)
        plt.ylim(100000, 120000)
        #устанавливаем разделитель для меток на оси Y
        plt.gca().yaxis.set_major_locator(MultipleLocator(2000))
        plt.grid(axis='y', linestyle='-', alpha=0.4)
        plt.tight_layout()
        plt.show()
    except Exception as error:
        print(f"Ошибка: {error}")

create_box_and_whisker('/Users/sofiaabdullaeva/Downloads/additional_task2.csv')
