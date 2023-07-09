#' Creates a Circle Buffer to the Furthest of Four Nearest Stores in a Quadrant
#'
#' @author Harun Celik
#'
#' @description
#' This function produces the data frames required for the spatial mapping and
#' census api calls in the DSPGrocery tool. See the returns section to check the
#' list of all objects.
#'
#' @details
#' The function makes use of the googleway and the tigris API. Only the googleway
#' API requires a key.
#'
#'
#' @param address a comma seperated address as a character.
#' @param api_key a google api key to be used as the key argument in googleway::set_key.
#' @param keyword a keyword argument used by the googleway::google_places api call.
#'
#' @returns The output returns the spatial features required to create the leaflet map.
#' the function returns a list called Store_Info which holds the objects
#' df_grocery_all, df_grocery_only, df_grocery_circle, buffer_point_origin,
#' store_points, furthest_point,buffer_circle, all_counties, grocery_counties_inter,
#' grocery_cities_inter
#'
#' @importFrom googleway set_key google_geocode google_places
#' @importFrom dplyr transmute select filter .data
#' @importFrom magrittr %>%
#' @importFrom sf st_as_sf st_buffer st_intersection st_distance st_join st_nearest_feature
#' @importFrom tigris counties places
#' @importFrom cli cli_h1 cli_h2 cli_alert_success cli_alert_info
#'
#' @export

Create_Circle_Buffer <- function(address, api_key, keyword) {

  # Timer Start
  startTime <- Sys.time()

  # Set Google API Key
  cli_h1("Setting up API Calls")
  set_key(key = api_key)
  cli_alert_success("Set API key successfully")


  cli_h2("Parsing Address")
  # Parse Address
  parsed_addr <- Address_Parser(address = address)
  cli_alert_success("Address parsed successfully")


  # STORE API CALLS
  ## Geocode Address
  cli_h2("Geocoding Address")
  df_geocode <- google_geocode(address = address) %>%
    .$results %>%
    .$geometry %>%
    .$location

  cli_alert_success("Address geocoded successfully")

  ## Call Google Places API & Convert Output to Retrieve State Information
  cli_h2("Pulling Store Information")
  df_grocery_all <- google_places(location = c(df_geocode$lat
                                               , df_geocode$lng),
                                  keyword = "grocery",
                                  rankby = "distance") %>%
    .$results %>%
    transmute(name,
              lat = .$geometry$location$lat,
              lng = .$geometry$location$lng,
              types,
              vicinity,
              state = strsplit(.$plus_code$compound_code, split = ", ")) %>%
    filter(state != "NANA") %>%
    mutate(state = sapply(.$state, "[[", 2))


  ## Reshape df_grocery_all$types to only keep the first store type
  for (item in 1:nrow(df_grocery_all)) {
    df_grocery_all$types[item] <- df_grocery_all$types[[item]][1]
  }

  ## Filter df_grocery_all for only grocery or supermarket stores
  df_grocery_only <- df_grocery_all %>%
    filter(types == "grocery_or_supermarket")
  cli_alert_success("Store information retrieved successfully")


  # SPATIAL OBJECT CREATION
  cli_h1("Creating Spatial Objects")
  ## Create df_grocery_circle, a dataframe of (up to four) closest store points
  cli_h2("Building Spatial Data")
  distance_comp_list <- Quadrant_Calculator(df_grocery_only = df_grocery_only,
                                            df_geocode = df_geocode)

  df_grocery_circle <- data.frame(distance_comp_list["df_circle_buffer"])
  # Remove repeated characters in column names
  colnames(df_grocery_circle) <- gsub("df_circle_buffer.", "", colnames(df_grocery_circle))
  # Find store with the furthest distance from the closest stores.
  df_grocery_circle <- df_grocery_circle %>%
    filter(distance_vector == max(distance_vector))
  cli_alert_success("Data frame of closest stores built successfully")

  ## Turn st objects into sf objects
  buffer_point_origin <- st_as_sf(df_geocode, coords = c("lng", "lat"), crs = "NAD83")
  store_points <- st_as_sf(df_grocery_all, coords = c("lng", "lat"), crs = "NAD83")
  furthest_point <- st_as_sf(df_grocery_circle, coords = c("lng", "lat"), crs = "NAD83")
  cli_alert_success("Data objects converted to spatial objects successfully")

  ## Buffer df_geocode point into a circle with a distance to furthest_point
  buffer_circle <- st_buffer(buffer_point_origin,
                             dist = as.integer(ceiling(st_distance(buffer_point_origin$geometry,
                                                                   furthest_point$geometry))))
  cli_alert_success("Location buffered successfully")



  # Pulling County and City Information
  cli_h1("Pulling County and City Information for State(s)")

  ## Pulling all county and city information from Tigris
  all_counties <- Pull_Counties(df_grocery_all = df_grocery_all,
                                state_list = unique(df_grocery_all$state))
  all_cities <- Pull_Cities(df_grocery_all = df_grocery_all,
                            state_list = unique(df_grocery_all$state))
  cli_alert_success("Pulled county and city information successfully")

  ## Intersecting buffer with Tigris files
  cli_h2("Intersecting buffer and place files")
  suppressWarnings(grocery_counties_inter <- st_intersection(all_counties, buffer_circle))
  suppressWarnings(grocery_cities_inter <- st_intersection(all_cities, buffer_circle))
  cli_alert_success("Intersected buffer and places successfully")

  ## Create the data frame for the census call
  df_census_call <- st_join(x = grocery_cities_inter,
                            y = all_counties, join = st_nearest_feature) %>%
    transmute(cities =  .$NAME.x,
              counties = .$NAME.y,
              state = .$STATEFP.x)



  # Store Outputs in a list
  Store_Info <- list(df_grocery_all = df_grocery_all,
                      df_grocery_only = df_grocery_only,
                      df_grocery_circle = df_grocery_circle,
                      buffer_point_origin = buffer_point_origin,
                      store_points = store_points,
                      furthest_point = furthest_point,
                      buffer_circle = buffer_circle,
                      all_counties = all_counties,
                      grocery_counties_inter = grocery_counties_inter,
                      grocery_cities_inter = grocery_cities_inter,
                      df_census_call = df_census_call)


  # Timer End
  EndTime <- Sys.time()

  # Total Time
  TotalTime <- EndTime - startTime
  cli_alert_info(sprintf("Run time: %.3f seconds", TotalTime))

  # Return Completion Time
  return(Store_Info)
}
