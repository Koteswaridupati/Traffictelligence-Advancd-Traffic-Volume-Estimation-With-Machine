# Basic statistics
print("Basic Statistical Summary:")
print(df.describe())

# Check for missing values
print("\nMissing Values:")
print(df.isnull().sum())

# Unique values per column
print("\nUnique values in each column:")
print(df.nunique())
import matplotlib.pyplot as plt

# Plot traffic volume over time
plt.figure(figsize=(14, 5))
plt.plot(df['timestamp'], df['traffic_volume'], color='blue', linewidth=1)
plt.title('Traffic Volume Over Time')
plt.xlabel('Time')
plt.ylabel('Traffic Volume')
plt.grid(True)
plt.tight_layout()
plt.show()
# Extract hour and day of week
df['hour'] = df['timestamp'].dt.hour
df['day_of_week'] = df['timestamp'].dt.day_name()
import seaborn as sns

# Select numerical columns
corr = df[['traffic_volume', 'hour']].corr()

# Plot heatmap
plt.figure(figsize=(5, 4))
sns.heatmap(corr, annot=True, cmap='coolwarm', fmt=".2f")
plt.title('Correlation Matrix')
plt.tight_layout()
plt.show()

# Average traffic by hour
hourly_avg = df.groupby('hour')['traffic_volume'].mean()

plt.figure(figsize=(10, 5))# Average traffic by weather
weather_avg = df.groupby('weather')['traffic_volume'].mean().sort_values()

plt.figure(figsize=(10, 5))
weather_avg.plot(kind='bar', color='skyblue')
plt.title('Average Traffic Volume by Weather Condition')
plt.xlabel('Weather')
plt.ylabel('Average Traffic Volume')
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()

hourly_avg.plot(kind='bar', color='green')
plt.title('Average Traffic Volume by Hour of Day')
plt.xlabel('Hour')
plt.ylabel('Average Traffic Volume')
plt.grid(axis='y')
plt.tight_layout()
plt.show()
