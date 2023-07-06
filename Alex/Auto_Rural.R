#'@author Alex Cory
#'@description
#'Determines population that does not live in a town or a city that would likely
#'shop at the proposed store
#'@param
#'
#'
#'@return Count of people who would shop at the store who do not live in a city



Auto_Rural <- function() {

  #Jay's function takes a two value dataframe with state and county.
  #Take the values from bound_df
  city_df <- data.frame(state = bound_df$State, county = bound_df$County)
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
  sum_val = 0

  #NEED COUNTY_POP TODO

  county_pop_df <- get_decennial(year = 2020,
                  geography = "county",
                  variables = "DP1_0001C",
                  sumfile = "dp",
                  state = bound_df$State)
  #String cleaning
  county_pop_df$NAME <- gsub( " County", "", as.character(county_pop_df$NAME))
  county_pop_df <- separate(data = county_pop_df, col = NAME, into = c("County", "State"), sep = ", ")
  county_pop_df <- county_pop_df %>% filter(county_pop_df$County == bound_df$County[1])
  county_pop <- county_pop_df$value

  pct_county <- Pct_County(north_val, east_val, south_val, west_val, 1500*.62137119)
  for(i in 1:nrow(bound_df)) {
    sum_val = sum_val + as.numeric(bound_df$value[i])
  }
  rural <- ((county_pop - sum_val) * pct_county)
  return(rural)
}



