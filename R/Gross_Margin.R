#' Calculates the Expected Gross Margin for Grocery Stores
#'
#' @author Aaron Null
#'
#' @description
#' This function calculates the estimated portion of the total estimated revenue represented
#' as gross margin for a hypothetical grocery store in a user-selected location
#' based off of a user-selected percentage parameter.
#' If not specified by the user, this percentage defaults to the industry average
#' provided by Bizminer and Vertical IQ.
#'
#'
#' @details
#' This function employs a default average percentage value from the financial analysis
#' and market research firms Bizminer and Vertical IQ and is based upon calculations
#' originally formulated by FFED ISU Extension and Outreach.
#'
#' @param Total_Estimated_Revenue Total estimated revenue based on market size/location.
#' @param Percentage Percentage of total estimated revenue expected as gross margin
#' selected via user input (defaults to the average percentage
#' taken from Bizminer and Vertical IQ).
#'
#' @returns The output returns the estimated dollar amount for gross margin for
#' a hypothetical grocery store in a given location.
#'
#' @export

Gross_Margin <- function(Total_Estimated_Revenue, Percentage = .2446) {

    Total_Estimated_Revenue * Percentage

}


