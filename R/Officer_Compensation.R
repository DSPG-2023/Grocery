#'Calculation of Officer Compensation
#'@param Total_Estimated_Revenue Output of total estimated revenue calculation sheet
#'@details This function was taken from the "Estimating_Expenses.xlsx" sheet in Step 6.
#'@return Outputs dollars spent (Total Estimated Revenue * Percentage) (in dollars)
#'@examples
#'# Officer_Compensation(Total_Estimated_Revenue = 2000000)
#'
#'@export


Officer_Compensation <- function(Total_Estimated_Revenue) {
  ifelse(Total_Estimated_Revenue < 500000, stop("error: no data for this revenue range"),
         percentage <- ifelse(Total_Estimated_Revenue < 999999.99, .03,
                              ifelse(Total_Estimated_Revenue < 2499999.99, .02,
                                     ifelse(Total_Estimated_Revenue < 4999999.99, .02,
                                            ifelse(Total_Estimated_Revenue < 24999999.99, .07, .04)))))



    Total_Estimated_Revenue * percentage
}
