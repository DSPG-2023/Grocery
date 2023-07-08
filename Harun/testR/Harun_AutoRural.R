#' Calculates the Rural Population for a Given Market Size
#'
#' @author Harun Celik
#'
#' @description
#' This is a helper function for DSPGrocery::[FILL THIS LATER] to calculate the
#' rural population for the buffered geographic area using
#' DSPGrocery::Create_Circle_Buffer.The calculation for this is the difference between all county
#' populations and city populations in those counties multiplied by the percentage
#' of area that the buffer covers in intersecting counties.
#'
#' @details
#' This function calls DSPGrocery::Calc_Cities_Pop and
#' DSPGrocery::Calc_Cities_Pop
#'
#'
#' @param df_buffer_loc a data frame containing the city, county and state
#' locations of a buffered point.Inherited from the returned `df_census_call`
#' data frame returned in the call DSPGrocery::Create_Circle_Buffer.
#'
#'
#' @returns the function returns an estimated number for the rural population in
#' the calculated market size.
#'
#' @export

df_census_call <- readRDS(file = "Harun/city_county_state_nearest.RDS")

Auto_Rural_Pop <- function(df_buffer_loc = df_census_call) {


  # Timer Start
  startTime <- Sys.time()

  # Take the names of all counties and state codes once

  states_unique <- as.integer(unique(df_buffer_loc$state))

  # Get population for each county in state(s)
  source("Harun/testR/Calc_Counties_Pop.R")
  all_counties_pops <- Calc_Counties_Pop(states_unique = states_unique)

  # Get population for cities for each county
  source("Harun/testR/Calc_Cities_Pop.R")
  all_cities_pops <- Calc_Cities_Pop(states_unique = states_unique,
                                     all_counties_pops = all_counties_pops)


  populations <<- list(cities_total = attributes(all_cities_pops)$all_population,
                   counties_total = attributes(all_counties_pops)$all_population)

  # Timer End
  EndTime <- Sys.time()

  # Total Time
  TotalTime <- EndTime - startTime

  # Return Completion Time
  return(cli_alert_info(sprintf("Run time: %.3f seconds", TotalTime)))
}
