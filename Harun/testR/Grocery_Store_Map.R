#' @author Harun Celik
#' Returns Store Locations as Spatial Data for Mapping
#'
#' @param address a comma seperated character address.
#' @param api_key a google api key so be used as the key argument in googleway::set_key.
#' @param keyword a keyword argument used by the googleway::google_places api call.
#'
#' @importFrom googleway set_key, google_geocode, google_places
#' @importFrom dplyr %>%, transmute, select
#' @importFrom sf st_as_sf, st_union, st_convex_hull, st_intersection, st_crs
#' @importFrom tigris counties
#' @importFrom tidycensus get_decennial
#'
#' @returns The output returns the spatial features required for the leaflet map.
#' the function returns a list called StoreInfo which holds the objects parsed_addr,
#' df_grocery, grocery_points, grocery_hull, all_state_counties, all_state_cities,
#' grocery_cities_inter, grocery_counties_inter



library(googleway)
library(dplyr)
library(sf)
library(tidycensus)
library(tigris)
library(DSPGGrocery)

Grocery_Store_Map <- function(address = "23 Main St, Lake View, IA, United States, Iowa",
                         api_key = Sys.getenv("PLACES_KEY"),
                         keyword = "grocery") {

  # Start timer
  startTime <- Sys.time()

  # Set the key for the google API.
  set_key(key = api_key)


  # Parse given address
  parsed_addr <- Address_Parser(address = address)



  # Pull city and county data
  ## Pull in decennial city information for state
  all_state_cities <- ia_towns <- get_decennial(geography = "place",
                                                state = parsed_addr$state,
                                                variables  = "DP1_0001C",
                                                sumfile = "dp",
                                                output = "wide",
                                                geometry = TRUE,
                                                cb=FALSE,
                                                keep_geo_vars = TRUE)


  ## Pull in state county information
  all_state_counties <- counties(state =  parsed_addr$state)




  # Google API calls
  ## Geocode address (return lat/lng of address)
  df_geocode <- google_geocode(address = address) %>%
    .$results %>%
    .$geometry %>%
    .$location

  ## Pull the nearest grocery stores of the given address and simplify data frame
  df_grocery <- google_places(location = c(df_geocode$lat
                                           , df_geocode$lng),
                              keyword = keyword,
                              rankby = "distance") %>%
    .$results %>%
    transmute(name,
              lat = .$geometry$location$lat,
              lng = .$geometry$location$lng,
              types,
              vicinity)



  # Turn df_grocery into two spatial objects
  ## Making POINT spatial data from data frame
  grocery_points <- st_as_sf(df_grocery,
                                coords = c("lng", "lat"),
                                crs = 4326)


  ## Making Convex Hull from data frame
  grocery_hull <- df_grocery %>%
    select(lng, lat) %>%
    st_as_sf(coords = c("lng", "lat"), crs = st_crs(all_state_counties)) %>%
    st_union() %>%
    st_convex_hull()





  # Determining polygon intersections
  ## Hull and County intersection
  grocery_counties_inter <- st_intersection(all_state_counties, grocery_hull)


  ## Hull and Cities intersection
  grocery_cities_inter <-st_intersection(all_state_cities, grocery_hull)



  # Put all return items in the list of StoreInfo
  StoreInfo <<- list(parsed_addr = parsed_addr,
                    df_grocery = df_grocery,
                    grocery_points = grocery_points,
                    grocery_hull = grocery_hull,
                    all_state_counties = all_state_counties,
                    all_state_cities = all_state_cities,
                    grocery_cities_inter = grocery_cities_inter,
                    grocery_counties_inter = grocery_counties_inter)



  # End timer
  EndTime <- Sys.time()
  TotalTime <- EndTime - startTime

  # Return Completion Time
  return(print(sprintf("Run time: %.3f seconds", TotalTime)))

}
