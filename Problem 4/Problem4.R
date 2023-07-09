# Load required libraries
library(ggplot2)   # for data visualization
library(forecast)  # for time series modeling

# Read the data from CSV file
data <- read.csv("forecast.csv")

# Check the structure and summary statistics of the data
str(data)
summary(data)

# Convert MONTH_YEAR column to Date format
data$MONTH_YEAR <- as.Date(data$MONTH_YEAR, format = "%Y-%m")

# Perform EDA - Example plots
# Line plot of Quantity over time
ggplot(data, aes(x = MONTH_YEAR, y = QUANTITY)) +
  geom_line() +
  labs(x = "Month-Year", y = "Quantity") +
  ggtitle("SKU Quantity Over Time")

# Seasonal decomposition plot
decomposed <- stl(data$QUANTITY, s.window = "periodic")
plot(decomposed)

# Modeling - Example ARIMA model
# Split data into training and test sets
train_data <- data[1:80, ]
test_data <- data[81:nrow(data), ]

# Fit ARIMA model
model <- auto.arima(train_data$QUANTITY)
# Forecast using the ARIMA model
forecast <- forecast(model, h = nrow(test_data))

# Plot actual vs. forecasted values
plot(forecast, main = "Actual vs. Forecasted Quantity")

# Calculate evaluation metrics
accuracy(forecast, test_data$QUANTITY)

