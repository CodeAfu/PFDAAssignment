library(tidyverse)
library(ggplot2)

color_one <- "#0894B9"
color_two <- "#BA3019"
color_three <- "#063750"
color_four <- "#E76B14"
color_five <- "#E1C335"

df <- read_csv("./data/clean_credit_score.csv")

distribution_outstanding_debt <- function() {
  plot <- ggplot(df, aes(x = outstanding_debt)) +
    geom_histogram(binwidth = 100, fill = color_one, color = "black", alpha = 0.7) +
    labs(title = "Distribution of Outstanding Debt", x = "Outstanding Debt", y = "Count")

  ggsave("./plots/outstanding_debt/distribution.png", plot = plot, width = 16, height = 10)
}

box_plot <- function() {
  plot <- ggplot(df, aes(x = credit_score, y = outstanding_debt, fill = credit_score), color = c()) +
    geom_boxplot(alpha = 0.7) +
    labs(title = "Outstanding Debt by Credit Score", x = "Credit Score", y = "Outstanding Debt")

  ggsave("./plots/outstanding_debt/boxplot.png", plot = plot, width = 16, height = 10)
}


bar_plot <- function() {
  plot <- ggplot(df, aes(x = credit_score, fill=occupation)) +
    geom_bar() + 
    facet_wrap(~occupation) +
    labs(title = "Credit Score Distribution", x = "Credit Score", y = "Count")
    

  ggsave("./plots/outstanding_debt/barplot.png", plot = plot, width = 16, height = 10)
}

# distribution_outstanding_debt()
# box_plot()
bar_plot()



View(df)