#' Calculation of the Cost of Goods Sold
#'
#' @param Total_Estimated_Revenue Output of a total estimated revenue calculation
#' @param Gross_Margin_Percentage Percentage of revenue as gross margin (default from Bizminer)
#'
#' @details Calls Gross_Margin() function to provide the gross margin (in dollars)
#' which is subtracted from revenue to
#' calculate cost of goods.
#' This function was taken from Estimating_Expense.xlxs (Step 6)
#'
#' @returns Outputs cost of goods sold (in dollars)
#'
#' @examples
#' # Cost_of_Goods_Sold(Total_Estimated_Revenue = 2000000, Gross_Margin_Percentage = .2446)
#'
#' @export

Cost_of_Goods_Sold <- function(Total_Estimated_Revenue, Gross_Margin_Percentage = .2446) {

  Gross_Margin <- Gross_Margin(Total_Estimated_Revenue, Gross_Margin_Percentage)

  Total_Estimated_Revenue - Gross_Margin
}



