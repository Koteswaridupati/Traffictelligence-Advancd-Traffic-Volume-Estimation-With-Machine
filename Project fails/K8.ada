from sklearn.preprocessing import StandardScaler
# Initialize the scaler
scaler = StandardScaler()

# Fit and transform the features
X_scaled = scaler.fit_transform(X)

# Optional: Convert back to DataFrame for readability
import pandas as pd
X_scaled_df = pd.DataFrame(X_scaled, columns=X.columns)

print("Scaled Features:")
print(X_scaled_df.head())
import joblib

# Save the scaler for later use in predictions
joblib.dump(scaler, 'models/feature_scaler.pkl')
