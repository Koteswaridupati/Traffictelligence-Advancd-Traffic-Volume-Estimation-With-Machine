<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>TrafficTelligence - Traffic Volume Predictor</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f0f4f8;
            margin: 0;
            padding: 40px;
        }
        .container {
            background: white;
            max-width: 500px;
            margin: auto;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        label {
            display: block;
            margin-top: 15px;
            color: #333;
        }
        input, select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        button {
            margin-top: 20px;
            width: 100%;
            background: #007BFF;
            color: white;
            border: none;
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background: #0056b3;
        }
        .result {
            margin-top: 20px;
            padding: 15px;
            background: #e6ffe6;
            color: #006400;
            border-left: 5px solid #00cc00;
            font-size: 18px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Traffic Volume Prediction</h2>
        <form action="/predict" method="post">
            <label for="hour">Hour of the Day (0-23):</label>
            <input type="number" id="hour" name="hour" min="0" max="23" required>

            <label for="day">Day of the Week:</label>
            <select id="day" name="day">
                <option value="Monday">Monday</option>
                <option value="Tuesday">Tuesday</option>
                <option value="Wednesday">Wednesday</option>
                <option value="Thursday">Thursday</option>@app.route('/predict', methods=['POST'])
def predict():
    hour = int(request.form['hour'])
    day = request.form['day']
    weather = request.form['weather']

    # Encode and transform input
    day_encoded = day_encoder.transform([day])[0]
    weather_encoded = weather_encoder.transform([weather])[0]
    features = np.array([[hour, weather_encoded, day_encoded]])
    features_scaled = scaler.transform(features)

    # Predict
    prediction = model.predict(features_scaled)[0]

    return render_template('index.html',
                           prediction_text=f"Estimated Traffic Volume: {int(prediction)} vehicles")

                <option value="Friday">Friday</option>
                <option value="Saturday">Saturday</option>
                <option value="Sunday">Sunday</option>
            </select>

            <label for="weather">Weather Condition:</label>
            <select id="weather" name="weather">
                <option value="Clear">Clear</option>
                <option value="Clouds">Clouds</option>
                <option value="Rain">Rain</option>
                <option value="Snow">Snow</option>
                <option value="Mist">Mist</option>
            </select>

            <button type="submit">Predict Traffic Volume</button>
        </form>

        {% if prediction_text %}
        <div class="result">
            {{ prediction_text }}
        </div>
        {% endif %}python app.py
python app.py

    </div>
</body>
</html>
