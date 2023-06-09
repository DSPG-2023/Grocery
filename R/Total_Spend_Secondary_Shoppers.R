#'Calculates the money spent by secondary shoppers
#'
#'@param per_of_grocery_spend_sec the percentage of groceries secondary
#'shoppers will spend at the proposed store
#'@param pct_metro_sec The percentage of secondary shoppers in metro market
#' default taken as 40% unless specified otherwise.
#'@param pct_rural_sec The percentage of secondary shoppers in rural market
#'default taken as 50% unless specified otherwise.
#'@param pct_town_sec The percentage of secondary shoppers in town market
#'default taken as 50% unless specified otherwise.
#'@param county_pop population of the county
#'@param towns_pop population of all towns in the county
#'@param pct_county percentage of county in our market
#'@param metro_list lists of population of store location
#'@param town_list list of population of towns in the neighborhood
#'@param state_index the ratio of the current price of the basket to the price of the basket during the base year
#'@param est_per_price_increase Estimated increase in price of grocery in cumulative percent.
#'@param grocery_sales Total US grocery sales annually. Default value is 811541000000.
#'@param population Total US population. Default value is 334233854.
#'
#'@return
#'outputs the total spending by secondary Shoppers at the proposed store
#'
#'@details
#'This function is taken from the estimating Revenue.xlsx and calculated
#'in step 4. This function calls State_Adj_Capita_Grocery_Spend()
#'and Secondary_Shopper_Count()
#'
#'@export


Total_Spend_Secondary_Shoppers<-function(per_of_grocery_spend_sec=25,
                                         pct_metro_sec=40,pct_rural_sec=50,pct_town_sec=50,
                                         county_pop,towns_pop,pct_county,metro_list,town_list,
                                         state_index,est_per_price_increase,
                                         grocery_sales = 811541000000,population = 334233854){

  per_capita_grocery_spend<-State_Adj_Capita_Grocery_Spend(state_index,
                                                           est_per_price_increase,grocery_sales,
                                                           population)

  num_sec_shoppers<-Secondary_Shopper_Count(pct_metro_sec,pct_rural_sec,
                                            pct_town_sec,county_pop, towns_pop,
                                            pct_county,metro_list,town_list)


  per_capita_grocery_spend*(per_of_grocery_spend_sec/100)*num_sec_shoppers

}
