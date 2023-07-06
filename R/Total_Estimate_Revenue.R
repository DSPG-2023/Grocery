#' Calculates the Estimated Total Revenue
#'
#' @param per_of_grocery_spend_prim the percentage of groceries primary
#' shopper will spend at the proposed store
#' @param per_of_grocery_spend_sec the percentage of groceries secondary
#' shoppers will spend at the proposed store
#' @param per_of_grocery_spend_rare the percentage of groceries rare
#' shoppers will spend at the proposed store
#' @param pct_metro_prim The percentage of primary shoppers in metro market
#'  default taken as 50% unless specified otherwise.
#' @param pct_rural_prim The percentage of primary shoppers in rural market
#' default taken as 30% unless specified otherwise.
#' @param pct_town_prim The percentage of primary shoppers in town market
#' default taken as 30% unless specified otherwise.
#' @param pct_metro_sec The percentage of secondary shoppers in metro market
#'  default taken as 40% unless specified otherwise.
#' @param pct_rural_sec The percentage of secondary shoppers in rural market
#' default taken as 50% unless specified otherwise.
#' @param pct_town_sec The percentage of secondary shoppers in town market
#' default taken as 50% unless specified otherwise.
#' @param pct_metro_rare The percentage of rare shoppers in metro market
#'  default taken as 10% unless specified otherwise.
#' @param pct_rural_rare The percentage of rare shoppers in rural market
#' default taken as 20% unless specified otherwise.
#' @param pct_town_rare The percentage of rare shoppers in town market
#' default taken as 20% unless specified otherwise.
#' @param county_pop population of the county.
#' @param towns_pop population of all towns in the county.
#' @param pct_county percentage of county in our market.
#' @param metro_list lists of population of store location.
#' @param town_list list of population of towns in the neighborhood.
#' @param state_index the ratio of the current price of the basket to the price
#' of the basket during the base year
#' @param est_per_price_increase Estimated increase in price of grocery in cumulative percent
#' default taken as 7 for 2023.
#' @param grocery_sales Total US grocery sales annually. Default value is 811541000000.
#' @param population Total US population. Default value is 334233854.
#'
#' @returns
#' outputs the estimated total revenue at the proposed store
#'
#' @examples
#' Total_Estimate_Revenue(county_pop=18000,
#'                        towns_pop=9786,
#'                        pct_county=17.7,
#'                        town_list=list(77),
#'                        metro_list=list(2650),
#'                        state_index=99)
#'
#' @details
#' This function is taken from the estimating Revenue.xlsx and calculated
#' in step 4. This function calls Total_Spend_Primary_Shoppers(),
#' Total_Spend_Secondary_Shoppers() and Total_Spend_Rare_Shoppers()
#'
#' @export




Total_Estimate_Revenue<- function(  per_of_grocery_spend_rare=5,
                                    per_of_grocery_spend_sec=25,
                                    per_of_grocery_spend_prim=60,                                    pct_metro_prim=50,pct_rural_prim=30,pct_town_prim=30,
                                    pct_metro_sec=40,pct_rural_sec=50,pct_town_sec=50,
                                    pct_metro_rare=10,pct_rural_rare=20,pct_town_rare=20,
                                    county_pop,towns_pop,pct_county,metro_list,town_list,
                                    state_index,est_per_price_increase=7,
                                    grocery_sales = 811541000000,population = 334233854){

  primary_spend<-Total_Spend_Primary_Shoppers(per_of_grocery_spend_prim,                      pct_metro_prim,pct_rural_prim,pct_town_prim,
                                              county_pop,towns_pop,pct_county,metro_list,town_list,
                                              state_index,est_per_price_increase,
                                              grocery_sales,population)

  secondary_spend<-Total_Spend_Secondary_Shoppers(per_of_grocery_spend_sec,
                                                  pct_metro_sec,pct_rural_sec,pct_town_sec,
                                                  county_pop,towns_pop,pct_county,metro_list,town_list,
                                                  state_index,est_per_price_increase,
                                                  grocery_sales,population)

  rare_spend<-Total_Spend_Rare_Shoppers(per_of_grocery_spend_rare,
                                        pct_metro_rare,pct_rural_rare,pct_town_rare,
                                        county_pop,towns_pop,pct_county,metro_list,town_list,
                                        state_index,est_per_price_increase,
                                        grocery_sales,population)


  primary_spend+secondary_spend+rare_spend
}
