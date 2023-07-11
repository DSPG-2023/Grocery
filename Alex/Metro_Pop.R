#' @author Alex Cory
#' @description Returns the population of the city you are currently in
#' @param address the address we are interested in.
#' @param df_city_pop dataframe with population of cities in county
#' @return population of city the store is in.

Metro_Pop <- function(address, df_city_pop) {
  splt_addr <- Address_Parser(address)
  splt_addr[["city"]] <- str_to_title(splt_addr[["city"]])
  df <- df_city_pop %>% filter(City == splt_addr[["city"]])
  return(df$value)
}
