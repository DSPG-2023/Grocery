#'Calculation for a shoppers from Primary secondary and rare categories in a Rural Market
#'
#'@param pop population in rural market, gotten from the Rural_Populations method
#'@param pct_primary,pct_secondary,pct_rare percentage of the county that is a primary,
#'secondary and rare shopper default taken as 30,50,20% unless specified otherwise
#'@return sets values for the number of primary, secondary, and rare shoppers
#'
#'@export



Rural_Shoppers_Count <- function(pct_primary=30, pct_secondary=50,pct_rare=20) {
  #Takes in pop (calculated by Rural_Population), and pct primary, secondary,and rare
  #as defined by the user
  pop<-Rural_Population()
  prim_count = pop * pct_primary
  secondary_count = pop * pct_secondary
  rare_count=pop*pct_rare

}
