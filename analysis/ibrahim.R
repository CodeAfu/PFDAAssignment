
library(tidyverse)
library(ggplot2)

df <- read_csv("./data/clean_credit_score.csv")

plot_one <- function() {
  plot <- ggplot(df, aes(x = outstanding_debt)) +
    geom_histogram(binwidth = 300, fill = "blue", color = "black", alpha = 0.5) +
    labs(title = "Distribution of Outstanding Debt", x = "Outstanding Debt", y = "Count")


  ggsave("./plots/test.png", plot = plot, width = 16, height = 10)
}

plot_one()


