#' Calculation of Other Income
#'
#' @param Total_Estimated_Revenue Calculation of Total_Estimated Revenue
#'
#' @details This function is taken from the "Estimating_Expenses.xlsx" sheet and calculated in Step Eight.
#' Percentages are taken from Bizminer.
#'
#' @returns Outputs "Other Income" (in dollars)
#'
#' @examples
#' # Other_Income(Total_Estimated_Revenue = 2000000)
#'
#' @export

Other_Income <- function(Total_Estimated_Revenue) {

  ifelse(Total_Estimated_Revenue < 500000, stop("error: no data for this revenue range"),
         percentage <- ifelse(Total_Estimated_Revenue < 999999.99, .0186,
                              ifelse(Total_Estimated_Revenue < 2499999.99, .0101,
                                     ifelse(Total_Estimated_Revenue < 4999999.99, .008,
                                            ifelse(Total_Estimated_Revenue < 24999999.99, .0101, .0133)))))

  Total_Estimated_Revenue * percentage
}
