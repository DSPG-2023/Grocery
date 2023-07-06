#'Calculation for Population of Cities in Quarter Circle.
#'
#'@param list_in user defined list of the population of towns
#'@returns
#'
#'outputs sum of town populations
#'
#'@examples
#'City_Populations(list(77))
#'
#'@export


City_Populations <- function(list_in){
  return(Reduce('+', list_in))

}


