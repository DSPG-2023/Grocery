get_census_geos_2 <- function(longitude, latitude) {
  
  API_KEY <- Sys.getenv("GOOGLE_API_KEY")
  
  address <- revgeo::revgeo(longitude = longitude, latitude = latitude, 
                            provider = 'google', output = "frame",
                            API = API_KEY)
  
  state <- address$state
  
  state_ab <- state.abb[match(state,state.name)]
  
  zip <- address$zip
  
  tracts <- zipcodeR::get_tracts(zip)
  
  tracts

}

start_time <- Sys.time()

# call the function
get_census_geos_2(-93, 42)

# get the end time
end_time <- Sys.time()

# calculate the runtime
runtime <- end_time - start_time

print(runtime)

runtime = 0.2152741




  
  
  
  