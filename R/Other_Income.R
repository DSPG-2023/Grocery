#' Calculates the Estimated Income from Miscellaneous Sources for Grocery Stores
#'
#' @author Aaron Null
#'
#' @description
#' This function calculates the estimated income from miscellaneous income sources
#' for a hypothetical store in a user-selected location based off of a user-selected
#' percentage parameter. If not specified by the user, this percentage defaults
#' to the industry average taken from Bizminer and Vertical IQ. Some examples of miscellaneous sources
#' of income might include special grocery delivery services, curbside pickup or discount
#' club fees.
#'
#'
#' @details
#' This function employs a default percentage value from the financial analysis
#' and market research firm Bizminer and is based upon calculations originally
#' formulated by FFED ISU Extension and Outreach.
#'
#' @param Total_Estimated_Revenue Total estimated revenue based on market size/location.
#' @param Percentage Percentage of total estimated revenue that constitutes the added
#' income from miscellaneous ("other") income sources selected via user input
#' (defaults to the average percentage taken from Bizminer and Vertical IQ).
#'
#' @returns The output returns the estimated dollar amount earned as income from these other
#' sources of income for a hypothetical grocery store in a given location.
#'
#' @export

Other_Income <- function(Total_Estimated_Revenue, Percentage = .0115) {

  Total_Estimated_Revenue * Percentage

}
