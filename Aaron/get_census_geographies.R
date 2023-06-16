get_census_geos_3 <- function(longitude, latitude) {
  
  API_KEY <- Sys.getenv("GOOGLE_API_KEY")
  
  address <- revgeo::revgeo(longitude = longitude, latitude = latitude, 
                            provider = 'google', output = "frame",
                            API = API_KEY)
  
  
  state <- address$state
  
  state_ab <- state.abb[match(state,state.name)]
  
  zip <- address$zip
  
  reverse_zip <- zipcodeR::reverse_zipcode(zip)
  
  county <- reverse_zip$county[1]
  
  census <- tidycensus::get_decennial(
    geography = "block", 
    variables = "P2_001N",
    county = county,
    state = state_ab,
    year = 2020,
    geometry = TRUE)
  
  
  census
}

start_time <- Sys.time()

# call the function
get_census_geos_3(-93, 42)

# get the end time
end_time <- Sys.time()

# calculate the runtime
runtime <- end_time - start_time

print(runtime)

runtime = 10.3187

