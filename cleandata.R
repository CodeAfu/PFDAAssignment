library(tidyverse)

clean_dataframe <- function(df) {
  df %>%
    mutate(across(c(Occupation, Credit_Mix, Num_of_Delayed_Payment, Outstanding_Debt, Changed_Credit_Limit), 
                  ~ str_replace_all(., "_", "")), # Remove _ from all Columns
           across(c(Delay_from_due_date, Num_of_Delayed_Payment), 
                  ~ if_else(is.na(.), NA_character_, as.character(.)) %>%
                    str_replace_all("-", ""))) # Remove - from all columns, deal with resulting nulls
  
  # Deal with null values (INCOMPLETE)
  # df$Num_of_Delayed_Payment <- as.numeric(df$Num_of_Delayed_Payment)
}

clean_delay_from_due_date <- function(df) {

}

clean_interest_rate <- function(df) {
}

clean_outstanding_debt <- function(df) {
  df %>%
    mutate(Outstanding_Debt = str_replace(Outstanding_Debt, "_$", ""))

  df$Outstanding_Debt <- as.numeric(df$Outstanding_Debt)

  return(df)
}

clean_total_emi_per_month <- function(df) {

}

cust_df <- read.csv("./data/credit_score.csv")
cust_df_strasfact <- read.csv("./data/credit_score.csv", stringsAsFactors = TRUE)
# cust_df <- clean_dataframe(cust_df)
# View(cust_df)


names(cust_df)

df1 <- clean_delay_from_due_date(cust_df)
df2 <- clean_interest_rate(cust_df)
cust_df <- clean_outstanding_debt(cust_df)
df4 <- clean_total_emi_per_month(cust_df)

cust_df %>%
  filter(is.na(Outstanding_Debt)) %>%
  View()

glimpse(cust_df)

cust_df %>%
  filter(!complete.cases(.)) %>%
  View()
