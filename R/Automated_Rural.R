


Rural_Population<-function(county_pop, x, pct_county) {
  #This function subtracts the sum of all the towns populations from the county and multiplies it
  #by the percent of the county that the area covers to find the # of rural people there are

  city_in_county <- get_cities_in_county(city_df[1,])
  county_cities_list <- stringr::str_split(city_in_county$city_list, ", ")

  #This gives us the name of city and the population. We need to separate city
  #and state name, and then remove the city and CDP from the NAME so we can join
  #with the county_cities_list

  place_pop <- get_decennial(year = 2020,
                             geography = "place",
                             variables = "DP1_0001C",
                             sumfile = "dp",
                             state = 19)
  place_pop$NAME <- gsub( " city", "", as.character(place_pop$NAME))
  place_pop$NAME <- gsub( " CDP", "", as.character(place_pop$NAME))
  place_pop <- separate(data = place_pop, col = NAME, into = c("City", "State"), sep = ";")
  place_pop


  #Convert County cities list to a data frame in the correct shape and name
  #to join with place_pop
  county_cities_df <- data.frame(unlist(county_cities_list))
  lookup <- c(City = "unlist.county_cities_list.")
  county_cities_df <- rename(county_cities_df, all_of(lookup))

  bound_df <- merge(county_cities_df, place_pop, by='City')
  sum_val = 0
  print(sum_val)
  for(i in 1:nrow(bound_df)) {
    sum_val = sum_val + as.numeric(bound_df$value[i])
  }
  print(sum_val)
}
