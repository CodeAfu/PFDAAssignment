library(tidyverse)

source("clean.R")
source("functions.R")

df <- read.csv("./data/credit_score.csv")
# df_strasfact <- read.csv("./data/credit_score.csv", stringsAsFactors = TRUE)

names(df) <- tolower(names(df))

df <- clean_df_chars(df)

df <- convert_chrtoint(df)
df <- convert_chrtodbl(df)

df <- clean_occupation(df)
df <- clean_num_bank_accounts(df)
df <- clean_num_credit_cards(df)
df <- clean_interest_rate(df)
df <- clean_delay_from_due_date(df)
df <- clean_num_of_delayed_payment(df)
df <- clean_num_credit_inquiries(df)
df <- clean_total_emi_per_month(df)
df <- clean_amount_invested_monthly(df)
df <- clean_changed_credit_limit(df)
df <- clean_num_of_loan(df)
df <- clean_montly_inhand_salary(df)

df <- convert_strtofact(df)

max       (df$outstanding_debt, na.rm = TRUE)
min       (df$outstanding_debt, na.rm = TRUE)
mean      (df$outstanding_debt, na.rm = TRUE)
median    (df$outstanding_debt, na.rm = TRUE)
get_mode  (df$outstanding_debt)
sum(is.na (df$outstanding_debt))
summary   (df$outstanding_debt)
table     (df$outstanding_debt)
unique    (df$outstanding_debt)
hist      (df$outstanding_debt)
class     (df$outstanding_debt)

write.csv(df, "./data/clean_credit_score.csv", row.names=FALSE)

levels(df$credit_score)


