#' Calculation of Revenue Surplus after the Subtraction of Cost of Goods and other Operating
#' Costs (Interim Result - Not Final)
#'
#' @author Aaron Null
#'
#' @description
#' This function calculates the estimated revenue surplus after subtracting the cost of goods,
#' officer compensation, employee wages and other operating expenses and outputs an interim
#' profit figure before depreciation, interest income, interest expense and secondary sources
#' of income are taken into account.
#'
#'
#' @details
#' This function employs the user-selected gross margin percentage as an argument and calls
#' the functions "Cost_of_Goods_Sold()", "Officer_Compensation()", "Employee_Wages()" and
#' "Other_Operating_Expense()". This function is based upon calculations originally
#' formulated by FFED ISU Extension and Outreach.
#'
#' @param Total_Estimated_Revenue Total estimated revenue based on market size/location.
#' @param Gross_Margin_Percentage User-selected gross margin percentage
#' (default taken from Bizminer).
#'
#' @returns The output returns the estimated revenue surplus (revenue left over) after the
#' subtraction of the cost of goods sold and operating expenses (minus depreciation).
#'
#' @export

Operating_Income_Loss <- function(Total_Estimated_Revenue, Gross_Margin_Percentage = .2446) {

  Goods_cost <- Cost_of_Goods_Sold(Total_Estimated_Revenue, Gross_Margin_Percentage)
  Officer_comp <- Officer_Compensation(Total_Estimated_Revenue)
  Employee_Wages <- Employee_Wages(Total_Estimated_Revenue)
  Other_Expense <- Other_Operating_Expense(Total_Estimated_Revenue)

  Total_Estimated_Revenue - sum(Goods_cost, Officer_comp, Employee_Wages,
                                Other_Expense)
}

