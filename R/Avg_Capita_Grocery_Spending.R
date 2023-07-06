#' Calculates Average Grocery Spending per Capita.
#'
#' @param grocery_sales Total US grocery sales annually. Default value is 811541000000.
#' @param population Total US population. Default value is 334233854.
#'
#' @returns Outputs average grocery spending per capita.
#'
#' @examples
#' Avg_Capita_Grocery_Spending(grocery_sales = 811541000000, population = 334233854)
#'
#' @details
#' This function is taken from the Estimating_Revenue.xlsx and calculated in Step One.
#'
#' @export

Avg_Capita_Grocery_Spending <- function(grocery_sales = 811541000000, population = 334233854) {
  grocery_sales / population
}
