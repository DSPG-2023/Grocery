#' Calculates the Annual Cost of Rent for Grocery Stores (Scenario 2)
#'
#' @author Aaron Null
#'
#' @description
#' This function calculates the annual cost of rent for a
#' hypothetical store in a user-selected location based off of the user-provided
#' monthly rate of rent on a building. This function is not employed if the user plans to
#' own a building (scenario 1).
#'
#'
#' @details
#' This function multiplies the user-provided monthly rate of rent for a building by 12 to
#' get the annual cost of rent.
#'
#' @param Total_Estimated_Revenue Total estimated revenue based on market size/location.
#' @param Percentage Percentage of total estimated revenue spent on miscellaneous
#'("other") operating expenses selected via user input (default from Bizminer).
#'
#' @returns The output returns the estimated dollar amount spent on rent per year for
#' a hypothetical grocery store in a given building.
#'
#' @export


Annual_Rent <- function(Monthly_Rent = 0) {
  Monthly_Rent * 12
}


