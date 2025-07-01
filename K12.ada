TrafficTelligence/
├── app.py                   ← Flask app script
├── templates/
│   └── index.html           ← HTML form (from previous step)
├── models/
│   ├── traffic_model.pkl
│   ├── weather_encoder.pkl
│   ├── day_encoder.pkl
│   └── feature_scaler.pkl
# app.py

from flask import Flask, render_template, request
import joblib
import numpy as np

app = Flask(__name__)

# Load model and preprocessing tools
model = joblib.load("models/traffic_model.pkl")
weather_encoder = joblib.load("models/weather_encoder.pkl")
day_encoder = joblib.load("models/day_encoder.pkl")
scaler = joblib.load("models/feature_scaler.pkl")

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/predict', methods=['POST'])
def predict():
    hour = int(request.form['hour'])
    day = request.form['day']
    weather = request.form['weather']

    # Encode inputs
    day_encoded = day_encoder.transform([day])[0]
    weather_encoded = weather_encoder.transform([weather])[0]

    # Prepare feature array
    features = np.array([[hour, weather_encoded, day_encoded]])

    # Scale features
    features_scaled = scaler.transform(features)

    # Make predictionpython app.py

    prediction = model.predict(features_scaled)[0]

    return render_template('index.html',flask
scikit-learn
joblib
numpy
pandas

                           prediction_text=f"Estimated Traffic Volume: {int(prediction)} vehicles")
 * Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)

if __name__ == '__main__':
    app.run(debug=True)
