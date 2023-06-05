#'Calculates the average per capita spend adjusting the estimated price increase and state index
#'
#'@param state_index the ratio of the current price of the basket to the price of the basket during the base year
#'
#'@return
#'outputs the average per capita grocery spend after adjusting for the expected price increase and state index
#'
#'@examples
#'State_Adj_Capita_Grocery_Spend(99)
#'
#'@details
#'This function is taken from the Estimating_Revenue.xlsx and calculated in Step three. This function calls `Adj_Capita_Grocery_Spend()`.
#'
#'@export

State_Adj_Capita_Grocery_Spend<- function(state_index){
  Adj_Avg_Spend<-Adj_Capita_Grocery_Spend
  Adj_Avg_Spend*(state_index/100)
}
