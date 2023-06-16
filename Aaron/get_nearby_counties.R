
get_nearby_counties <- function(longitude, latitude, radius = 40233.6) {
  
  library(zipcodeR)
  library(geosphere)
  
  API_KEY <- Sys.getenv("GOOGLE_API_KEY")
  
  address <- revgeo::revgeo(longitude = longitude, latitude = latitude, 
                            provider = 'google', output = "frame",
                            API = API_KEY)
  
  
  state <- address$state
  
  state_ab <- state.abb[match(state,state.name)]
  
  zip <- address$zip
  
  reverse_zip <- zipcodeR::reverse_zipcode(zip)
  
  county <- reverse_zip$county[1]
  
  
  counties_df <- tidycensus::get_acs(
    geography = "county",
    variables = "B01003_001",
    state = state_ab,
    geometry = TRUE
  )
  
  county_centroids <- sf::st_centroid(counties_df)
  
  county_centroids_coords <- sf::st_coordinates(county_centroids$geometry)
  
  
  user_coords <- c(longitude, latitude)
  
  user_coords <- sf::st_point(user_coords)
  
  user_coords <-sf::st_coordinates(user_coords)
  
  distances <- distm(user_coords, county_centroids_coords, fun = distGeo)
  
  distances
  
  nearby_counties <- county_centroids[distances <= radius, ]
  
  nearby_counties$NAME
}

