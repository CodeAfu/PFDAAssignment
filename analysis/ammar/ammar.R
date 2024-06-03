library(tidyverse)
library(ggplot2)
library(broom)
library(psych)
library(multcomp)
library(rpart)
library(rpart.plot)

# Load the cleaned dataset
df_clean <- read_csv("./data/clean_credit_score.csv")

# Analysis 1: Distribution of Interest Rates across Different Credit Score Categories
distribution_analysis <- function(df_clean) {
  # Box Plot
  box_plot <- ggplot(df_clean, aes(x = credit_score, y = interest_rate, fill = credit_score)) +
    geom_boxplot() +
    labs(title = "Interest Rate Distribution by Credit Score Category",
         x = "Credit Score",
         y = "Interest Rate") +
    theme_minimal()
  ggsave("./plots/interest_rate_box_plot.png", plot = box_plot, width = 8, height = 6)
  print(box_plot)
  
  # Violin Plot
  violin_plot <- ggplot(df_clean, aes(x = credit_score, y = interest_rate, fill = credit_score)) +
    geom_violin() +
    geom_jitter(width = 0.1, alpha = 0.2) +
    labs(title = "Interest Rate Distribution by Credit Score Category",
         x = "Credit Score",
         y = "Interest Rate") +
    theme_minimal()
  ggsave("./plots/interest_rate_violin_plot.png", plot = violin_plot, width = 8, height = 6)
  print(violin_plot)
  
  # Faceted Histogram
  histogram <- ggplot(df_clean, aes(x = interest_rate, fill = credit_score)) +
    geom_histogram(binwidth = 1, alpha = 0.7) +
    facet_wrap(~ credit_score) +
    labs(title = "Histogram of Interest Rates by Credit Score Category",
         x = "Interest Rate",
         y = "Count") +
    theme_minimal()
  ggsave("./plots/interest_rate_histogram.png", plot = histogram, width = 16, height = 10)
  print(histogram)
}

# Analysis 2: Significant Relationship between Interest Rates and Credit Scores
relationship_analysis <- function(df_clean) {
  # Convert credit_score to numeric
  data <- df_clean %>%
    mutate(credit_score_numeric = as.numeric(as.factor(credit_score)),
           interest_rate_category = cut(interest_rate, 
                                        breaks = c(-Inf, 10, 20, Inf), 
                                        labels = c("Low", "Medium", "High")))
  
  # Calculate Pearson and Spearman correlation
  pearson_cor <- cor(data$interest_rate, data$credit_score_numeric, method = "pearson", use = "complete.obs")
  spearman_cor <- cor(data$interest_rate, data$credit_score_numeric, method = "spearman", use = "complete.obs")
  print(paste("Pearson Correlation: ", pearson_cor))
  print(paste("Spearman Correlation: ", spearman_cor))
  
  # Scatter Plot with Regression Line
  scatter_plot <- ggplot(data, aes(x = interest_rate, y = credit_score_numeric)) +
    geom_point(alpha = 0.5) +
    geom_smooth(method = "lm", se = FALSE, color = "blue") +
    labs(title = "Scatter Plot of Interest Rate vs Credit Score",
         x = "Interest Rate", y = "Credit Score (Numeric)") +
    theme_minimal()
  ggsave("./plots/scatter_plot_interest_rate_vs_credit_score.png", plot = scatter_plot, width = 16, height = 10)
  print(scatter_plot)
  
  # Contingency Table
  contingency_table <- table(data$credit_score, data$interest_rate_category)
  print(contingency_table)
  
  # Bar Plot
  bar_plot <- ggplot(data, aes(x = credit_score, fill = interest_rate_category)) +
    geom_bar(position = "fill") +
    labs(title = "Bar Plot of Credit Score by Interest Rate Category",
         x = "Credit Score", y = "Proportion", fill = "Interest Rate Category") +
    theme_minimal()
  ggsave("./plots/bar_plot_credit_score_interest_rate_category.png", plot = bar_plot, width = 16, height = 10)
  print(bar_plot)
}

# Analysis 3: Impact of Interest Rates on the Probability of Having Different Credit Scores using Decision Tree
decision_tree_analysis <- function(data) {
  # Decision Tree Model
  tree_model <- rpart(credit_score ~ interest_rate, data = data, method = "class")
  print(tree_model)
  
  # Plot Decision Tree and save it
  png("./plots/decision_tree.png", width = 1600, height = 1000)
  rpart.plot(tree_model, type = 3, extra = 104, fallen.leaves = TRUE, main = "Decision Tree for Credit Score")
  dev.off()
  
  # Display the decision tree plot
  rpart.plot(tree_model, type = 3, extra = 104, fallen.leaves = TRUE, main = "Decision Tree for Credit Score")
}


# Analysis 4: Differences in Interest Rates Between Similar Financial Profiles but Different Credit Scores
financial_profile_analysis <- function(df_clean) {
  data <- df_clean %>%
    mutate(interest_rate_category = cut(interest_rate, 
                                        breaks = c(-Inf, 10, 20, Inf), 
                                        labels = c("Low", "Medium", "High")),
           total_debt = outstanding_debt + total_emi_per_month)
  
  # Summary Statistics
  summary_stats <- data %>%
    group_by(credit_score, interest_rate_category) %>%
    summarise(
      mean_total_debt = mean(total_debt, na.rm = TRUE),
      mean_delay_from_due_date = mean(delay_from_due_date, na.rm = TRUE),
      n = n()
    )
  print(summary_stats)
  
  # Density Plot of Total Debt by Credit Score and Interest Rate Category
  density_plot <- ggplot(data, aes(x = total_debt, fill = credit_score)) +
    geom_density(alpha = 0.5) +
    facet_wrap(~ interest_rate_category) +
    labs(title = "Density Plot of Total Debt by Credit Score and Interest Rate Category",
         x = "Total Debt",
         y = "Density",
         fill = "Credit Score") +
    theme_minimal()
  ggsave("./plots/density_plot_total_debt_by_credit_score_and_interest_rate_category.png", plot = density_plot, width = 16, height = 10)
  print(density_plot)
  
  # Box Plot of Delay from Due Date by Credit Score and Interest Rate Category
  box_plot <- ggplot(data, aes(x = credit_score, y = delay_from_due_date, fill = credit_score)) +
    geom_boxplot(alpha = 0.7) +
    facet_wrap(~ interest_rate_category) +
    labs(title = "Box Plot of Delay from Due Date by Credit Score and Interest Rate Category",
         x = "Credit Score",
         y = "Delay from Due Date (Days)",
         fill = "Credit Score") +
    theme_minimal()
  ggsave("./plots/box_plot_delay_from_due_date_by_credit_score_and_interest_rate_category.png", plot = box_plot, width = 16, height = 10)
  print(box_plot)
}

# Run all analyses
distribution_analysis(df_clean)
relationship_analysis(df_clean)
decision_tree_analysis(df_clean)
financial_profile_analysis(df_clean)