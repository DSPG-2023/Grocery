#'Calculation of Gross Margin
#'@param Total_Estimated_Revenue Output of a total estimated revenue calculation
#'@return Outputs Gross Margin (Total Estimated Revenue - Cost of Goods Sold) (in dollars)
#'@examples
#'# Gross_Margin(Total_Estimated_Revenue = 2000000)
#'
#'@export

Gross_Margin <- function(Total_Estimated_Revenue) {
  Goods_Cost <- Cost_of_Goods_Sold(Total_Estimated_Revenue = Total_Estimated_Revenue)
  Total_Estimated_Revenue - Goods_Cost
}

Gross_Margin(3001981)
