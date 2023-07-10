#' @author Alex Cory
#' @description Returns the population of the city you are currently in
#' @param address the address we are interested in.

Metro_Pop <- function(address) {


  splt_addr <- Address_Parser(address)
  df <- df %>% filter(City == splt_addr[["city"]])
  return(df$value)
}
