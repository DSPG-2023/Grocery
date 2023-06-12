#'Calculation of Interest Income
#'@param Total_Estimated_Revenue Calculation of Total_Estimated Revenue
#'@details This function is taken from the "Estimating_Expenses.xlsx" sheet and calculated in Step Eight.
#'@return Outputs first-year interest income (in dollars)
#'@examples
#'# Interest_Expense(Total_Estimated_Revenue = 2000000)
#'
#'@export

Interest_Income <- function(Total_Estimated_Revenue) {

  ifelse(Total_Estimated_Revenue < 500000, stop("error: no data for this revenue range"),
         percentage <- ifelse(Total_Estimated_Revenue < 999999.99, .01,
                              ifelse(Total_Estimated_Revenue < 2499999.99, .02,
                                     ifelse(Total_Estimated_Revenue < 4999999.99, .1,
                                            ifelse(Total_Estimated_Revenue < 24999999.99, .01, .04)))))

  Total_Estimated_Revenue * percentage
}
