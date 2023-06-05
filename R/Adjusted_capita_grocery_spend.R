#Calculates the average per capita spend adjusting the estimated price increase
#'
#'@param estimated_cumulative_price_increase Estimated increase in price of grocery.
#'
#'@return
#'Outputs the average per capita grocery spend after adjusting for the expected price increase.
#'@examples
#'Adjusted_capita_grocery_spend(2428.06,7)
#'@details
#'This function is taken from the Estimating_Revenue.xlsx and calculated in Step two
#'
#'@export
#'
Adjusted_capita_grocery_spend<- function(estimated_cumulative_price_increase){
  Avg_Capita_Grocery_Spending* (1+(estimated_cumulative_price_increase/100))
  }
