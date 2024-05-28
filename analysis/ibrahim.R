library(tidyverse)
library(ggplot2)
library(RColorBrewer)
library(ggcorrplot)
library(GGally)

source("./functions.R")

color_one <- "#0894B9"
color_two <- "#BA3019"
color_three <- "#063750"
color_four <- "#E76B14"
color_five <- "#E1C335"

colors_credit_score <- c(color_three, color_five, color_two)

df <- read.csv("./data/clean_credit_score.csv")
df$credit_score <- factor(df$credit_score, levels = c("Good", "Standard", "Poor"), ordered = TRUE)
glimpse(df)

distribution_outstanding_debt <- function() {
  plot <- ggplot(df, aes(x = outstanding_debt)) +
    geom_histogram(binwidth = 100, fill = color_one, color = "black", alpha = 0.7) +
    labs(title = "Distribution of Outstanding Debt", x = "Outstanding Debt", y = "Count")

  ggsave("./plots/outstanding_debt/distribution.png", plot = plot, width = 16, height = 10)
}

density_crscore_plot <- function() {
  plot <- ggplot(df, aes(x = outstanding_debt, fill = credit_score)) +
    geom_density(alpha = 0.5) +
    labs(x = "Outstanding Debt", y = "Count") +
    scale_fill_manual(values = colors_credit_score)

  ggsave("./plots/outstanding_debt/densityplot_by_credit_score.png", plot = plot, width = 16, height = 10)
}

density_crscore_plot <- function() {
  plot <- ggplot(df, aes(x = outstanding_debt, fill = credit_score)) +
    geom_density(alpha = 0.5) +
    labs(x = "Outstanding Debt", y = "Density") +
    scale_fill_manual(values = colors_credit_score)

  ggsave("./plots/outstanding_debt/densityplot_by_credit_score_fIR.png", plot = plot, width = 16, height = 10)
}

# density_crscore_fpaybehavior_plot <- function() {
#   plot <- ggplot(df, aes(x = outstanding_debt, fill = credit_score)) +
#     geom_density(alpha = 0.5) +
#     labs(x = "Outstanding Debt", y = "Density", title = "Density Plot of Outstanding Debt by Credit Score and Payment Behavior") +
#     facet_grid(payment_behavior ~ credit_score) +
#     scale_fill_manual(values = colors_credit_score)

#   ggsave("./plots/outstanding_debt/densityplot_by_credit_score_fPB.png", plot = plot, width = 16, height = 10)
# }

density_crscore_fnumloan_plot <- function() {
  plot <- ggplot(df, aes(x = outstanding_debt, fill = credit_score)) +
    geom_density(alpha = 0.5) +
    labs(title = "Density Plot of Outstanding Debt by Credit Score and Payment Behavior",
         x = "Outstanding Debt", y = "Density") +
    scale_y_continuous(labels = scales::comma) +
    facet_grid(num_of_loan ~ credit_score, labeller = labeller(num_of_delayed_payment = label_value)) +
    scale_fill_manual(values = colors_credit_score)

  ggsave("./plots/outstanding_debt/densityplot_by_credit_score_fNL.png", plot = plot, width = 16, height = 20)
}

density_crscore_fage_plot <- function() {
  plot <- ggplot(df, aes(x = outstanding_debt, fill = credit_score)) +
    geom_density(alpha = 0.5) +
    labs(title = "Density Plot of Outstanding Debt by Credit Score and Payment Behavior",
         x = "Outstanding Debt", y = "Density") +
    scale_y_continuous(labels = scales::comma) +
    facet_grid(num_of_loan ~ credit_score, labeller = labeller(num_of_delayed_payment = label_value)) +
    scale_fill_manual(values = colors_credit_score)

  ggsave("./plots/outstanding_debt/densityplot_by_credit_score_fNL.png", plot = plot, width = 16, height = 20)
}

table(df$age)

box_plot <- function() {
  plot <- ggplot(df, aes(x = credit_score, y = outstanding_debt, fill = credit_score)) +
    geom_boxplot(alpha = 0.7) +
    labs(title = "Outstanding Debt by Credit Score", x = "Credit Score", y = "Outstanding Debt") +
    scale_fill_manual(values = colors_credit_score) 

  ggsave("./plots/outstanding_debt/boxplot.png", plot = plot, width = 16, height = 10)
}

bar_plot <- function() {
  plot <- ggplot(df, aes(x = credit_score)) +
    geom_bar(fill = colors_credit_score) + 
    labs(title = "Distribution of Credit Score", x = "Credit Score", y = "Count")

  ggsave("./plots/outstanding_debt/barplot.png", plot = plot, width = 16, height = 10)
}

bar_plot_occupation <- function() {
  plot <- ggplot(df, aes(x = credit_score, fill = credit_score)) +
    geom_bar() + 
    facet_wrap(~ occupation) +
    labs(title = "Credit Score Distribution", x = "Credit Score", y = "Count") +
    scale_fill_manual(values = colors_credit_score) 

  ggsave("./plots/outstanding_debt/barplot_occupation.png", plot = plot, width = 16, height = 10)
}

