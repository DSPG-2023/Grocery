#'@author Alex Cory
#'@params store_address in a valid Google maps format (23 Main St, Lake View, IA, Unites States, Iowa)
#'@params pct_county the percentage of county in the range

Rural_Population<-function(store_address, pct_county) {
  #TODO: Calculate Pct_County automatically

  #Future steps - instead of using a list of towns in the county, we need a list
  #of towns in the polygon, and instead of a pct_county, we need a pct_county
  #of all of the counties its in. pct_county will need to be changed to
  #a list/dataframe of values


  #This function subtracts the sum of all the towns populations from the county
  #and multiplies it
  #by the percent of the county that the area covers to find the # of rural
  #people there are

  bound_df <<- Pop_Binder(store_address)

  #We get the populations of the tract in the county, we then remove the word
  #County and seperate the strings
  tract_pop <- get_decennial(year = 2020,
                geography = "tract",
                variables = "DP1_0001C",
                sumfile = "dp",
                state = "ia",
                county = bound_df$County)
  tract_pop$NAME <- gsub( " County", "", as.character(tract_pop$NAME))
  tract_pop <- separate(data = tract_pop, col = NAME, into = c("Tract", "County", "State"), sep = "; ")


  #Finds sum of population of all the tracts in the county
  #Doing it with a tract level census call and a loop to avoid having to pull
  #unnecessary data and filtering it down to be just the county we want
  #Increases run-time slightly but decreases time to pull and storage
  county_pop = 0
  for(i in 1:nrow(tract_pop)) {
    county_pop = county_pop + tract_pop$value[i]
  }

  #Finds the sum of all the cities in the county
  sum_val = 0
  for(i in 1:nrow(bound_df)) {
    sum_val = sum_val + as.numeric(bound_df$value[i])
  }
  rural <- floor((sum_val / county_pop) * pct_county)
  return(rural)
}
