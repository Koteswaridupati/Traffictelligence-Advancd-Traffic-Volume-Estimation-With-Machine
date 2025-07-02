import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler

df = pd.read_csv('traffic.csv', parse_dates=['datetime'])
df['hour'] = df['datetime'].dt.hour
df['day'] = df['datetime'].dt.weekday
df = pd.get_dummies(df, columns=['weather'], drop_first=True)

features = df.drop(['traffic_volume','datetime'], axis=1)
labels = df['traffic_volume']

X_train, X_test, y_train, y_test = train_test_split(features, labels, test_size=0.2, random_state=42)
scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_test = scaler.transform(X_test)
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_absolute_error, mean_squared_error

rf = RandomForestRegressor(n_estimators=200, max_depth=10, random_state=42)
rf.fit(X_train, y_train)
pred_rf = rf.predict(X_test)from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense

model = Sequential([
    Dense(64, activation='relu', input_shape=(X_train.shape[1],)),
    Dense(32, activation='relu'),
    Dense(1)
])
model.compile(optimizer='adam', loss='mse', metrics=['mae'])from flask import Flask, request, jsonify
import joblib

app = Flask(__name__)
model = joblib.load('best_model.pkl')
scaler = joblib.load('scaler.pkl')

@app.route('/predict', methods=['POST'])
def predict():
    data = request.json['features']
    X = scaler.transform([data])
    pred = model.predict(X)[0]
    return jsonify({'traffic_volume': float(pred)})

app.run(host='0.0.0.0', port=5000)

model.fit(X_train, y_train, epochs=50, batch_size=32,
          validation_split=0.2, verbose=2)

mae_rf = mean_absolute_error(y_test, pred_rf)
rmse_rf = mean_squared_error(y_test, pred_rf, squared=False)
