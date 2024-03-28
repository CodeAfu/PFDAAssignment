library(tidyverse)

credit_score <- read.csv(".\\data\\credit_score.csv")
attach(credit_score)

View(credit_score)

glimpse(credit_score)
class(credit_score$Payment_Behaviour)
unique(credit_score$Age)

lm(Left.Thalamus.Proper ~ Age)

