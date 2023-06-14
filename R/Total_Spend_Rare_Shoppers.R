#'Calculates the money spent by rare shoppers
#'
#'@param per_of_grocery_spend_rare the percentage of groceries rare
#'shoppers will spend at the proposed store
#'@param pct_metro_rare The percentage of rare shoppers in metro market
#' default taken as 10% unless specified otherwise.
#'@param pct_rural_rare The percentage of rare shoppers in rural market
#'default taken as 20% unless specified otherwise.
#'@param pct_town_rare The percentage of rare shoppers in town market
#'default taken as 20% unless specified otherwise.
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
#'outputs the total spending by rare Shoppers at the proposed store
#'
#'@example Total_Spend_Rare_Shoppers(county_pop=18000,towns_pop=9786,pct_county=17.7,
#'          town_list=list(77),metro_list=list(2650),est_per_price_increase=7,
#'          state_index=99)
#'
#'@details
#'This function is taken from the estimating Revenue.xlsx and calculated
#'in step 4. This function calls State_Adj_Capita_Grocery_Spend()
#'and Rare_Shopper_Count()
#'
#'@export


Total_Spend_Rare_Shoppers<-function(per_of_grocery_spend_rare=5,
                                    pct_metro_rare=10,pct_rural_rare=20,pct_town_rare=20,
                                    county_pop,towns_pop,pct_county,metro_list,town_list,
                                    state_index,est_per_price_increase,
                                    grocery_sales = 811541000000,population = 334233854){

  per_capita_grocery_spend<-State_Adj_Capita_Grocery_Spend(state_index,
                                                           est_per_price_increase,grocery_sales,
                                                           population)

  num_rare_shoppers<-Rare_Shopper_Count(pct_metro_rare,pct_rural_rare,
                                        pct_town_rare,county_pop, towns_pop,
                                        pct_county,metro_list,town_list)


  per_capita_grocery_spend*(per_of_grocery_spend_rare/100)*num_rare_shoppers

}
