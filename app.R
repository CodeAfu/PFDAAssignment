install.packages("tidyverse")
install.packages("mice")
install.packages("ggplot2")

library(tidyverse)

source("clean.R")
source("functions.R")

df <- read.csv("./data/credit_score.csv")

names(df) <- tolower(names(df))

df <- clean_df_chars(df)

df <- convert_chrtoint(df)
df <- convert_chrtodbl(df)

df <- clean_occupation(df)
df <- clean_age(df)
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
df <- clean_monthly_inhand_salary(df)

df <- convert_strtofact(df)

max       (df$age, na.rm = TRUE)
min       (df$age, na.rm = TRUE)
mean      (df$age, na.rm = TRUE)
median    (df$age, na.rm = TRUE)
get_mode  (df$age)
sum(is.na (df$age))
summary   (df$age)
table     (df$age)
unique    (df$age)
# hist      (df$num_of_delayed_payment)
class     (df$num_of_delayed_payment)

summary(df)
write.csv(df, "./data/clean_credit_score.csv", row.names = FALSE)

