#'Calculation of Employee Wages
#'@param Total_Estimated_Revenue Output of total estimated revenue calculation sheet
#'@param Percentage Percentage of total estimated revenue spent on employee wages (default taken from Bizminer)
#'@details This function is taken from the "Estimating_Expenses.xlsx" sheet and calculated in Step Six)
#'@return Outputs dollars spent (Total Estimated Revenue * Percentage) (in dollars)
#'@examples
#'# Employee_Wages(Total_Estimated_Revenue = 2000000, Percentage = 0.0751)
#'
#'@export

Employee_Wages <- function(Total_Estimated_Revenue, Percentage = 0.0751) {
  Total_Estimated_Revenue * Percentage
}


