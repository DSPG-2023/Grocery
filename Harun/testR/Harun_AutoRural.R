#' Finds the Rural Population of a Given Market Size

df_census_call <- readRDS(file = "Harun/nearest.RDS")

Auto_Rural_Pop <- function(df_census_call = df_census_call) {

  # Timer Start
  startTime <- Sys.time()

  # Take the names of all counties and state codes once

  states_unique <- as.integer(unique(df_census_call$state))

  # Get population for each county in state(s)
  source("Harun/testR/Calc_Counties_Pop.R")
  all_counties_pops <- Calc_Counties_Pop(states_unique = states_unique)

  # Get population for cities for each county
  source("Harun/testR/Cacl_Cities_Pop.R")
  all_cities_pops <- Calc_Cities_Pop(states_unique = states_unique)


  populations <<- list(all_counties_pops,
                      all_cities_pops)

  # Timer End
  EndTime <- Sys.time()

  # Total Time
  TotalTime <- EndTime - startTime

  # Return Completion Time
  return(cli_alert_info(sprintf("Run time: %.3f seconds", TotalTime)))
}
