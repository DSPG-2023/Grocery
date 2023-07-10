#' @author Alex Cory
#' @description Population of all the cities in the list
#' This will take some time to run
#' @param df_city_state
#' @return Population of all towns within region

Cities_Pop <- function(df_city_state) {
  cities_in_state <- get_decennial(year = 2020,
                        geography = "place",
                        variables = "DP1_0001C",
                        sumfile = "dp",
                        state = df_city_state$state)
  #String cleaning
  cities_in_state$NAME <- gsub( " city", "", as.character(cities_in_state$NAME))
  cities_in_state$NAME <- gsub( " CDP", "", as.character(cities_in_state$NAME))
  cities_in_state <- separate(data = cities_in_state, col = NAME,
                              into = c("City", "State"), sep = "; ")

  #Rename cities col to City and combine df
  names(city_county_state)[names(city_county_state)=="cities"] <- "City"
  df_cities_pop <- merge(cities_in_state, city_county_state, by='City')


  return(sum(df_cities_pop$value))
}
