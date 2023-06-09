#' Calculates Average per Capita Spending Adjusted by Estimated Price Increase and State Index
#'
#' @author Srika Raja
#'
#' @description
#' This function returns the average per capita spending after adjusting for
#' percentage price increase and rural price parities from the base year(2022).
#'
#' @param state_index the ratio of the current price of the basket to the price of the
#'  basket during the base year
#' @param est_per_price_increase Estimated increase in price of grocery in cumulative percent
#' default taken as 7 for 2023.
#' @param grocery_sales Total US grocery sales annually. Default value is 811541000000.
#' @param population Total US population. Default value is 334233854.
#'
#' @returns Outputs the average per capita grocery spend after adjusting for the expected
#' price increase and state index
#'
#' @examples
#' State_Adj_Capita_Grocery_Spend(99,7)
#'
#' @details
#' This function is taken from the Estimating_Revenue.xlsx and calculated in Step three.
#' This function calls `Adj_Capita_Grocery_Spend()`.
#'
#' @export

State_Adj_Capita_Grocery_Spend<- function(state_index,est_per_price_increase=7,
                                          grocery_sales = 811541000000,
                                          population = 334233854){
  Adj_Avg_Spend<-Adj_Capita_Grocery_Spend(est_per_price_increase,grocery_sales, population)
  floor(Adj_Avg_Spend*(state_index/100))
}

