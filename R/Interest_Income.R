#' Calculates the Estimated Income of from Interest-Bearing Assets for Grocery Stores
#'
#' @author Aaron Null
#'
#' @description
#' This function calculates the estimated income from interest-bearing assets
#' for a hypothetical store in a user-selected location based off of a user-selected
#' percentage parameter. If not specified by the user, this percentage defaults
#' to the industry average provided by Bizminer.
#'
#'
#' @details
#' This function employs a default percentage value from the financial analysis
#' and market research firm Bizminer and is based upon calculations originally
#' formulated by FFED ISU Extension and Outreach.
#'
#' @param Total_Estimated_Revenue Total estimated revenue based on market size/location.
#' @param Percentage Percentage of total estimated revenue that constitutes the added
#' income from interest selected via user input (default from Bizminer).
#'
#' @returns The output returns the estimated dollar amount earned as income from interest for
#' a hypothetical grocery store in a given location.
#'
#' @export

Interest_Income <- function(Total_Estimated_Revenue, Percentage = .0004) {

  Total_Estimated_Revenue * Percentage

}
