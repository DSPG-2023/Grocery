#' @author Alex Cory
#' @description Returns the population of the city you are currently in
#' @params address the address we are interested in.

Metro_Pop <- function(address) {
  #We should be saving address as a global variable so we don't have to pass it
  #as a parameter in most of my functions
  splt_addr <- Address_Parser(address)
  df %>% filter(City == splt_addr["city"])
  return(df$value)
}
