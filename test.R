library(tidyverse)
# library(dplyr)

filepath <- "./data/credit_score.csv"
df <- read.csv(filepath)
df1 = read.csv(filepath, stringsAsFactors = TRUE)
attach(df)

View(df)

glimpse(df)

head(df, 10)
tail(df)

summary(df)

class(df$Annual_Income)
unique(df$Total_EMI_per_month)
unique(df$Delay_from_due_date)
unique(df$Interest_Rate)
unique(df$Outstanding_Debt)

lm(Left.Thalamus.Proper ~ Age)

glimpse(df$Interest_Rate)
?read.csv()
