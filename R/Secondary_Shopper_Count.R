#' Calculates the Number of Secondary Shoppers in Each Market
#'
#' @author Srika Raja
#'
#' @description
#' This function calculates the number of secondary shoppers given the
#' population in each market type.
#'
#' @param pct_metro_sec The percentage of secondary shoppers in metro market
#' default taken as 40% unless specified otherwise.
#' @param pct_rural_sec The percentage of secondary shoppers in rural market
#' default taken as 50% unless specified otherwise.
#' @param pct_town_sec The percentage of secondary shoppers in town market
#' default taken as 50% unless specified otherwise.
#' @param metro_pop Population of the store location
#' @param town_pop Population of all towns in the county
#' @param rural_pop Population of rural cities in our market
#'
#' @returns Outputs the total number of secondary shoppers for the store
#'
#' @examples
#' #Secondary_Shopper_Count()
#'
#' @details
#' This function is taken from the estimating Market Size.xlsx
#' and calculated in step 6.
#'
#' @seealso [Primary_Shopper_Count()]
#' @seealso [Rare_Shopper_Count()]
#'
#' @export

Secondary_Shopper_Count<-function(pct_metro_sec=40,pct_rural_sec=50,
                                  pct_town_sec=50,metro_pop, town_pop,
                                  rural_pop){

  floor((metro_pop*(pct_metro_sec/100))+(rural_pop*(pct_rural_sec/100))+
    (town_pop*(pct_town_sec/100)))
}

