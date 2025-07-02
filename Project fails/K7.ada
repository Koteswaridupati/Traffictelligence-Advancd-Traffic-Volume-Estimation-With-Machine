from sklearn.preprocessing import LabelEncoder

# Encode 'weather' and 'day_of_week' if they're still strings
le_weather = LabelEncoder()
le_day = LabelEncoder()

df['weather_encoded'] = le_weather.fit_transform(df['weather'])
df['day_of_week_encoded'] = le_day.fit_transform(df['day_of_week'])
# Define independent variables (features)
X = df[['hour', 'weather_encoded', 'day_of_week_encoded']]

# Define dependent variable (target)
y = df['traffic_volume']

print("Independent Variables (X):")
print(X.head())

print("\nDependent Variable (y):")
print(y.head())
from sklearn.preprocessing import StandardScaler

scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)
