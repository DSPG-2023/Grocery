#'Calculation of Gross Margin
#'@param Total_Estimated_Revenue Output of a total estimated revenue calculation
#'@return Outputs Gross Margin depending on which one of the 4 revenue ranges
#'the input "Total_Estimated_Revenue" falls into (in dollars)
#'@details This function is taken from the "Estimating Expense" excel sheet (step six)
#'@examples
#'# Gross_Margin(Total_Estimated_Revenue = 2000000)
#'
#'@export

Gross_Margin <- function(Total_Estimated_Revenue) {

  ifelse(Total_Estimated_Revenue < 500000, stop("error: no data for this revenue range"),
      percentage <- ifelse(Total_Estimated_Revenue < 999999.99, .24,
                          ifelse(Total_Estimated_Revenue < 2499999.99, .24,
                                ifelse(Total_Estimated_Revenue < 4999999.99, .21,
                                      ifelse(Total_Estimated_Revenue < 24999999.99, .2418, .23)))))

  if (Total_Estimated_Revenue > 500000) {
    Total_Estimated_Revenue * percentage
  }
}


