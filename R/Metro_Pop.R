#' Finds the Population of the City the Store is in.
#'
#' @author Alex Cory
#'
#' @description Returns the population of the city you are currently in
#' @param address the address we are interested in.
#' @param df_city_pop dataframe with population of cities in county
#' @returns population of city the store is in.
#' @importFrom magrittr %>%
#' @importFrom stringr str_to_title
#'
#' @export

Metro_Pop <- function(address, df_city_pop) {
  splt_addr <- Address_Parser(address)
  splt_addr[["city"]] <- str_to_title(splt_addr[["city"]])
  df <- df_city_pop %>% filter(grepl(splt_addr[["city"]], City))
  return(df$value[1])
}
