#' Creating a Dataframe from an Address
#'
#' @author Alex Cory
#'
#' @param address the address must be in the standard Google maps form
#'
#' @description
#' Function that takes in an address and returns a dataframe with cities in the
#' county and their populations in a tidy format.
#'
#' @details
#' Makes a TidyCensus and Google Places API call, needs key
#'
#'
#' @importFrom dplyr rename
#' @importFrom ggmap geocode
#' @importFrom stringr str_split
#' @import magrittr %>%
#' @importFrom tidyr separate
#' @example Pop_Binder("223 S Main St, Lake View, IA, Unites States, Iowa")
#' @export

library(stringr)
library(ggmap)
library(tidyr)
ggmap::register_google(key = Sys.getenv("PLACES_KEY"))


Pop_Binder <- function(address) {

  #Parses Address, returns as df with street address, city, and state
  splt_addr <- Address_Parser(address)
  geocoded_address <- geocode(location = address, output = "all")
  geo_county <- geocoded_address[["results"]][[1]][["address_components"]][[2]][["long_name"]]
  geo_county <- gsub( " County", "", as.character(geo_county))

  #Makes new dataframe with the parsed address's information + the county tag
  city_df <- data.frame(state = splt_addr$state,
                        county = geo_county,
                        city = splt_addr$city[1])

  #Makes a list of all the cities in the county
  city_in_county <- Get_Cities_in_County(city_df[1,])
  county_cities_list <- stringr::str_split(city_in_county$city_list, ", ")

  #This gives us the name of city and the population. We need to separate city
  #and state name, and then remove the city and CDP from the NAME so we can join
  #with the county_cities_list
  county_pop <- get_decennial(year = 2020,
                              geography = "county",
                              variables = "DP1_0001C",
                              sumfile = "dp",
                              county = city_in_county["county"],
                              state = city_in_county["state"])

  place_pop <- get_decennial(year = 2020,
                             geography = "place",
                             variables = "DP1_0001C",
                             sumfile = "dp",
                             state = city_in_county[1])
  place_pop$NAME <- gsub( " city", "", as.character(place_pop$NAME))
  place_pop$NAME <- gsub( " CDP", "", as.character(place_pop$NAME))
  place_pop <- separate(data = place_pop, col = NAME, into = c("City", "State"), sep = ";")

  #Convert County cities list to a data frame in the correct shape and name
  #to join with place_pop
  county_cities_df <- data.frame(unlist(county_cities_list))
  lookup <- c(City = "unlist.county_cities_list.")
  county_cities_df <- rename(county_cities_df, all_of(lookup))

  df_city_pop <- merge(county_cities_df, place_pop, by='City')
  df_city_pop %>% cbind(County = geo_county)

  county_pop <- county_pop["value"]

  PopulationsList <- list(df_city_pop = df_city_pop,
                          county_pop = county_pop,
                          county_name = geo_county)

  return(PopulationsList)
}
