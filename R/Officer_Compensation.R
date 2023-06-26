#'Calculation of Officer Compensation
#'@param Total_Estimated_Revenue Output of total estimated revenue calculation sheet
#'@param Percentage Percentage of revenue spent on officer compensation (default from Bizminer)
#'@details This function was taken from the "Estimating_Expenses.xlsx" sheet in Step 6.
#'@return Outputs dollars spent on officer compensation (Total Estimated Revenue * Percentage) (in dollars)
#'@examples
#'# Officer_Compensation(Total_Estimated_Revenue = 2000000, Percentage = .0118)
#'
#'@export


Officer_Compensation <- function(Total_Estimated_Revenue, Percentage = .0118) {

  Total_Estimated_Revenue * Percentage

}
