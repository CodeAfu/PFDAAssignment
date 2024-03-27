library(tidyverse)

credit_score <- read.csv(".\\data\\credit_score.csv")
attach(credit_score)

View(credit_score)

glimpse(credit_score)
class(credit_score$Annual_Income)
unique(credit_score$Total_EMI_per_month)
unique(credit_score$Delay_from_due_date)
unique(credit_score$Interest_Rate)
unique(credit_score$Outstanding_Debt)

lm(Left.Thalamus.Proper ~ Age)

