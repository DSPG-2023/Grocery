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
#' @param county_pop Population of the county.
#' @param towns_pop Population of all towns in the county.
#' @param pct_county Percentage of county in our market.
#' @param metro_list Lists of population of store location.
#' @param town_list List of population of towns in the neighborhood.
#'
#' @returns Outputs the total number of secondary shoppers for the store
#'
#' @examples
#' Secondary_Shopper_Count(county_pop=18000,
#'                        towns_pop=9786,
#'                        pct_county=17.7,
#'                        town_list=list(77),
#'                        metro_list=list(2650))
#'
#' @details
#' This function is taken from the estimating Market Size.xlsx
#' and calculated in step 6. This function calls Rural_Population() and
#' City_Populations()
#'
#' @export

Secondary_Shopper_Count<-function(pct_metro_sec=40,pct_rural_sec=50,
                                  pct_town_sec=50,county_pop, towns_pop,
                                  pct_county,metro_list,town_list){
  rural_pop<-Rural_Population(county_pop, towns_pop, pct_county)
  metro_pop<-City_Populations(metro_list)
  town_pop<-City_Populations(town_list)
  floor((metro_pop*(pct_metro_sec/100))+(rural_pop*(pct_rural_sec/100))+
    (town_pop*(pct_town_sec/100)))
}

