#'
#' @returns The output returns the
#'
#' @importFrom googleway set_key,



library(googleway)
library(dplyr)
library(sf)
library(tidycensus)
library(tigris)

GetStoreMaps <- function(address = "23 Main St, Lake View, IA, United States, Iowa",
                         api_key = Sys.getenv("PLACES_KEY")) {

  # Set the key for the google API.
  set_key(key = api_key)


  # Parse given address



}
