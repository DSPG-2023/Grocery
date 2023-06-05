#'Calculation for a quarter circle.
#'
#'@param list user defined list of the population of towns
#'@return outputs sum of town populations
#'
#'@examples
#'CityPopulations(list)
#'@export



CityPopulations <- function(list){
  return(sum(unlist(lapply(list, length))))

  #TODO: Make function to find rural population by taking county population - city population
}
