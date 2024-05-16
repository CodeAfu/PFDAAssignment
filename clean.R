library(tidyverse)
library(mice)
library(stringr)

source('functions.R')

clean_df_chars <- function(df) {
  # output <- df %>%
  #   mutate(across(c(Occupation, Credit_Mix, Num_of_Delayed_Payment, Outstanding_Debt, 
  #                       Changed_Credit_Limit, Age), 
  #                 ~ str_replace_all(., "_", "")), 
  #          across(c(Delay_from_due_date, Num_of_Delayed_Payment, Age), 
  #                 ~ if_else(is.na(.), NA_character_, as.character(.)) %>%
  #                   str_replace_all("-", ""))) 

  output <- df %>%
    mutate(across(
      starts_with(c("annual_income", "occupation", "credit_mix", "num_of_delayed_payment", "outstanding_debt", "changed_credit_limit", "age")),
      ~ gsub("[-_]", "", .)
  ))

  return(output)
}

convert_chrtoint <- function(df) {
  output <- df %>%
    mutate(across(
      starts_with(c("age", "num_of_loan", "num_of_delayed_payment")),
      ~ {
        . <- ifelse(grepl("^(0|[1-9][0-9]*)$", .), ., NA)
        as.integer(.)
      }
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
      starts_with(c("annual_income", "changed_credit_limit", "outstanding_debt", "amount_invested_monthly", "monthly_balance")),
      ~ na_if(., as.character(!grepl("^(0|[1-9][0-9]*)$", .))) %>%
      as.double(.)
  ))
  return(output)
}

clean_num_bank_accounts <- function(df) {
  df$num_bank_accounts <- replace(df$num_bank_accounts, df$num_bank_accounts > 10, 10)
  df$num_bank_accounts <- replace(df$num_bank_accounts, df$num_bank_accounts < 0,  NA)
  return(df)
}

clean_num_credit_cards <- function(df) {
  df$num_credit_card <- replace(df$num_credit_card, df$num_credit_card > 11, 11)
  df$num_credit_card <- replace(df$num_credit_card, df$num_credit_card < 0, NA)
  return(df)
}

clean_interest_rate <- function(df) {
  df$interest_rate <- replace(df$interest_rate, df$interest_rate > 34, NA)
  df$interest_rate <- ifelse(is.na(df$interest_rate), 
                             as.integer(mean(df$interest_rate, na.rm = TRUE)),
                             df$interest_rate)
  return(df)
}

clean_delay_from_due_date <- function(df) {
  df$delay_from_due_date <- replace(df$delay_from_due_date, df$delay_from_due_date < 0, NA)
  # df$delay_from_due_date <- ifelse(is.na(df$delay_from_due_date),
                                  #  as.integer(median(df$delay_from_due_date, na.rm = TRUE)),
                                  #  df$delay_from_due_date) 
  return(df)
}

clean_num_of_delayed_payment <- function(df) {
  df$num_of_delayed_payment <- replace(df$num_of_delayed_payment, df$num_of_delayed_payment > 28, 28)
  df$num_of_delayed_payment <- ifelse(is.na(df$num_of_delayed_payment),
                                      get_mode(df$num_of_delayed_payment),
                                      df$num_of_delayed_payment)
  df$num_of_delayed_payment <- as.integer(df$num_of_delayed_payment)
  return(df)
}

clean_num_credit_inquiries <- function(df) {
  df$num_credit_inquiries <- replace(df$num_credit_inquiries, df$num_credit_inquiries > 17, 17)
  df$num_credit_inquiries <- ifelse(is.na(df$num_credit_inquiries),
                                      median(df$num_credit_inquiries),
                                      df$num_credit_inquiries)
  return(df)
}

clean_total_emi_per_month <- function(df) {
  df$total_emi_per_month <- replace(df$total_emi_per_month, df$total_emi_per_month > 600, 600)
  return(df)
}

clean_amount_invested_monthly <- function(df) {
  df$amount_invested_monthly <- replace(df$amount_invested_monthly, df$amount_invested_monthly > 1500, 1500)
  df$amount_invested_monthly <- replace(df$amount_invested_monthly, is.na(df$amount_invested_monthly) , 0)
  return(df)
}

clean_changed_credit_limit <- function(df) {
  df$changed_credit_limit <- ifelse(is.na(df$changed_credit_limit),
                                    median(df$changed_credit_limit, na.rm = TRUE),
                                    df$changed_credit_limit)
  return(df)
}

clean_num_of_loan <- function(df) {
  # Predictive Imputation
  relevant_features <- df %>% select(age, annual_income, monthly_inhand_salary, num_bank_accounts, num_credit_card, 
                                    interest_rate, delay_from_due_date, num_of_delayed_payment, changed_credit_limit, 
                                    num_credit_inquiries, outstanding_debt, credit_utilization_ratio, total_emi_per_month, 
                                    amount_invested_monthly, monthly_balance)

  df_for_imputation <- cbind(relevant_features, num_of_loan = df$num_of_loan)
  imputed_data <- mice(df_for_imputation, method = 'norm.predict', m = 1, maxit = 5, seed = 123)
  completed_data <- complete(imputed_data, 1)
  df$num_of_loan = as.integer(completed_data$num_of_loan)

  # Cleanup
  df$num_of_loan <- replace(df$num_of_loan, df$num_of_loan < 0, NA_integer_)
  df$num_of_loan <- replace(df$num_of_loan, df$num_of_loan > 9, 9)
  df$num_of_loan <- as.integer(df$num_of_loan)

  return(df)
}

clean_montly_inhand_salary <- function(df) {
  # Predictive Imputation
  relevant_features <- df %>% select(age, annual_income, num_bank_accounts, num_credit_card, 
                                    interest_rate, delay_from_due_date, num_of_delayed_payment, changed_credit_limit, 
                                    num_credit_inquiries, outstanding_debt, credit_utilization_ratio, total_emi_per_month, 
                                    amount_invested_monthly, monthly_balance)

  df_for_imputation <- cbind(relevant_features, monthly_inhand_salary = df$monthly_inhand_salary)
  imputed_data <- mice(df_for_imputation, method = 'norm.predict', m = 1, maxit = 5, seed = 123)
  completed_data <- complete(imputed_data, 1)
  df$monthly_inhand_salary = completed_data$monthly_inhand_salary

  df$monthly_inhand_salary <- replace(df$monthly_inhand_salary, df$monthly_inhand_salary < 0, 0)

  return(df)
}

convert_strtofact <- function(df) {
  df$credit_mix <- df$credit_mix %>%
    na_if(., "") %>%
    as.factor(.)

  df$occupation <- df$occupation %>%
    na_if(., "") %>%
    as.factor(.)

  df$payment_of_min_amount <- df$payment_of_min_amount %>%
    na_if(., "NM") %>%
    as.factor(.)

  df$payment_behaviour <- df$payment_behaviour %>%
    na_if(., "!@9#%8") %>%
    as.factor(.)

  return(df)
}

