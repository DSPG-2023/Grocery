#'Calculation for a quarter circle.
#'
#'@param county_pop the population of the whole county
#'@param towns_pop the sum of all the towns populations in the county
#'@param pct_county the percent of the county in the area
#'@return outputs the rural population
#'
#'@export



Rural_Population<-function(county_pop, towns_pop, pct_county) {
  #This function subtracts the sum of all the towns populations from the county and multiplies it
  #by the percent of the county that the area covers to find the # of rural people there are
  return((county_pop - towns_pop)*pct_county)
}
