#' Calculates the Cost of Goods Sold Based on Gross Margin for Grocery Stores
#'
#' @author Aaron Null
#'
#' @description
#' This function calculates the estimated cost of goods sold based on
#' the selected gross margin percentage for a hypothetical grocery store
#' in a user-selected location.
#'
#'
#' @details
#' This function calls the "Gross_Margin()" function from the DSPG package in its
#' calculations.
#'
#' @param Total_Estimated_Revenue Total estimated revenue based on market size/location.
#' @param Gross_Margin_Percentage Percentage of total estimated revenue expected as gross margin
#' selected via user input (default from Bizminer).
#'
#' @returns The output returns the estimated dollar amount for the cost of goods sold for
#' a hypothetical grocery store in a given location.
#'
#' @export

Cost_of_Goods_Sold <- function(Total_Estimated_Revenue, Gross_Margin_Percentage = .2446) {

  Gross_Margin <- Gross_Margin(Total_Estimated_Revenue, Gross_Margin_Percentage)

  Total_Estimated_Revenue - Gross_Margin
}



