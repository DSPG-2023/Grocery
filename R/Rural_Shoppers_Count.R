#' Calculates Count of Rare Shoppers for a Rural Market
#'
#' @param pct_primary percentage of the county that is a primary shopper defaulted
#' to 30%.
#' @param pct_secondary percentage of the county that is a secondary shopper defaulted
#' to 50%.
#' @param pct_rare percentage of the county that is a rare shopper defaulted
#' to 20%.
#'
#' @returns number of shoppers rural shoppers based on the number of primary,
#' secondary, and rare shoppers
#'
#' @export



Rural_Shoppers_Count <- function(pct_primary=30, pct_secondary=50, pct_rare=20) {
  #Takes in pop (calculated by Rural_Population), and pct primary, secondary,and rare
  #as defined by the user
  pop <- Rural_Population()
  prim_count = pop * pct_primary
  secondary_count = pop * pct_secondary
  rare_count=pop*pct_rare

}
