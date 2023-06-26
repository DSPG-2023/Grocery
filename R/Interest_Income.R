#'Calculation of Interest Income
#'@param Total_Estimated_Revenue Calculation of Total_Estimated Revenue
#'@param Percentage Percentage of revenue of the estimated income from interest
#'@details This function is taken from the "Estimating_Expenses.xlsx" sheet and calculated in Step Eight.
#'@return Outputs first-year interest income (in dollars)
#'@examples
#'# Interest_Income(Total_Estimated_Revenue = 2000000, Percentage = .0004)
#'
#'@export

Interest_Income <- function(Total_Estimated_Revenue, Percentage = .0004) {

  Total_Estimated_Revenue * Percentage

}
