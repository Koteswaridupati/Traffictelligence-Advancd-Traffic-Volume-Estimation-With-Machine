import matplotlib.pyplot as plt
import seaborn as sns
plt.figure(figsize=(14, 5))
plt.plot(df['timestamp'], df['traffic_volume'], color='navy', linewidth=1)
plt.title('Traffic Volume Over Time')
plt.xlabel('Time')
plt.ylabel('Traffic Volume')
plt.grid(True)
plt.tight_layout()
plt.show()
df['hour'] = df['timestamp'].dt.hour

hourly_avg = df.groupby('hour')['traffic_volume'].mean()

plt.figure(figsize=(10, 5))
sns.barplot(x=hourly_avg.index, y=hourly_avg.values, palette='viridis')
plt.title('Average Traffic Volume by Hour')
plt.xlabel('Hour of Day')
plt.ylabel('Average Traffic Volume')
plt.tight_layout()
plt.show()
df['day_of_week'] = df['timestamp'].dt.day_name()
weather_avg = df.groupby('weather')['traffic_volume'].mean().sort_values()

plt.figure(figsize=(10, 5))
sns.barplot(x=weather_avg.index, y=weather_avg.values, palette='coolwarm')
plt.title('Average Traffic Volume by Weather')
plt.xlabel('Weather')
plt.ylabel('Average Traffic Volume')
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()

day_avg = df.groupby('day_of_week')['traffic_volume'].mean()
# Optional: sort days
days_order = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
day_avg = day_avg.reindex(days_order)

plt.figure(figsize=(10, 5))
sns.barplot(x=day_avg.index, y=day_avg.values, palette='Set2')
plt.title('Average Traffic Volume by Day of Week')
plt.xlabel('Day')
plt.ylabel('Average Traffic Volume')
plt.tight_layout()
plt.show()
# Encode categorical if needed
df['weather_code'] = df['weather'].astype('category').cat.codes

# Create correlation matrix
corr = df[['traffic_volume', 'hour', 'weather_code']].corr()

plt.figure(figsize=(6, 4))
sns.heatmap(corr, annot=True, cmap='RdBu_r', fmt='.2f')
plt.title('Correlation Heatmap')
plt.tight_layout()
plt.show()
plt.figure(figsize=(8, 5))
sns.histplot(df['traffic_volume'], bins=30, kde=True, color='skyblue')
plt.title('Distribution of Traffic Volume')
plt.xlabel('Traffic Volume')
plt.ylabel('Frequency')
plt.tight_layout()
plt.show()
