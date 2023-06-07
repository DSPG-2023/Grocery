#'Calculation for population of the cities in region.
#'
#'@param list user defined list of the population of towns
#'@return outputs sum of town populations
#'
#'@examples
#'CityPopulations(list)
#'@export



City_Populations <- function(list_in){
  return(Reduce('+', list_in))

}
