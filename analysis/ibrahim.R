library(tidyverse)
library(ggplot2)
library(RColorBrewer)
library(ggcorrplot)
library(GGally)
library(ggExtra)


source("./functions.R")

color_one <- "#0894B9"
color_two <- "#BA3019"
color_three <- "#063750"
color_four <- "#E76B14"
color_five <- "#E1C335"

colors_credit_score <- c(color_three, color_five, color_two)

df <- read.csv("./data/clean_credit_score.csv")
df$credit_score <- factor(df$credit_score, levels = c("Good", "Standard", "Poor"), ordered = TRUE)
df$month <- factor(df$month, levels = c("January", "February", "March", "April", "May", "June", 
                                        "July", "August", "September", "October", "November", "December"), ordered = TRUE)
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

  ggsave("./plots/outstanding_debt/densityplot_by_credit_score_fInterestRate.png", plot = plot, width = 16, height = 10)
}

violin_plot <- function() {
  plot <- ggplot(df, aes(x = credit_score, y = outstanding_debt, fill = credit_score)) +
    geom_violin(alpha = 0.7, trim = FALSE) +
    geom_boxplot(width = 0.1, outlier.shape = NA, alpha = 0.5) +
    scale_fill_manual(values = colors_credit_score) + 
    labs(x =  "Credit Score",  y = "Outstanding Debt", title = "Violin Plot of Outstanding Debt by Credit Score")

  ggsave("./plots/outstanding_debt/violinplot.png", plot = plot, width = 16, height = 10)
}

density_crscore_fnumloan_plot <- function() {
  plot <- ggplot(df, aes(x = outstanding_debt, fill = credit_score)) +
    geom_density(alpha = 0.5) +
    labs(title = "Density Plot of Outstanding Debt by Credit Score by Number of Loans",
         x = "Outstanding Debt", y = "Density") +
    scale_y_continuous(labels = scales::comma) +
    facet_grid(num_of_loan ~ credit_score, labeller = labeller(num_of_delayed_payment = label_value)) +
    scale_fill_manual(values = colors_credit_score)

  ggsave("./plots/outstanding_debt/densityplot_by_credit_score_fNumLoan.png", plot = plot, width = 16, height = 20)
}

density_crscore_fage_plot <- function() {
  plot <- ggplot(df, aes(x = outstanding_debt, fill = credit_score)) +
    geom_density(alpha = 0.5) +
    labs(title = "Density Plot of Outstanding Debt by Credit Score and Payment Behavior",
         x = "Outstanding Debt", y = "Density") +
    scale_y_continuous(labels = scales::comma) +
    facet_grid(age ~ credit_score, labeller = labeller(num_of_delayed_payment = label_value)) +
    scale_fill_manual(values = colors_credit_score)

  ggsave("./plots/outstanding_debt/densityplot_by_credit_score_fAge.png", plot = plot, width = 16, height = 40)
}

scatter_plot <- function() {
  plot <- ggplot(df, aes(x = outstanding_debt, y = credit_score, color = credit_score, fill = credit_score)) +
    geom_jitter(alpha = 0.1) +
    scale_color_manual(values = colors_credit_score) +
    scale_fill_manual(values = colors_credit_score) +
    labs(title = "Scatter Plot of Outstanding Debt by Credit Score", 
         x = "Outstanding Debt", 
         y = "Credit Score")

  ggsave("./plots/outstanding_debt/scatterplot_by_credit_score.png", plot = plot, width = 16, height = 10)
}

scatter_plot_fIR <- function() {
  plot <- ggplot(df, aes(x = outstanding_debt, y = credit_score, color = credit_score, fill = credit_score)) +
    geom_jitter(alpha = 0.1) +
    scale_color_manual(values = colors_credit_score) +
    scale_fill_manual(values = colors_credit_score) +
    labs(title = "Scatter Plot of Outstanding Debt by Credit Score", 
         x = "Outstanding Debt", 
         y = "Credit Score") + 
    facet_wrap(~ interest_rate)

}

