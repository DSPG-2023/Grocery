#'Calculation of the Cost of Goods Sold
#'@param Total_Estimated_Revenue Output of a total estimated revenue calculation
#'@param Percentage Percentage of total estimated revenue spent on supply of goods. Default value is .7816 taken from BizMiner (3 year average).
#'@return Outputs cost of goods sold (in dollars)
#'@examples
#'# Cost_of_Goods_Sold(Total_Estimated_Revenue = 2000000, Percentage = .7816)
#'
#'@export

Cost_of_Goods_Sold <- function(Total_Estimated_Revenue, Percentage = .7816) {
  Total_Estimated_Revenue * Percentage
}



