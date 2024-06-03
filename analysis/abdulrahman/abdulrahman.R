# Install necessary packages if not already installed
if (!require("readr")) install.packages("readr", dependencies = TRUE)
if (!require("dplyr")) install.packages("dplyr", dependencies = TRUE)
if (!require("ggplot2")) install.packages("ggplot2", dependencies = TRUE)
if (!require("MASS")) install.packages("MASS", dependencies = TRUE)

# Load necessary libraries
library(readr)
library(dplyr)
library(ggplot2)
library(MASS)

# Replace with the correct path to your CSV file
file_path <- "/Users/mac/Downloads/PFDAAssignment-main/data/clean_credit_score.csv"

# Load the data
data <- read_csv(file_path)

# Inspect the first few rows of the data
head(data)

# Check the structure of the data
str(data)

# Convert relevant columns to factors if they are categorical
data$credit_score <- as.factor(data$credit_score)

# Ensure total_emi_per_month is numeric
data$total_emi_per_month <- as.numeric(data$total_emi_per_month)

# Plot the relationship between total_emi_per_month and credit_score
ggplot(data, aes(x = total_emi_per_month, y = credit_score)) +
  geom_boxplot() +
  labs(title = "Credit Score vs Total EMI per Month",
       x = "Total EMI per Month",
       y = "Credit Score")

# Fit an ordinal logistic regression model
model <- polr(credit_score ~ total_emi_per_month, data = data, Hess = TRUE)

# Display the summary of the model
summary(model)

# Convert coefficients to odds ratios
exp(coef(model))
