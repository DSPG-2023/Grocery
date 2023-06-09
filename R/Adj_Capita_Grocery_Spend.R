#' Calculates Average Per Capita Spending Adjusted by Estimated Price Increase
#'
#'@author Srika Raja
#'
#'@description
#' This function returns the average per capita spending after adjusting for
#' percentage price increase from the base year(2022).
#'
#' @param est_per_price_increase Estimated increase in price of grocery in
#' cumulative percent default taken as 7 for 2023
#' @param grocery_sales Total US grocery sales annually. Default value is 811541000000.
#' @param population Total US population. Default value is 334233854.
#'
#' @returns
#' Outputs the average per capita grocery spend after adjusting for the expected price increase.
#' @examples
#' Adj_Capita_Grocery_Spend()
#'
#' @details
#' This function is taken from the Estimating_Revenue.xlsx and calculated in Step two.
#' This function calls Avg_Capita_Grocery_Spending().
#'
#' @export


Adj_Capita_Grocery_Spend <- function(est_per_price_increase=7,
                                     grocery_sales = 811541000000,
                                     population = 334233854) {
  Avg_Spend <- Avg_Capita_Grocery_Spending(grocery_sales,population)
  Avg_Spend * (1+(est_per_price_increase/100))
}
