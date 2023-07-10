#' Calculates the Money Spent by Secondary Shoppers
#'
#' @author Srika Raja
#'
#' @description
#' This function returns the total money spent by secondary shoppers visiting a store.
#'
#' @param per_of_grocery_spend_sec the percentage of groceries secondary
#' shoppers will spend at the proposed store
#' @param pct_metro_sec The percentage of secondary shoppers in metro market
#'  default taken as 40% unless specified otherwise.
#' @param pct_rural_sec The percentage of secondary shoppers in rural market
#' default taken as 50% unless specified otherwise.
#' @param pct_town_sec The percentage of secondary shoppers in town market
#' default taken as 50% unless specified otherwise.
#' @param metro_pop Population of the store location
#' @param town_pop Population of all towns in the county
#' @param rural_pop Population of rural cities in our market
#' @param state_index the ratio of the current price of the basket to the price of
#' the basket during the base year
#' @param est_per_price_increase Estimated increase in price of grocery in cumulative percent
#' default taken as 7 for 2023.
#' @param grocery_sales Total US grocery sales annually. Default value is 811541000000.
#' @param population Total US population. Default value is 334233854.
#'
#' @returns
#' Outputs the total spending by secondary shoppers at the proposed store
#'
#' @examples
#' #Total_Spend_Secondary_Shoppers(state_index=99)
#'
#' @details
#' This function is taken from the estimating Revenue.xlsx and calculated
#' in step 4. This function calls State_Adj_Capita_Grocery_Spend()
#' and Secondary_Shopper_Count()
#'
#' @seealso [Total_Spend_Primary_Shoppers()],[Total_Spend_Rare_Shoppers()]
#'
#' @export


Total_Spend_Secondary_Shoppers<-function(per_of_grocery_spend_sec=25,
                                         pct_metro_sec=40,pct_rural_sec=50,
                                         pct_town_sec=50,
                                         metro_pop, town_pop,rural_pop,
                                         state_index,est_per_price_increase=7,
                                         grocery_sales = 811541000000,
                                         population = 334233854){

  per_capita_grocery_spend<-State_Adj_Capita_Grocery_Spend(state_index,
                                                           est_per_price_increase,
                                                           grocery_sales,
                                                           population)

  num_sec_shoppers<-Secondary_Shopper_Count(pct_metro_sec,pct_rural_sec,
                                            pct_town_sec,metro_pop, town_pop,
                                            rural_pop)


  per_capita_grocery_spend*(per_of_grocery_spend_sec/100)*num_sec_shoppers

}
