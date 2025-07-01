from sklearn.model_selection import train_test_split

# Split data (80% train, 20% test)
X_train, X_test, y_train, y_test = train_test_split(
    X_scaled,      # features
    y,             # target
    test_size=0.2, # 20% for testing
    random_state=42 # for reproducibility
)

# Print shapes to verify
print("Training Set Shape:", X_train.shape, y_train.shape)
print("Test Set Shape:", X_test.shape, y_test.shape)
import matplotlib.pyplot as plt
import seaborn as sns

plt.figure(figsize=(10, 5))
sns.histplot(y_train, color='blue', label='Train', kde=True)
sns.histplot(y_test, color='red', label='Test', kde=True)
plt.title('Distribution of Traffic Volume in Train vs Test')
plt.legend()
plt.tight_layout()
plt.show()