bar_plot_ranges <- function() {
  mutated_df <- df %>%
    mutate(outstanding_debt_bin = cut(outstanding_debt, 
      breaks = c(0, 500, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000, Inf),
      labels = c("0-5k", "5-10k", "10-15k", "15-20k", "20-25k", "25-30k", "30-35k", "35-40k", "40-45k", "45-50k", "50k+"),
      right = FALSE))

  plot <- ggplot(mutated_df, aes(x = credit_score, fill = credit_score)) +
    geom_bar() +
    facet_wrap(~ outstanding_debt_bin, scales = "free_x", labeller = labeller(outstanding_debt_bin = label_both)) +
    labs(title = "Credit Score Distribution by Different Ranges", x = "Outstanding Debt", y = "Credit Score (Numeric)") +
    scale_fill_manual(values = colors_credit_score)
    
  ggsave("./plots/outstanding_debt/barplot_ranges.png", plot = plot, width = 16, height = 10)
}

scatter_plot_regression <- function() {
  plot <- ggplot(df, aes(x = outstanding_debt, y = as.numeric(credit_score))) +
    geom_point(alpha = 0.005) +
    geom_smooth(method = "lm", color = "red") +
    labs(title = "Outstanding Debt vs Credit Score", x = "Outstanding Debt", y = "Credit Score (Numeric)")

  ggsave("./plots/outstanding_debt/scatterplot_regr.png", plot = plot, width = 16, height = 10)
}

scatter_plot_regression_ir <- function() {
  plot <- ggplot(df, aes(x = outstanding_debt, y = as.numeric(credit_score))) +
    geom_point(alpha = 0.005) +
    geom_smooth(method = "lm", color = "red") +
    facet_wrap(~ interest_rate, scales = "free_x", labeller = labeller(interest_rate = label_both)) +
    labs(title = "Outstanding Debt vs Credit Score", x = "Outstanding Debt", y = "Credit Score (Numeric)")

  ggsave("./plots/outstanding_debt/scatterplot_ir_regr.png", plot = plot, width = 16, height = 10)
}

scatter_plot_faceted <- function() {
  plot <- ggplot(df, aes(x = outstanding_debt, y = credit_score, fill = credit_score)) +
    geom_jitter(width = 0, height = 0.2, alpha = 0.5) +
    facet_wrap(~ credit_score, ncol = 1, scales = "free_y") +
    labs(title = "Outstanding Debt vs Credit Score by Category",
         x = "Outstanding Debt",
         y = "Credit Score")

  ggsave("./plots/outstanding_debt/scatterplot_faceted.png", plot = plot, width = 16, height = 10)
}

histogram_faceted <- function() {
  plot <- ggplot(df, aes(x = outstanding_debt, fill = credit_score)) +
    geom_histogram(binwidth = 100, color = "black", alpha = 0.7) +
    # geom_bar(aes(fill = credit_score), position = "dodge") +
    facet_wrap(~ credit_score, ncol = 1, scales = "free_x") +
    labs(title = "Outstanding Debt vs Credit Score by Category",
         x = "Outstanding Debt",
         y = "Count") + 
    scale_fill_manual(values = colors_credit_score)

  ggsave("./plots/outstanding_debt/facted_hist.png", plot = plot, width = 16, height = 10)
}

corr_matrix <- function() {
  num_data <- df %>%
    select(outstanding_debt, monthly_inhand_salary, num_bank_accounts, num_credit_card, 
      interest_rate, num_of_loan, delay_from_due_date, num_of_delayed_payment, 
      changed_credit_limit, num_credit_inquiries, credit_utilization_ratio, total_emi_per_month, 
      amount_invested_monthly, monthly_balance)

  corr_matrix <- cor(num_data, use = "complete.obs")

  plot <- ggcorrplot(corr_matrix, method = "circle", type = "lower", lab = TRUE, lab_size = 3)

  ggsave("./plots/outstanding_debt/corr_matrix.png", plot = plot, width = 10, height = 10)
}

plot_credit_faceted <- function() {
  plot <- ggplot(df, aes(x = credit_score, y = outstanding_debt, fill = credit_score)) +
    geom_boxplot(alpha = 0.7, outlier.shape = NA) +
    geom_jitter(alpha = 0.05, width = 0.2) +
    facet_wrap(~ num_of_loan, labeller = labeller(num_of_loan = label_both), scale = "free_y") +
    scale_fill_manual(values = colors_credit_score) +
    labs(x = "Credit Score", y = "Outstanding Debt", title = "Outstanding Debt vs Credit Score Based on Number of Loans")

  ggsave("./plots/outstanding_debt/density_creditcard_faceted.png", plot = plot, width = 16, height = 10)
}

summary(df$outstanding_debt)

# distribution_outstanding_debt()
# density_crscore_plot()
density_crscore_fnumloan_plot()
# density_plot_faceted()
# box_plot()
# bar_plot()
# bar_plot_occupation()
# bar_plot_ranges()
# scatter_plot_regression()
# scatter_plot_regression_ir()
# histogram_faceted()
# corr_matrix()
# plot_credit_faceted()

