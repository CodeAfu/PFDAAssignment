library(tidyverse)

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
# View(cust_df)

df1 <- clean_delay_from_due_date(cust_df)
df2 <- clean_interest_rate(cust_df)
df3 <- clean_outstanding_debt(cust_df)
df4 <- clean_total_emi_per_month(cust_df)


