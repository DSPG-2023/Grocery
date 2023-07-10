#' Calculates the Number of Primary Shoppers in Each Marker
#'
#' @author Srika Raja
#'
#' @description
#' This function calculates the number of primary shoppers given the
#' population in each market type.
#'
#' @param pct_metro_prim The percentage of primary shoppers in metro market
#' default taken as 50% unless specified otherwise.
#' @param pct_rural_prim The percentage of primary shoppers in rural market
#' default taken as 30% unless specified otherwise.
#' @param pct_town_prim The percentage of primary shoppers in town market
#' default taken as 30% unless specified otherwise.
#' @param metro_pop Population of the store location
#' @param town_pop Population of all towns in the county
#' @param rural_pop Population of rural cities in our market
#'
#' @returns Outputs the total number of primary shoppers for the store
#'
#' @examples
#' #Primary_Shopper_Count()
#'
#' @details
#' This function is taken from the estimating Market Size.xlsx
#' and calculated in step 6.
#'
#' @seealso [Secondary_Shopper_Count()],[Rare_Shopper_Count()]
#'
#' @export

Primary_Shopper_Count<-function(pct_metro_prim=50,pct_rural_prim=30
                                ,pct_town_prim=30,metro_pop, town_pop,
                                rural_pop){

  floor((metro_pop*(pct_metro_prim/100))+(rural_pop*(pct_rural_prim/100))+
    (town_pop*(pct_town_prim/100)))
}

