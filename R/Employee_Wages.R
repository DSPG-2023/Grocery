#'Calculation of Employee Wages
#'@param Total_Estimated_Revenue Output of total estimated revenue calculation sheet
#'@details This function is taken from the "Estimating_Expenses.xlsx" sheet and calculated in Step Six)
#'@return Outputs dollars spent on employee wages (in dollars based off of percentages taken from Bizminer)
#'@examples
#'# Employee_Wages(Total_Estimated_Revenue = 2000000)
#'
#'@export

Employee_Wages <- function(Total_Estimated_Revenue) {

  ifelse(Total_Estimated_Revenue < 500000, stop("error: no data for this revenue range"),
         percentage <- ifelse(Total_Estimated_Revenue < 999999.99, .0789,
                              ifelse(Total_Estimated_Revenue < 2499999.99, .0934,
                                     ifelse(Total_Estimated_Revenue < 4999999.99, .0751,
                                            ifelse(Total_Estimated_Revenue < 24999999.99, .0975, .1083)))))



  Total_Estimated_Revenue * percentage
}


