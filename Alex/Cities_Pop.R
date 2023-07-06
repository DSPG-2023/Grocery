#' @author Alex Cory
#' @description Population of all the cities in the list
#' This will take some time to run
#' @param df_city_state
#' @return Population of all towns within region

Cities_Pop <- function(df_city_state) {
  cities_pop_val = 0
  for(i in nrow(df_city_state)) {
    pop_val <- get_decennial(year = 2020,
                  geography = "place",
                  variables = "DP1_0001C",
                  sumfile = "dp",
                  state = df_city_state$State)

    #Update this with the name of the population column
    cities_pop_val = cities_pop_val + pop_val$value

    Sys.sleep(5)

  }
  return(cities_pop_val)


}
