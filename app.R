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
df <- clean_interest_rate(df)
df <- clean_delay_from_due_date(df)
df <- clean_num_of_delayed_payment(df)
df <- clean_num_credit_inquiries(df)
df <- clean_total_emi_per_month(df)
df <- clean_amount_invested_monthly(df)
df <- clean_num_of_loan(df)
df <- convert_strtofact(df)

max     (df$monthly_balance, na.rm = TRUE)
min     (df$monthly_balance, na.rm = TRUE)
mean    (df$monthly_balance, na.rm = TRUE)
median  (df$monthly_balance, na.rm = TRUE)

sum(is.na (df$monthly_balance))
summary   (df$monthly_balance)
table     (df$monthly_balance)
unique    (df$monthly_balance)

hist(df$monthly_balance)

# total_emi = 600

View(df)

write.csv(df, "./data/clean_credit_score.csv", row.names=FALSE)
