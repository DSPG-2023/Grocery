#'Calculates the money spent by primary shoppers
#'
#'@param per_of_grocery_spend_prim the percentage of groceries primary
#'shopper will spend at the proposed store
#'@param pct_metro_prim,pct_rural_prim,pct_town_prim The percentage of
#'primary shoppers in metro,rural and town markets default taken as
#'50%,30%,30% respectively unless specified otherwise.
#'@param county_pop,towns_pop population of the county and population of
#'all towns in the county
#'@param pct_county percentage of county in our market
#'@param metro_list,town_list lists of population of store location and
#'populations of towns in the neighborhood
#'
#'@return
#'outputs the total spending by Primary Shoppers at the proposed store
#'
#'@details
#'This function is taken from the estimating Revenue.xlsx and calculated
#'in step 4. This function calls State_Adj_Capita_Grocery_Spend()
#'and Primary_Shopper_Count()
#'
#'@export


Total_Spend_Primary_Shoppers<-function(per_of_grocery_spend_prim=60,
                                       pct_metro_prim=50,pct_rural_prim=30,pct_town_prim=30,
                                       county_pop,towns_pop,pct_county,metro_list,town_list,
                                       state_index,est_per_price_increase,
                                       grocery_sales = 811541000000,population = 334233854){
  per_capita_grocery_spend<-State_Adj_Capita_Grocery_Spend(state_index,est_per_price_increase,
                                                           grocery_sales, population)

  num_prim_shoppers<-Primary_Shopper_Count(pct_metro_prim=50,pct_rural_prim=30
                                           ,pct_town_prim=30,county_pop, towns_pop,
                                           pct_county,metro_list,town_list)


  per_capita_grocery_spend*(per_of_grocery_spend_prim/100)*num_prim_shoppers

}
