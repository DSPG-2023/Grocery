#'Calculates the number of Rare shoppers in each marker
#'
#'@param pct_metro_rare The percentage of secondary shoppers in metro market
#' default taken as 10% unless specified otherwise.
#'@param pct_rural_rare The percentage of secondary shoppers in rural market
#'default taken as 20% unless specified otherwise.
#'@param pct_town_rare The percentage of secondary shoppers in town market
#'default taken as 20% unless specified otherwise.
#'@param county_pop population of the county.
#'@param towns_pop population of all towns in the county.
#'@param pct_county percentage of county in our market.
#'@param metro_list lists of population of store location.
#'@param town_list list of population of towns in the neighborhood.
#'
#'@return
#'outputs the total number of Rare shoppers for the store
#'
#'@examples
#'Rare_Shopper_Count(county_pop=18000,towns_pop=9786,
#'pct_county=17.7,town_list=list(77),metro_list=list(2650))
#'
#'@details
#'This function is taken from the estimating Market Size.xlsx
#'and calculated in step 6. This function calls Rural_Population() and
#'City_Populations()
#'
#'@export

Rare_Shopper_Count<-function(pct_metro_rare=10,pct_rural_rare=20,
                             pct_town_rare=20,county_pop, towns_pop,
                             pct_county,metro_list,town_list){
  rural_pop<-Rural_Population(county_pop, towns_pop, pct_county)
  metro_pop<-City_Populations(metro_list)
  town_pop<-City_Populations(town_list)
  floor((metro_pop*(pct_metro_rare/100))+(rural_pop*(pct_rural_rare/100))+
    (town_pop*(pct_town_rare/100)))
}
