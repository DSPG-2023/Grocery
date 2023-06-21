#' Calculates Distance Using the Google Distance API
#'
#' @description The function uses the Google GeoCode, Places, and Distance Matrix APIs to provide distances to grocery and dollar stores after being provided with an address.
#'
#' @importFrom googleway set_key, google_geocode

GoogleGroceryDistance <- function(address = "23 Main St, Lake View, IA, United States, Iowa",
                                  api_key = Sys.getenv("PLACES_KEY")) {

  # Set API key
  set_key(key = api_key)


  # Formatting the Geocode API output to return a latitude and longitude
  df_geocode <- google_geocode(address = address) %>%
    .$results %>%
    .$geometry %>%
    .$location

  Sys.sleep(2)

  # Formatting the Places API to return a dataframe of locations
  ## For grocery stores
  df_places_grocery <- google_places(search_string = "grocery",
                                     place_type = "store",
                                     location = c(df_geocode$lat, df_geocode$lng)) %>%
    .$results

  Sys.sleep(2)

  ## For dollar stores
  df_places_dollar <- google_places(search_string = "dollar",
                                    place_type = "store",
                                    location = c(df_geocode$lat, df_geocode$lng)) %>%
    .$results


  Sys.sleep(2)

  # Bind the output of the Places API
  df_places_binded <- bind_rows(df_places_grocery, df_places_dollar)


  # Convert `df_places_binded` to include only lat/lng values
  Spatial_places <- df_places_binded %>%
    transmute(lat = geometry$location$lat, lon = geometry$location$lng) %>%
    slice(1:25)

  Sys.sleep(2)

  # This currently takes the first 25 rows of the data frame since the distance API
  # can only calculate that much with our license



  #Format the Places API data frames to output distance calculations
  df_distances <- google_distance(origins = "23 Main St, Lake View, IA, United States, Iowa",
                                  destinations = Spatial_places, mode = "driving") %>%
    .$rows %>%
    .$elements %>%
    .[[1]] %>%
    as.data.frame()


  # SHOULD RETURN A DATAFRAME
  return(df_distances)

}
