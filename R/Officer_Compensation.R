#'Calculation of Officer Compensation
#'@param Total_Estimated_Revenue Output of total estimated revenue calculation sheet
#'@param Percentage Percentage of total estimated revenue spent on officer compensation (taken from Bizminer)
#'@return Outputs dollars spent (Total Estimated Revenue * Percentage) (in dollars)
#'@examples
#'# Officer_Compensation(Total_Estimated_Revenue = 2000000, Percentage = .0158)
#'
#'@export


Officer_Compensation <- function(Total_Estimated_Revenue, Percentage = .0158) {
  Total_Estimated_Revenue * Percentage
}
