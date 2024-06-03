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

# df <- read.csv("./data/clean_credit_score.csv")
# df$credit_score <- factor(df$credit_score, levels = c("Good", "Standard", "Poor"), ordered = TRUE)
# df$month <- factor(df$month, levels = c("January", "February", "March", "April", "May", "June", 
#                                         "July", "August"), ordered = TRUE)


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


scatter_plot_ir_creditscore()
bee_swarm_plot()