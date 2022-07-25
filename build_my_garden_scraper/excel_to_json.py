import pandas as pd

csv_file = pd.read_csv('plant_table_new.csv')
csv_file.to_json('plant_table_new.json')