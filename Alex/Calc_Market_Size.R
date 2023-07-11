#' Calculates Market Size
#'
#' @author Alex Cory
#'
#' @description
#' this function automatically calculates the market size for a given address value.
#'
#' @details
#' this function calls DSPGGrocery::Pop_Binder, DSPGGrocery::Cities_Pop, DSPGGrocery::Metro_Pop
#' and DSPGGrocery::Rural_Pop.
#'
#' @param address an address separated by commas containing street, city, and abbreviated state.
#' Example: "Main Street, Lamoni, IA"
#'
#' @returns
#' returns a list of atomic vectors containing city_population, metro_population,
#' and rural_population.
#'
#' @export

Calc_Market_Size <- function(address) {

  popbinder_list <- Pop_Binder(address = address)

  city_population <- Cities_Pop(df_city_state = popbinder_list$df_city_pop,
                                city_county_state = df_census_call_test)

  metro_population <- Metro_Pop(address, df_city_pop = popbinder_list$df_city_pop)

  rural_population <- Auto_Rural(popbinder_list$df_city_pop,
                                 geo_county = popbinder_list$county_name,
                                 df_geocode = df_geocode_test,
                                 df_grocery_only = df_grocery_only_test)

  MarketSizelist <- list(city_population = city_population,
                         metro_population = metro_population,
                         rural_population =  rural_population)

  return(MarketSizelist)
}
