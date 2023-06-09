#'Calculation for population of the cities in region.
#'
#'@param list_in user defined list of the population of towns
#'@return outputs sum of town populations
#'
#'@examples
#'City_Populations(list(77))
#'@export



City_Populations <- function(list_in){
  return(Reduce('+', list_in))

}


