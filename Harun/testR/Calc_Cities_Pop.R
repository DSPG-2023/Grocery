#' Calculates the Population of Cities by County Geography
#'
#' @author Harun Celik
#'
#' @description
#' This is a helper function for the DSPGrocery::Auto_Rural_Pop function which
#' calculates the total population of cities within a county that
#' intersect county geography. The call first pulls all cities in a provided state
#' and uses an sf::st_join to join based on county instersections.
#'
#' @details
#' The call uses data pulled from the United States Census Bureau with a call to
#' the tidycensus API, tidycensus::get_decennial.
#'
#' @param states_unique this is a vector of unique state FIPS codes inherited from
#' the df_buffer_loc parameter in DSPGrocery::Auto_Rural_Pop.
#' @param all_counties_pops this is the returned data frame inherited from the
#' call DSPGrocery::Calc_Counties_Pop.
#'
#' @returns the function returns a data frame called `all_cities_intersect` containing
#' county, city, city population, and sf geographies. The data frame is returned
#' with an attribute called "all_population" which is the sum of city populations.
#'
#' @seealso [Calc_Counties_Pop()]
#'
#' @export

Calc_Cities_Pop <- function(states_unique,
                            all_counties_pops) {
  all_cities_pops <- NULL


  for (index_state in 1:length(states_unique)) {
    cities_populations <- get_decennial(year = 2020,
                                        geography = "place",
                                        variables = "DP1_0001C",
                                        sumfile = "dp",
                                        state = states_unique[index_state],
                                        geometry = T)

    all_cities_pops <- rbind(all_cities_pops, cities_populations)
  }

  all_cities_intersect <- st_join(all_counties_pops,
                                  all_cities_pops,
                                  join = st_intersects) %>%
    transmute(counties = NAME.x,
              cities = NAME.y,
              cities_pop = value.y)

  attr(all_cities_intersect, "all_population") <- sum(all_cities_intersect$cities_pop)

  return(all_cities_intersect)
}
