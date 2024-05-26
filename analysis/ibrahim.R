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

credit_score_colors <- c(color_three, color_five, color_two)

df <- read_csv("./data/clean_credit_score.csv")
df$credit_score <- factor(df$credit_score, levels = c("Good", "Standard", "Poor"), ordered = TRUE)

distribution_outstanding_debt <- function() {
  plot <- ggplot(df, aes(x = outstanding_debt)) +
    geom_histogram(binwidth = 100, fill = color_one, color = "black", alpha = 0.7) +
    labs(title = "Distribution of Outstanding Debt", x = "Outstanding Debt", y = "Count")

  ggsave("./plots/outstanding_debt/distribution.png", plot = plot, width = 16, height = 10)
}

box_plot <- function() {
  plot <- ggplot(df, aes(x = credit_score, y = outstanding_debt, fill = credit_score)) +
    geom_boxplot(alpha = 0.7) +
    labs(title = "Outstanding Debt by Credit Score", x = "Credit Score", y = "Outstanding Debt") +
    scale_fill_manual(values = credit_score_colors) 

  ggsave("./plots/outstanding_debt/boxplot.png", plot = plot, width = 16, height = 10)
}

bar_plot <- function() {
  plot <- ggplot(df, aes(x = credit_score)) +
    geom_bar(fill = credit_score_colors) + 
    labs(title = "Credit Score Distribution", x = "Credit Score", y = "Count")

  ggsave("./plots/outstanding_debt/barplot.png", plot = plot, width = 16, height = 10)
}

bar_plot_occupation <- function() {
  plot <- ggplot(df, aes(x = credit_score, fill = credit_score)) +
    geom_bar() + 
    facet_wrap(~occupation) +
    labs(title = "Credit Score Distribution", x = "Credit Score", y = "Count") +
    scale_fill_manual(values = credit_score_colors) 

  ggsave("./plots/outstanding_debt/barplot_occupation.png", plot = plot, width = 16, height = 10)
}

bar_plot_interestrate <- function() {
  plot <- ggplot(df, aes(x = credit_score, fill = credit_score)) +
    geom_bar() + 
    facet_wrap(~interest_rate, labeller = labeller(interest_rate = label_both)) +
    labs(title = "Credit Score Distribution by Interest Rate", x = "Credit Score", y = "Count") +
    scale_fill_manual(values = credit_score_colors) 
    
  ggsave("./plots/outstanding_debt/barplot_ir.png", plot = plot, width = 16, height = 10)
}

scatter_plot_regression <- function() {
  plot <- ggplot(df, aes(x = outstanding_debt, y = as.numeric(credit_score))) +
    geom_point(alpha = 0.5) +
    geom_smooth(method = "lm", color = "red") +
    labs(title = "Outstanding Debt vs Credit Score", x = "Outstanding Debt", y = "Credit Score (Numeric)")

  ggsave("./plots/outstanding_debt/scatterplot_regr.png", plot = plot, width = 16, height = 10)
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
    scale_fill_manual(values = credit_score_colors)

  ggsave("./plots/outstanding_debt/facted_hist.png", plot = plot, width = 16, height = 10)
}

cor_matrix <- function() {
  num_data <- df %>%
    select(outstanding_debt, monthly_inhand_salary, num_bank_accounts, num_credit_card, 
      interest_rate, num_of_loan, delay_from_due_date, num_of_delayed_payment, 
      changed_credit_limit, num_credit_inquiries, credit_utilization_ratio, total_emi_per_month, 
      amount_invested_monthly, monthly_balance)

  cor_matrix <- cor(num_data, use = "complete.obs")

  plot <- ggcorrplot(cor_matrix, method = "circle", type = "lower", lab = TRUE, lab_size = 3)

  ggsave("./plots/outstanding_debt/corr_matrix.png", plot = plot, width = 10, height = 10)
}


# distribution_outstanding_debt()
box_plot()
# bar_plot()
# bar_plot_occupation()
# bar_plot_interestrate()
# scatter_plot_regression()
# histogram_faceted()
# cor_matrix()






# pair_plot <- function() {
#   plot <- ggpairs(df, columns = c("outstanding_debt", "credit_score", "monthly_inhand_salary", "num_bank_accounts", "num_credit_card", "interest_rate"), aes(color = credit_score, alpha = 0.5))
  
#   ggsave("./plots/outstanding_debt/pair_plot.png", plot = plot, width = 30, height = 30)
# }

# pair_plot()
