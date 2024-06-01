
# pair_plot <- function() {
#   plot <- ggpairs(df, columns = c("outstanding_debt", "credit_score", "monthly_inhand_salary", "num_bank_accounts", "num_credit_card", "interest_rate"), aes(color = credit_score, alpha = 0.5))
  
#   ggsave("./plots/outstanding_debt/pair_plot.png", plot = plot, width = 30, height = 30)
# }

# pair_plot()


# interaction_plot <- function() {
#   # Fit a multinomial logistic regression model with interaction term
#   model <- multinom(credit_score ~ outstanding_debt * interest_rate, data = df)
  
#   # Create a new data frame for predictions
#   new_data <- expand.grid(outstanding_debt = seq(min(df$outstanding_debt), max(df$outstanding_debt), length.out = 100),
#                           interest_rate = seq(1, 34, length.out = 10)) # Interest rate ranges from 1 to 34
  
#   # Predict probabilities for each combination of outstanding_debt and interest_rate
#   predicted <- predict(model, newdata = new_data, type = "probs")
#   predicted <- as.data.frame(predicted)
#   predicted$Outstanding_Debt <- new_data$outstanding_debt
#   predicted$Interest_Rate <- new_data$interest_rate
  
#   # Reshape the data for plotting
#   predicted_long <- gather(predicted, key = "Credit_Score", value = "Probability", -Outstanding_Debt, -Interest_Rate)
  
#   # Create the interaction plot
#   plot <- ggplot(predicted_long, aes(x = Outstanding_Debt, y = Probability, color = Credit_Score)) +
#     geom_line() +
#     facet_wrap(~ Interest_Rate, scales = "free_y", ncol = 2) +
#     labs(title = "Interaction Plot of Outstanding Debt and Interest Rate on Credit Score",
#          x = "Outstanding Debt",
#          y = "Predicted Probability",
#          color = "Credit Score") +
#     scale_color_manual(values = colors_credit_score)
  
#   ggsave("./plots/outstanding_debt/interaction_plot.png", plot = plot, width = 16, height = 10)
# }