#'Calculates the money spent by primary shoppers
#'
#'@param per_of_grocery_spend_prim the percentage of groceries primary
#'shopper will spend at the proposed store
#'@param pct_metro_prim The percentage of primary shoppers in metro market
#' default taken as 50% unless specified otherwise.
#'@param pct_rural_prim The percentage of primary shoppers in rural market
#'default taken as 30% unless specified otherwise.
#'@param pct_town_prim The percentage of primary shoppers in town market
#'default taken as 30% unless specified otherwise.
#'@param county_pop population of the county.
#'@param towns_pop population of all towns in the county.
#'@param pct_county percentage of county in our market.
#'@param metro_list lists of population of store location.
#'@param town_list list of population of towns in the neighborhood.
#'@param state_index the ratio of the current price of the basket to the price of the basket during the base year
#'@param est_per_price_increase Estimated increase in price of grocery in cumulative percent
#'default taken as 7 for 2023.
#'@param grocery_sales Total US grocery sales annually. Default value is 811541000000.
#'@param population Total US population. Default value is 334233854.
#'
#'@return
#'outputs the total spending by Primary Shoppers at the proposed store
#'
#'@details
#'This function is taken from the estimating Revenue.xlsx and calculated
#'in step 4. This function calls State_Adj_Capita_Grocery_Spend()
#'and Primary_Shopper_Count()
#'@examples
#'Total_Spend_Primary_Shoppers(county_pop=18000,towns_pop=9786,pct_county=17.7,town_list=list(77),metro_list=list(2650),est_per_price_increase=7,state_index=99)
#'
#'@export


Total_Spend_Primary_Shoppers<-function(per_of_grocery_spend_prim=60,
                                       pct_metro_prim=50,pct_rural_prim=30,pct_town_prim=30,
                                       county_pop,towns_pop,pct_county,metro_list,town_list,
                                       state_index,est_per_price_increase=7,
                                       grocery_sales = 811541000000,population = 334233854){
  per_capita_grocery_spend<-State_Adj_Capita_Grocery_Spend(state_index,est_per_price_increase,
                                                           grocery_sales, population)

  num_prim_shoppers<-Primary_Shopper_Count(pct_metro_prim=50,pct_rural_prim=30
                                           ,pct_town_prim=30,county_pop, towns_pop,
                                           pct_county,metro_list,town_list)


  per_capita_grocery_spend*(per_of_grocery_spend_prim/100)*num_prim_shoppers

}
