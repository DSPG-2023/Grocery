#' Calculates the average grocery spending per capita.
#'
#' @param grocery_sales Total US grocery sales annually. Default value is 811541000000.
#' @param population Total US population. Default value is 334233854.
#' @return Outputs average grocery spending per capita.
#' @examples
#' Avg_Capita_Grocery_Spending(grocery_sales = 811541000000, population = 334233854)
#'
#' @export

Avg_Capita_Grocery_Spending <- function(grocery_sales = 811541000000, population = 334233854) {
  grocery_sales / population
}
