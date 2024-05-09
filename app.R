library(tidyverse)

source("clean.R")

df <- read.csv("./data/credit_score.csv")
# df_strasfact <- read.csv("./data/credit_score.csv", stringsAsFactors = TRUE)

names(df) <- tolower(names(df))
df <- clean_df_chars(df)
df <- convert_chrtoint(df)
df <- clean_occupation(df)
df <- convert_chrtodbl(df)
df <- clean_num_bank_accounts(df)
df <- clean_num_credit_cards(df)
df <- clean_delay_from_due_date(df)
df <- clean_num_of_delayed_payment(df)
df <- clean_num_of_loan(df)
df <- convert_strtofact(df)

max     (df$monthly_balance, na.rm = TRUE)
min     (df$monthly_balance, na.rm = TRUE)
mean    (df$monthly_balance, na.rm = TRUE)
median  (df$monthly_balance, na.rm = TRUE)

table(df$num_of_delayed_payment)
unique(df$num_of_delayed_payment)

 
View(df)

write.csv(df, "./data/clean_credit_score.csv", row.names=FALSE)
