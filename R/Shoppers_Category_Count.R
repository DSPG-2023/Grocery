#'Calculation for a shoppers from Primary secondary and rare categories in a Market
#'
#'@param pop population inside quadrants, gotten from the City_Populations method
#'@param pct_primary,pct_secondary percentage of the county that is a primary, secondary and rare shopper
#'@return sets values for the number of primary, secondary, and rare shoppers
#'
#'@export



Shoppers_Category_Count <- function(pct_primary, pct_secondary,pct_rare) {
  #Takes in pop (calculated by City_Populations), and pct primary and secondary
  #as defined by the user
  pop<-City_Populations()
  prim_count = pop * pct_primary
  secondary_count = pop * pct_secondary
  rare_count=pop*pct_rare

}
