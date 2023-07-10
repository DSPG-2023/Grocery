#' Calculates the Number of Rare Shoppers in Each Marker
#'
#' @author Srika Raja
#'
#' @description
#' This function calculates the number of rare shoppers given the
#' population in each market type.
#'
#' @param pct_metro_rare The percentage of secondary shoppers in metro market
#' default taken as 10% unless specified otherwise.
#' @param pct_rural_rare The percentage of secondary shoppers in rural market
#' default taken as 20% unless specified otherwise.
#' @param pct_town_rare The percentage of secondary shoppers in town market
#'default taken as 20% unless specified otherwise.
#' @param metro_pop Population of the store location
#' @param town_pop Population of all towns in the county
#' @param rural_pop Population of rural cities in our market
#'
#' @returns Outputs the total number of Rare shoppers for the store
#'
#' @examples
#' Rare_Shopper_Count()
#'
#' @details
#' This function is taken from the estimating Market Size.xlsx
#' and calculated in step 6.
#'
#' @seealso [Primary_Shoppers_Count(),Secondary_Shoppers_Count()]
#'
#' @export

Rare_Shopper_Count<-function(pct_metro_rare=10,pct_rural_rare=20,
                             pct_town_rare=20,metro_pop, town_pop,
                             rural_pop){

  floor((metro_pop*(pct_metro_rare/100))+(rural_pop*(pct_rural_rare/100))+
    (town_pop*(pct_town_rare/100)))
}
