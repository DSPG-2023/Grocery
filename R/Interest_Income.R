#' Calculates the Estimated Income from Interest-Bearing Assets for Grocery Stores
#'
#' @author Aaron Null
#'
#' @description
#' This function calculates the estimated income from interest-bearing assets
#' for a hypothetical store in a user-selected location based off of a user-selected
#' percentage parameter. If not specified by the user, this percentage defaults
#' to the industry average taken from Bizminer and Vertical IQ.
#'
#'
#' @details
#' This function employs a default average percentage value from the financial analysis
#' and market research firms Bizminer and Vertical IQ and is based upon
#' calculations originally formulated by FFED ISU Extension and Outreach.
#'
#' @param Total_Estimated_Revenue Total estimated revenue based on market size/location.
#' @param Percentage Percentage of total estimated revenue that constitutes the added
#' income from interest selected via user input (defaults to the average percentage
#' taken from Bizminer and Vertical IQ).
#'
#' @returns The output returns the estimated dollar amount earned as income from interest for
#' a hypothetical grocery store in a given location.
#'
#' @export

Interest_Income <- function(Total_Estimated_Revenue, Percentage = .0004) {

  Total_Estimated_Revenue * Percentage

}
