
library(tidyverse)

color_one <- "#0894B9"
color_two <- "#BA3019"
color_three <- "#063750"
color_four <- "#E76B14"
color_five <- "#E1C335"
colors_credit_score <- c(color_three, color_five, color_two)

delayCredit <- read.csv("/mnt/data/clean_credit_score.csv")


 
box_jitter_plot <- function(df) {
  plot <- ggplot(df, aes(x = as.factor(credit_score), y = delay_from_due_date)) + # nolint: line_length_linter.
    geom_boxplot(aes(fill = as.factor(credit_score)), alpha = 0.7) +
    geom_jitter(aes(color = outstanding_debt), width = 0.2, alpha = 0.5) +
    labs(x = "Credit Score", y = "Delay From Due Date", color = "Outstanding Debt", # nolint: line_length_linter.
         title = "Dispersion Analysis of Delay From Due Date by Credit Score and Outstanding Debt") + 
    scale_fill_manual(values = colors_credit_score) 
 
  ggsave("./ruhit_plots/delay_debt_plot.png", plot = plot, width = 16, height = 10)
}


delay_debt_plot(delayCredit)
