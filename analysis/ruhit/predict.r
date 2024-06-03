library(nnet)
library(ggplot2)
library(dplyr)
library(tidyr)

delayCredit <- read.csv("./data/clean_credit_score.csv")

delayCredit$credit_score <- as.factor(delayCredit$credit_score)

model <- multinom(credit_score ~ delay_from_due_date, data = delayCredit)

new_data <- data.frame(delay_from_due_date = seq(min(delayCredit$delay_from_due_date), max(delayCredit$delay_from_due_date), length.out = 100))

predicted <- predict(model, newdata = new_data, type = "probs")
predicted <- as.data.frame(predicted)
predicted$delay_from_due_date <- new_data$delay_from_due_date

predicted_long <- tidyr::gather(predicted, key = "Credit_Score", value = "Probability", -delay_from_due_date)

colors_credit_score <- c("Good" = "blue", "Standard" = "#0dc757", "Poor" = "red")

plot <- ggplot(predicted_long, aes(x = delay_from_due_date, y = Probability, color = Credit_Score)) +
    geom_line() +
    labs(
        title = "Predictive Analysis of Delay from Due Date on Credit Score",
        x = "Delay from Due Date",
        y = "Predicted Probability",
        color = "Credit Score"
    ) +
    scale_color_manual(values = colors_credit_score)
ggsave("./ruhit_plots/predictive_analysis_credit_score_delay.png", plot = plot, width = 10, height = 6)
