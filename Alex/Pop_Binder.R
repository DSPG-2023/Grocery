#'@author Alex Cory
#'@params address the address must be in the standard Google maps form
#'@description
#'Function that takes in an address and returns a dataframe with data on county
#'cities and populations
#'
#'@example Pop_Binder("223 S Main St, Lake View, IA, Unites States, Iowa")

library(stringr)
library(ggmap)
library(tidyr)
ggmap::register_google(key = Sys.getenv("PLACES_KEY"))


Pop_Binder <- function(address) {

  #Doing this because I want to use this variable in Metro_Pop
  splt_addr <- Address_Parser(address)


  geocoded_address <- geocode(location = address, output = "all")
  geo_county <- geocoded_address[["results"]][[1]][["address_components"]][[4]][["long_name"]]
  geo_county <- gsub( " County", "", as.character(geo_county))

  city_df <- data.frame(state = splt_addr[5], county = geo_county, city = splt_addr[2])


  #city_df <- data.frame(state = "Iowa", county = "Sac")
  city_in_county <- get_cities_in_county(city_df[1,])
  county_cities_list <- stringr::str_split(city_in_county$city_list, ", ")

  #This gives us the name of city and the population. We need to separate city
  #and state name, and then remove the city and CDP from the NAME so we can join
  #with the county_cities_list

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

  bound_df <- merge(county_cities_df, place_pop, by='City')
  cbind(bound_df, County = geo_county)

}
