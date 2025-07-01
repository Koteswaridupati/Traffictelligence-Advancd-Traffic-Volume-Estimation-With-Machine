# main.py

import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error, r2_score
from sklearn.preprocessing import LabelEncoder, StandardScaler
import joblib
import os

# === Step 1: Load the dataset ===
print("Loading dataset...")
df = pd.read_csv("data/processed/traffic_data_cleaned.csv")

# === Step 2: Feature Engineering ===
print("Extracting features...")
df['timestamp'] = pd.to_datetime(df['timestamp'])
df['hour'] = df['timestamp'].dt.hour
df['day_of_week'] = df['timestamp'].dt.day_name()

# Encode categorical features
print("Encoding categorical features...")
le_weather = LabelEncoder()
le_day = LabelEncoder()
df['weather_encoded'] = le_weather.fit_transform(df['weather'])
df['day_encoded'] = le_day.fit_transform(df['day_of_week'])

# Save encoders for web app use later
joblib.dump(le_weather, 'models/weather_encoder.pkl')
joblib.dump(le_day, 'models/day_encoder.pkl')

# === Step 3: Select Features and Target ===
print("Selecting features and target...")
X = df[['hour', 'weather_encoded', 'day_encoded']]
y = df['traffic_volume']

# === Step 4: Feature Scaling ===
print("Scaling features...")
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

# Save scaler
joblib.dump(scaler, 'models/feature_scaler.pkl')
TrafficTelligence/
├── data/
│   └── processed/
│       └── traffic_data_cleaned.csv
├── models/
│   ├── traffic_model.pkl
│   ├── weather_encoder.pkl
│   ├── day_encoder.pkl
│   └── feature_scaler.pkl
└── main.py

# === Step 5: Split Dataset ===
print("Splitting data...")
X_train, X_test, y_train, y_test = train_test_split(X_scaled, y, test_size=0.2, random_state=42)

# === Step 6: Train Model ===
print("Training model...")
model = RandomForestRegressor(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

# === Step 7: Evaluate Model ===
print("Evaluating model...")
y_pred = model.predict(X_test)
mse = mean_squared_error(y_test, y_pred)
r2 = r2_score(y_test, y_pred)

print(f"\nModel Performance:")
print(f"Mean Squared Error: {mse:.2f}")
print(f"R² Score: {r2:.2f}")

# === Step 8: Save the Model ===
os.makedirs("models", exist_ok=True)
joblib.dump(model, "models/traffic_model.pkl")
print("\n✅ Model and preprocessing files saved to /models/")
