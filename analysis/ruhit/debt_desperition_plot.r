
library(tidyverse)

color_one <- "#0894B9"
color_two <- "#BA3019"
color_three <- "#063750"
color_four <- "#E76B14"
color_five <- "#E1C335"
colors_credit_score <- c(color_three, color_five, color_two)

delayCredit <- read.csv("/mnt/data/clean_credit_score.csv")

debt_dispersion_plot <- function(df) {
  plot <- ggplot(df, aes(x = as.factor(credit_score), y = outstanding_debt)) +
    geom_boxplot(aes(fill = as.factor(credit_score)), alpha = 0.7) +
    geom_jitter(width = 0.2, alpha = 0.5) +
    labs(x = "Credit Score", y = "Outstanding Debt", title = "Dispersion Analysis of Outstanding Debt by Credit Score") +
    scale_fill_manual(values = colors_credit_score) 
  
  ggsave("./ruhit_plots/debt_dispersion_analysis.png", plot = plot, width = 16, height = 10)
}

debt_dispersion_plot(delayCredit)
