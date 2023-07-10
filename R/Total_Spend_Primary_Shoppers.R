#' Calculates the Money Spent by Primary Shoppers
#'
#' @author Srika Raja
#'
#' @description
#' This function return the total money spent by primary shoppers visiting a store.
#'
#' @param per_of_grocery_spend_prim The percentage of groceries primary
#' shopper will spend at the proposed store
#' @param pct_metro_prim The percentage of primary shoppers in metro market
#'  default taken as 50% unless specified otherwise.
#' @param pct_rural_prim The percentage of primary shoppers in rural market
#' default taken as 30% unless specified otherwise.
#' @param pct_town_prim The percentage of primary shoppers in town market
#' default taken as 30% unless specified otherwise.
#' @param metro_pop Population of the store location
#' @param town_pop Population of all towns in the county
#' @param rural_pop Population of rural cities in our market
#' @param state_index The ratio of the current price of the basket to the price of
#' the basket during the base year
#' @param est_per_price_increase Estimated increase in price of grocery in cumulative percent
#' default taken as 7 for 2023.
#' @param grocery_sales Total US grocery sales annually. Default value is 811541000000.
#' @param population Total US population. Default value is 334233854.
#'
#' @returns
#' Outputs the total spending by primary shoppers at the proposed store
#'
#' @details
#' This function is taken from the estimating Revenue.xlsx and calculated
#' in step 4. This function calls State_Adj_Capita_Grocery_Spend()
#' and Primary_Shopper_Count()
#'
#' @seealso [Total_Spend_Secondary_Shoppers(),Total_Spend_Rare_Shoppers()]
#'
#' @examples
#' Total_Spend_Primary_Shoppers(state_index=99)
#'
#' @export
#'


Total_Spend_Primary_Shoppers<-function(per_of_grocery_spend_prim=60,
                                       pct_metro_prim=50,pct_rural_prim=30,
                                       pct_town_prim=30,
                                       metro_pop, town_pop,rural_pop,
                                       state_index,est_per_price_increase=7,
                                       grocery_sales = 811541000000,
                                       population = 334233854){
  per_capita_grocery_spend<-State_Adj_Capita_Grocery_Spend(state_index,
                                                           est_per_price_increase,
                                                           grocery_sales,
                                                           population)

  num_prim_shoppers<-Primary_Shopper_Count(pct_metro_prim=50,
                                           pct_rural_prim=30,
                                           pct_town_prim=30,
                                           metro_pop, town_pop,rural_pop)


  per_capita_grocery_spend*(per_of_grocery_spend_prim/100)*num_prim_shoppers

}
