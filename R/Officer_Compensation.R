#' Calculates the Estimated Cost of Officer Compensation for Grocery Stores
#'
#' @author Aaron Null
#'
#' @description
#' This function calculates the estimated cost of officer compensation for a hypothetical
#' store in a user-selected location based off of a user-selected percentage parameter.
#' If not specified by the user, this percentage defaults to the industry average
#' taken from Bizminer and Vertical IQ.
#'
#'
#' @details
#' This function employs a default average percentage value from the financial analysis
#' and market research firms Bizminer and Vertical IQ and is based upon calculations
#' originally formulated by FFED ISU Extension and Outreach.
#'
#' @param Total_Estimated_Revenue Total estimated revenue based on market size/location.
#' @param Percentage Percentage of total estimated revenue spent on officer compensation
#' selected via user input (defaults to the average percentage taken
#' from Bizminer and Vertical IQ).
#'
#' @returns The output returns the estimated dollar amount spent on officer compensation for
#' a hypothetical grocery store in a given location.
#'
#' @export


Officer_Compensation <- function(Total_Estimated_Revenue, Percentage = .0118) {

  Total_Estimated_Revenue * Percentage

}