box_plot <- function() {
  plot <- ggplot(df, aes(x = credit_score, y = outstanding_debt, fill = credit_score)) +
    geom_boxplot(alpha = 0.7) +
    geom_jitter(alpha = 0.03, width = 0.15) +
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

scatter_plot_regression_ir <- function() {
  plot <- ggplot(df, aes(x = outstanding_debt, y = as.numeric(credit_score), color = credit_score), fill = credit_score) +
    geom_jitter(alpha = 0.05, size = 0.5) +
    geom_smooth(method = "lm", color = "red") +
    facet_wrap(~ interest_rate, scales = "free_x", labeller = labeller(interest_rate = label_both)) +
    labs(title = "Outstanding Debt vs Credit Score", x = "Outstanding Debt", y = "Credit Score") +
    scale_color_manual(values = colors_credit_score) +
    scale_fill_manual(values = colors_credit_score) +
    scale_y_continuous(breaks = 1:3, labels = c("Good", "Standard", "Poor"))

  ggsave("./plots/outstanding_debt/scatterplot_ir_regr.png", plot = plot, width = 16, height = 10)
}

heatmap <- function() {
  plot <- ggplot(df, aes(x = outstanding_debt, y = annual_income, fill = credit_score)) +
    geom_tile()
  plot
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

boxplot_loan_faceted <- function() {
  plot <- ggplot(df, aes(x = credit_score, y = outstanding_debt, fill = credit_score)) +
    geom_boxplot(alpha = 0.7, outlier.shape = NA) +
    geom_jitter(alpha = 0.05, width = 0.1) +
    facet_wrap(~ num_of_loan, labeller = labeller(num_of_loan = label_both), scale = "free_y") +
    scale_fill_manual(values = colors_credit_score) +
    labs(x = "Credit Score", y = "Outstanding Debt", title = "Outstanding Debt vs Credit Score Based on Number of Loans")

  ggsave("./plots/outstanding_debt/boxplot_loan_faceted.png", plot = plot, width = 16, height = 10)
}

facet_grid_plot <- function() {
  plot <- ggplot(df, aes(x = outstanding_debt, fill = credit_score)) +
    geom_density(alpha = 0.5) +
    labs(title = "Density Plot of Outstanding Debt by Credit Score and Number of Loans",
         x = "Outstanding Debt",
         y = "Density") +
    facet_grid(num_of_loan ~ credit_score, scale = "free_x") +
    scale_fill_manual(values = colors_credit_score)

  ggsave("./plots/outstanding_debt/densityplot_by_credit_score_facet_loan.png", plot = plot, width = 16, height = 10)
}

bee_swarm_plot <- function() {
  plot <- ggplot(df, aes(x = credit_score, y = outstanding_debt, color = credit_score)) +
    ggbeeswarm::geom_beeswarm(alpha = 0.1) +
    labs(title = "Bee Swarm Plot of Outstanding Debt by Credit Score",
         x = "Credit Score",
         y = "Outstanding Debt") +
    scale_color_manual(values = colors_credit_score) +    
    theme(axis.text.x = element_text(angle = 45, hjust = 1),
          plot.margin = unit(c(1, 1, 2, 1), "cm"))

  ggsave("./plots/outstanding_debt/beeswarm_plot_by_credit_score.png", plot = plot, width = 16, height = 10)
}


scatter_plot_ir_creditscore <- function() {
  plot <- ggplot(df, aes(x = outstanding_debt, y = interest_rate, color = credit_score)) +
    geom_point(size = 1) +
    geom_smooth(color = "tomato4") +
    facet_wrap(~ credit_score, ncol = 1) +
    scale_color_manual(values = colors_credit_score) +    
    labs(title = "Scatter Plot of Outstanding Debt by Interest Rate for Credit Score", x = "Outstanding Debt", y = "Interest Rate")

  ggsave("./plots/outstanding_debt/scatterplot_ir_fCreditScore.png", plot = plot, width = 16, height = 10)
}

summary(df$outstanding_debt)


distribution_outstanding_debt()
density_crscore_plot()
density_crscore_fnumloan_plot()
density_crscore_fage_plot()
scatter_plot()
violin_plot()
box_plot()
bar_plot()
bar_plot_occupation()
bar_plot_ranges()
scatter_plot_regression_ir()
histogram_faceted()
corr_matrix()
boxplot_loan_faceted()
scatter_plot_ir_creditscore()
bee_swarm_plot()