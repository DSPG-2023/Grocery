#'Calculation of the operating income (loss)
#'@param Total_Estimated_Revenue Output of total estimated revenue calculation sheet
#'@param Gross_Margin_Percentage Percentage of revenue as gross margin (default from Bizminer)
#'@details This function is taken from the "Estimating_Expenses.xlsx" sheet and calculated in Step Six)
#'Functions called: Cost_of_Goods_Sold, Officer_Compensation, Employee_Wages, Other_Operating_Expense
#'@return Outputs difference between total estimated revenue and aggregated expenses (in dollars)
#'@examples
#'# Employee_Wages(Total_Estimated_Revenue = 2000000, Gross_Margin_Percentage = .2446)
#'
#'@export

Operating_Income_Loss <- function(Total_Estimated_Revenue, Gross_Margin_Percentage = .2446) {
  Goods_cost <- Cost_of_Goods_Sold(Total_Estimated_Revenue, Gross_Margin_Percentage)
  Officer_comp <- Officer_Compensation(Total_Estimated_Revenue)
  Employee_Wages <- Employee_Wages(Total_Estimated_Revenue)
  Other_Expense <- Other_Operating_Expense(Total_Estimated_Revenue)

  Total_Estimated_Revenue - sum(Goods_cost, Officer_comp, Employee_Wages,
                                Other_Expense)
}

