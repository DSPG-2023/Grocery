#'Calculation of other operating expenses (miscellaneous)
#'@param Total_Estimated_Revenue Output of total estimated revenue calculation sheet
#'@param Percentage Percentage of total estimated revenue spent on other operating expenses.
#'Percentages are taken from Bizminer.
#'@details This function is taken from the "Estimating_Expenses.xlsx" sheet and calculated in Step Six)
#'@return Outputs other operating expenses (in dollars)
#'@examples
#'# Employee_Wages(Total_Estimated_Revenue = 2000000)
#'
#'@export

Other_Operating_Expense <- function(Total_Estimated_Revenue) {

  ifelse(Total_Estimated_Revenue < 500000, stop("error: no data for this revenue range"),
         Percentage <- ifelse(Total_Estimated_Revenue < 999999.99, .11,
                              ifelse(Total_Estimated_Revenue < 2499999.99, .12,
                                     ifelse(Total_Estimated_Revenue < 4999999.99, .11,
                                            ifelse(Total_Estimated_Revenue < 24999999.99, .11, .10)))))


  Total_Estimated_Revenue * percentage
}

