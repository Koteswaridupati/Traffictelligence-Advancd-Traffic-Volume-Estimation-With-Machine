# Check for missing values in each column
print("Missing Values Per Column:")
print(df.isnull().sum())
df = df.dropna()
print("Shape after dropping missing rows:", df.shape)
# Fill missing numerical values with the median
df['traffic_volume'] = df['traffic_volume'].fillna(df['traffic_volume'].median())
# Fill missing categorical values with the mode (most frequent value)
df['weather'] = df['weather'].fillna(df['weather'].mode()[0])
# Fill numerical columns
num_cols = df.select_dtypes(include=['float64', 'int64']).columns
for col in num_cols:
    df[col] = df[col].fillna(df[col].median())

# Fill categorical columns
cat_cols = df.select_dtypes(include=['object']).columns
for col in cat_cols:
    df[col] = df[col].fillna(df[col].mode()[0])
# Recheck if all missing values are handled
print("Remaining Missing Values:")
print(df.isnull().sum())
df.to_csv("data/processed/traffic_data_cleaned.csv", index=False)
print("Cleaned data saved.")
