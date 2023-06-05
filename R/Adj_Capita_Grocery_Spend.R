#'Calculates the average per capita spend adjusting the estimated price increase
#'
#'@param est_per_price_increase Estimated increase in price of grocery in cumulative percent.
#'
#'@return
#'Outputs the average per capita grocery spend after adjusting for the expected price increase.
#'@examples
#'Adjusted_capita_grocery_spend(7)
#'@details
#'This function is taken from the Estimating_Revenue.xlsx and calculated in Step two. This function calls `Avg_Capita_Grocery_Spending()`.
#'
#'@export
#'
Adj_Capita_Grocery_Spend <- function(est_per_price_increase){
  Avg_Spend <- Avg_Capita_Grocery_Spending()
  Avg_Spend * (1+(estimated_cumulative_price_increase/100))
}
