#' Calculates the Population of Counties Given a Vector of Counties and States
#'
#' @author Harun Celik
#'
#' @description
#' This is a helper function for the DSPGrocery::Auto_Rural_Pop function which
#' calculates the total population of counties within states given a data frame
#' containing a vector of county names and state names.
#'
#' @details
#' The call uses data pulled from the United States Census Bureau with a call to
#' the tidycensus API, tidycensus::get_decennial.
#'
#' @param states_unique this is a vector of unique state FIPS codes inherited from
#' the df_buffer_loc parameter in DSPGrocery::Auto_Rural_Pop.
#'
#' @returns the function returns a data frame called `all_counties_pops` containing
#' county, county population, and sf geographies. The data frame is returned
#' with an attribute called "all_population" which is the sum of county populations.
#'
#' @seealso [Calc_Cities_Pop()]
#'
#' @export

Calc_Counties_Pop <- function(states_unique) {
  all_counties_pops <- NULL


  for (index_state in 1:length(states_unique)) {

    df_census_subset <- df_census_call %>%
      filter(state == states_unique[index_state])

    counties_unique <- unique(df_census_subset$counties)


    counties_populations <- get_decennial(year = 2020,
                                          geography = "county",
                                          variables = "DP1_0001C",
                                          sumfile = "dp",
                                          county = counties_unique,
                                          state = states_unique[index_state],
                                          geometry = T)

    all_counties_pops <- rbind(all_counties_pops, counties_populations)

    attr(all_counties_pops, "all_population") <- sum(all_counties_pops$value)
  }
  return(all_counties_pops)
}
