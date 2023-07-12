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
#' @param df_census_call a data frame containing city, county, and state values inherited from
#' DSPGrocery::Create_Circle_Buffer.
#' @param df_geocode a data frame containing the lng and lat value of the geocoded address
#' inherited from DSPGrocery::Create_Circle_Buffer.
#' @param df_grocery_only a data frame containing the values returned froma a call to
#' googleway::google_places filtered for stores with the type set to "grocery". Also
#' inherited from DSPGrocery::Create_Circle_Buffer.
#'
#' @importFrom ggmap register_google
#'
#' @returns
#' returns a list of atomic vectors containing city_population, metro_population,
#' and rural_population.
#'
#' @export

Calc_Market_Size <- function(address, df_census_call, df_geocode, df_grocery_only) {

  register_google(key = Sys.getenv("PLACES_KEY"))

  popbinder_list <- Pop_Binder(address = address)

  city_population <- Cities_Pop(df_city_state = popbinder_list$df_city_pop,
                                city_county_state = df_census_call)

  metro_population <- Metro_Pop(address, df_city_pop = popbinder_list$df_city_pop)

  rural_population <- Rural_Pop(geo_county = popbinder_list$county_name,
                                df_geocode = df_geocode,
                                df_grocery_only = df_grocery_only,
                                df_city_pop = popbinder_list$df_city_pop,
                                popbinder = popbinder_list)

  MarketSizelist <- list(city_population = city_population,
                         metro_population = metro_population,
                         rural_population =  rural_population)

  return(MarketSizelist)
}
