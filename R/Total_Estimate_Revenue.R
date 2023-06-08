#'Calculate the Estimated total Revenue
#'
#'@param per_of_grocery_spend_prim,per_of_grocery_spend_sec,per_of_grocery_spend_rare
#'the percentage of groceries primary,secondary and rare shoppers will spend
#'at the proposed store respectively
#'@param pct_metro_prim,pct_rural_prim,pct_town_prim The percentage of
#'primary shoppers in metro,rural and town markets default taken as
#'50%,30%,30% respectively unless specified otherwise.
#'@param pct_metro_sec,pct_rural_sec,pct_town_sec The percentage of
#'secondary shoppers in metro,rural and town markets default taken as
#'40%,50%,50% respectively unless specified otherwise.
#'@param pct_metro_rare,pct_rural_rare,pct_town_rare The percentage of
#'rare shoppers in metro,rural and town markets default taken as
#'10%,20%,20% respectively unless specified otherwise.
#'@param county_pop,towns_pop population of the county and population of
#'all towns in the county
#'@param pct_county percentage of county in our market
#'@param metro_list,town_list lists of population of store location and
#'populations of towns in the neighborhood
#'@return
#'outputs the estimated total revenue at the proposed store
#'
#'@details
#'This function is taken from the estimating Revenue.xlsx and calculated
#'in step 4. This function calls Total_Spend_Primary_Shoppers(),
#'Total_Spend_Secondary_Shoppers() and Total_Spend_Rare_Shoppers()
#'
#'@export




Total_Estimate_Revenue<- function(  per_of_grocery_spend_rare=5,
                                    per_of_grocery_spend_sec=25,
                                    per_of_grocery_spend_prim=60,                                    pct_metro_prim=50,pct_rural_prim=30,pct_town_prim=30,
                                    pct_metro_sec=40,pct_rural_sec=50,pct_town_sec=50,
                                    pct_metro_rare=10,pct_rural_rare=20,pct_town_rare=20,
                                    county_pop,towns_pop,pct_county,metro_list,town_list,
                                    state_index,est_per_price_increase,
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
