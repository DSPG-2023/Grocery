#' Finds the Population of all the Cities in the Market Area
#' @author Alex Cory
#' @description Population of all the cities in the list
#' @details
#' Needs Tidycensus key
#'
#'
#' @param df_city_state df from Pop_Binder with cities and populations
#' @param city_county_state df with city county and state columns
#'
#' @importFrom tidyr separate
#' @return Population of all towns within region

Cities_Pop <- function(df_city_state, city_county_state) {
  #browser()
  cities_in_state <- get_decennial(year = 2020,
                        geography = "place",
                        variables = "DP1_0001C",
                        sumfile = "dp",
                        state = city_county_state$state)
  #String cleaning
  cities_in_state$NAME <- gsub( " city", "", as.character(cities_in_state$NAME))
  cities_in_state$NAME <- gsub( " CDP", "", as.character(cities_in_state$NAME))
  cities_in_state <- separate(data = cities_in_state, col = NAME,
                              into = c("City", "State"), sep = "; ")

  #Rename cities col to City and combine df
  names(city_county_state)[names(city_county_state)=="cities"] <- "City"
  df_cities_val <- merge(cities_in_state, city_county_state, by='City')


  return(sum(df_cities_val$value))
}
