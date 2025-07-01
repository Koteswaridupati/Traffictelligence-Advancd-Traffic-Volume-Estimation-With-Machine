import pandas as pd

# Path to your dataset
dataset_path = 'data/raw/traffic_data.csv'

# Load the dataset into a DataFrame
df = pd.read_csv(dataset_path)

# Display the first 5 rows of the dataset
print("Dataset Preview:")
print(df.head())

# Basic inf
# Convert timestamp to datetime format
df['timestamp'] = pd.to_datetime(df['timestamp'])

# Check again
print(df.dtypes)
