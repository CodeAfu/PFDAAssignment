library(tidyverse)
library(stringr)


clean_df_chrs <- function(df) {
  # output <- df %>%
  #   mutate(across(c(Occupation, Credit_Mix, Num_of_Delayed_Payment, Outstanding_Debt, 
  #                       Changed_Credit_Limit, Age), 
  #                 ~ str_replace_all(., "_", "")), 
  #          across(c(Delay_from_due_date, Num_of_Delayed_Payment, Age), 
  #                 ~ if_else(is.na(.), NA_character_, as.character(.)) %>%
  #                   str_replace_all("-", ""))) 

  output <- df %>%
    mutate(across(
      starts_with(c("occupation", "credit_mix", "num_of_delayed_payment", "outstanding_debt", "changed_credit_limit", "age")),
      ~ gsub("[-_]", "", .)
  ))

  return(output)
}

convert_chrtoint <- function(df) {
  output <- df %>%
  mutate(across(
    starts_with(c("age", "num_of_loan", "num_of_delayed_payment")),
    ~ na_if(., as.character(!grepl("^(0|[1-9][0-9]*)$", .))) %>%
    as.integer
  ))
  return(output)
}

clean_occupation <- function(df) {
  output <- df %>%
    mutate(occupation = ifelse(occupation == "_______", NA, occupation))
  
  return(output)
}

convert_chrtodbl <- function(df) {
  output <- df %>%
    mutate(across(
      starts_with(c("changed_credit_limit", "outstanding_debt", "amount_invested_monthly", "monthly_balance")),
      ~ na_if(., as.character(!grepl("^(0|[1-9][0-9]*)$", .))) %>%
      as.double
  ))
  return(output)
}

clean_num_bank_accounts <- function(df) {
  df$num_bank_accounts <- replace(df$num_bank_accounts, df$num_bank_accounts > 10, 10)
  df$num_bank_accounts <- replace(df$num_bank_accounts, df$num_bank_accounts < 0,  0)
  return(df)
}

clean_num_credit_cards <- function(df) {
  df$num_credit_card <- replace(df$num_credit_card, df$num_credit_card > 11, 11)
  return(df)
}

clean_delay_from_due_date <- function(df) {
  df$delay_from_due_date <- replace(df$delay_from_due_date, df$delay_from_due_date < 0, 0)
  return(df)
}

convert_strtofact <- function(df) {
  df$credit_mix <- df$credit_mix %>%
    na_if(., "") %>%
    as.factor

  df$occupation <- df$occupation %>%
    na_if(., "") %>%
    as.factor

  df$payment_of_min_amount <- df$payment_of_min_amount %>%
    na_if(., "NM") %>%
    as.factor

  df$payment_behaviour <- df$payment_behaviour %>%
    na_if(., "!@9#%8") %>%
    as.factor

  return(df)
}



clean_interest_rate <- function(df) {
}

clean_outstanding_debt <- function(df) {
  df %>%
    mutate(outstanding_debt = str_replace(outstanding_debt, "_$", ""))

  df$outstanding_debt <- as.numeric(df$outstanding_debt)

  return(df)
}

clean_total_emi_per_month <- function(df) {

}

