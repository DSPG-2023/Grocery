#'Calculation for a quarter circle.
#'
#'@param list user defined list of the population of towns
#'@return outputs sum of town populations
#'
#'@examples
#'CityPopulations(list)
#'@export



City_Populations <- function(list){
  return(sum(unlist(lapply(list, length))))

}
