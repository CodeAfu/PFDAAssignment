
get_mode <- function(x) {
  x <- na.omit(x) # Remove NA values
  u <- unique(x)
  tab <- tabulate(match(x, u))
  u[tab == max(tab)]
}


interest_rate_labeller <- function(variable, value) {
  return(paste("Interest Rate:", value))
}