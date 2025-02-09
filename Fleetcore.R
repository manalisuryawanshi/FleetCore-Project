# Set working directory
setwd("~/DMining")

# Load necessary libraries
library(tidyverse)
library(readxl)

# Read the Excel file
data <- read.csv("Fleetcor_Final_Consolidated_Data.csv")

# View the first few rows of the dataset
head(data)

# Summary of the dataset
summary(data)

# Create a pivot table for frequency and spending
pivot_table <- data %>%
  group_by(LOCK_REASON) %>%
  summarize(Frequency = n(), 
            Average_CREDIT_LIMIT = mean(CREDIT_LIMIT), 
            Std_Dev_CREDIT_LIMIT = sd(CREDIT_LIMIT))

# Display the pivot table
print(pivot_table)

# Scatterplot TOT_NET_REV vs. CREDIT_LIMIT
ggplot(data, aes(x = CREDIT_LIMIT, y = LOCK_REASON, color = LOCK_REASON)) +
  geom_point() +
  ggtitle("Scatterplot: LOCK_REASON vs. CREDIT_LIMIT")

# Scatterplot TOT_NET_REV vs. YEARMONTH
ggplot(data, aes(x = YEARMONTH, y = LOCK_REASON, color = LOCK_REASON)) +
  geom_point() +
  ggtitle("Scatterplot: TOT_NET_REV vs. YEARMONTH")

# Scatterplot TOT_NET_REV vs. FUEL_NET_REV
ggplot(data, aes(x = FUEL_NET_REV, y = LOCK_REASON, color = LOCK_REASON)) +
  geom_point() +
  ggtitle("Scatterplot: TOT_NET_REV vs. FUEL_NET_REV")
data <- data %>% 
  select(-VANTAGE_SCORE)
# i. Partition records into training and validation sets
set.seed(123)
train_indices <- sample(seq_len(nrow(data)), size = 0.7 * nrow(data))
train_set <- data[train_indices, ]
validation_set <- data[-train_indices, ]

# ii. Run a multiple linear regression model
model <- lm(LOCK_REASON ~ ., data = train_set)

# iii. Estimated predictive equation
summary(model)

# iv. Backward elimination
backward_elimination_model <- step(model, direction = "backward")

# v. Prediction and prediction error for the first record in the validation set
first_validation_record <- validation_set[1, ]
predicted_TOT_NET_REV <- predict(backward_elimination_model, newdata = first_validation_record)
prediction_error <- first_validation_record$TOT_NET_REV - predicted_TOT_NET_REV

# Compute Mean Error
mean_error <- mean(predicted_TOT_NET_REV - validation_set$TOT_NET_REV)
cat("Mean Error:", mean_error, "\n")

# Compute Mean Absolute Error (MAE)
mae <- mean(abs(predicted_TOT_NET_REV - validation_set$TOT_NET_REV))
cat("Mean Absolute Error (MAE):", mae, "\n")

# Compute Root Mean Squared Error (RMSE)
rmse <- sqrt(mean((predicted_TOT_NET_REV - validation_set$TOT_NET_REV)^2))
cat("Root Mean Squared Error (RMSE):", rmse, "\n")

# Compute R-squared
rsquared <- summary(model)$r.squared
cat("R-squared:", rsquared, "\n")

# Compute Mean Percentage Error (MPE)
mpe <- (mean(predicted_TOT_NET_REV - validation_set$TOT_NET_REV) / mean(validation_set$TOT_NET_REV)) * 100
cat("Mean Percentage Error (MPE):", mpe, "\n")

# Compute Mean Absolute Percentage Error (MAPE)
mape <- (mean(abs(predicted_TOT_NET_REV - validation_set$TOT_NET_REV)) / mean(validation_set$TOT_NET_REV)) * 100
cat("Mean Absolute Percentage Error (MAPE):", mape, "\n")

# vi. Evaluate predictive accuracy on the validation set
validation_predictions <- predict(backward_elimination_model, newdata = validation_set)
accuracy <- sqrt(mean((validation_set$TOT_NET_REV - validation_predictions)^2))

# vii. Create a histogram of model residuals
residuals <- residuals(backward_elimination_model)
hist(residuals, col = "skyblue", main = "Histogram of Model Residuals", xlab = "Residuals")

# Check for normal distribution using qqplot
qqnorm(residuals)
qqline(residuals)
