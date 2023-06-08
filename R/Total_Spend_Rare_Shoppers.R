#'Calculates the money spent by rare shoppers
#'
#'@param per_of_grocery_spend_rare the percentage of groceries rare
#'shoppers will spend at the proposed store
#'@param pct_metro_rare,pct_rural_rare,pct_town_rare The percentage of
#'rare shoppers in metro,rural and town markets default taken as
#'10%,20%,20% respectively unless specified otherwise.
#'@param county_pop,towns_pop population of the county and population of
#'all towns in the county
#'@param pct_county percentage of county in our market
#'@param metro_list,town_list lists of population of store location and
#'populations of towns in the neighborhood
#'
#'@return
#'outputs the total spending by rare Shoppers at the proposed store
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
