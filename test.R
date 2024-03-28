library(tidyverse)
# library(dplyr)

filepath <- "./data/credit_score.csv"
df <- read.csv(filepath)
df1 <- read.csv(filepath, stringsAsFactors = TRUE)
attach(df)

View(df)

glimpse(df)

summary(df1)

unique(df$Total_EMI_per_month)
unique(df$Delay_from_due_date)
unique(df$Interest_Rate)
unique(df$Outstanding_Debt)

# lm(Left.Thalamus.Proper ~ Age)

glimpse(df$Interest_Rate)
