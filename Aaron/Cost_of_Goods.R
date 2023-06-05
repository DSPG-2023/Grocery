#'Calculation of the Cost of Goods Sold
#'@param Total_Estimated_Revenue @description
#'@param Percentage @description Percentage of total estimated revenue spent on supply of goods
#'@return outputs cost of goods sold (in dollars)
#'@examples


Cost_of_Goods_Percentage <- .7816

Cost_of_Goods_Sold <- function(Total_Estimated_Revenue, Percentage = .7816) {
  Total_Estimated_Revenue * Percentage
}



