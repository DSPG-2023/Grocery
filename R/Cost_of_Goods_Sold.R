#'Calculation of the Cost of Goods Sold
#'@param Total_Estimated_Revenue Output of a total estimated revenue calculation
#'@details Calls Gross_Margin() function to provide the total subtracted from revenue to
#'calculate cost of goods
#'This function was taken from Estimating_Expense.xlxs (Step 6)
#'@return Outputs cost of goods sold (in dollars)
#'@examples
#'# Cost_of_Goods_Sold(Total_Estimated_Revenue = 2000000)
#'
#'@export

Cost_of_Goods_Sold <- function(Total_Estimated_Revenue) {

  Gross_Margin <- Gross_Margin(Total_Estimated_Revenue)

  Total_Estimated_Revenue - Gross_Margin
}



