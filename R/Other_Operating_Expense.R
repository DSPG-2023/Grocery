#'Calculation of other operating expenses (miscellaneous)
#'@param Total_Estimated_Revenue Output of total estimated revenue calculation sheet
#'@param Percentage Percentage of total estimated revenue spent on other operating expenses. Default value is .1230 (needs clarification)
#'@details This function is taken from the "Estimating_Expenses.xlsx" sheet and calculated in Step Six)
#'@return Outputs other operating expenses (in dollars)
#'@examples
#'# Employee_Wages(Total_Estimated_Revenue = 2000000, Percentage = 0.123)
#'
#'@export

Other_Operating_Expense <- function(Total_Estimated_Revenue, Percentage = .123) {
  Total_Estimated_Revenue * Percentage
}

