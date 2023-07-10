#' @author Alex Cory
#' @description Returns the population of the city you are currently in
#' @param address the address we are interested in.

Metro_Pop <- function(address, df_city_pop) {


  splt_addr <- Address_Parser(address)
  df <- df_city_pop %>% filter(City == splt_addr[["city"]])
  return(df$value)
}
