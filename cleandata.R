library(tidyverse)

clean_delay_from_due_date <- function() {

}

clean_interest_rate <- function() {

}

clean_outstanding_debt <- function() {

}

clean_total_emi_per_month <- function() {

}


df = read.csv("./data/credit_score.csv")
df_str_as_fact = read.csv("./data/credit_score.csv", stringsAsFactor = TRUE)
View(df)



# clean_delay_from_due_date()
# clean_interest_rate()
# clean_outstanding_debt()
# clean_total_emi_per_month()
