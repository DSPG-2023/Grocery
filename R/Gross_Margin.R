#' Calculation of Gross Margin
#'
#' @param Total_Estimated_Revenue Output of a total estimated revenue calculation
#' @param Percentage Percentage of Revenue as Gross Margin (Revenue - Cost of Goods)
#'
#' @returns Outputs Gross Margin (in dollars) depending on the percentage provided
#' (default from Bizminer)
#'
#' @details This function is taken from the "Estimating Expense" excel sheet (step six)
#'
#' @examples
#' # Gross_Margin(Total_Estimated_Revenue = 2000000, Percentage = .2446)
#'
#' @export

Gross_Margin <- function(Total_Estimated_Revenue, Percentage = .2446) {

    Total_Estimated_Revenue * Percentage

}


