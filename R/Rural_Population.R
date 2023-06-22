#'Calculation for a quarter circle.
#'
#'@param county_pop the population of the whole county
#'@param county the name of the county (?)
#'@param pct_county the percent of the county in the area
#'@return outputs the rural population
#'@examples
#'Rural_Population(18000,"sac",17.7)
#'@export



Rural_Population<-function(county_pop, x, pct_county) {
  #This function subtracts the sum of all the towns populations from the county and multiplies it
  #by the percent of the county that the area covers to find the # of rural people there are

  city_in_county <- get_cities_in_county(city_df[1,])
  county_cities_list <- stringr::str_split(city_in_county$city_list, ", ")
  sum = 0
  for(i in length(county_cities_list)) {
    sum = sum + tidycensus::get_decennial(county_cities_list[i], city_df$state)
  }

  return(floor((county_pop - sum(tidycensus::get_decennial(get_cities_in_county(county)))*pct_county/100)))







}
