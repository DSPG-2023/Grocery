#'Calculation for a quarter circle.
#'
#'@param pop population inside quadrants, gotten from the City_Populations method
#'@param pct_primary,pct_secondary percentage of the county that is a primary and secondary shopper
#'@return sets values for the number of primary and secondary shoppers
#'
#'@export



Primary_Secondary_Shoppers <- function(pop, pct_primary, pct_secondary) {
  #Takes in pop (calculated by City_Populations), and pct primary and secondary
  #as defined by the user
  prim_count = pop * pct_primary
  secondary_count = pop * pct_secondary

}
