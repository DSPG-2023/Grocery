#' Finds the Population of everyone who is in the Area but not in a Town
#'
#' @author Alex Cory
#'
#' @description
#' Determines population that does not live in a town or a city but would likely
#' shop at the proposed store
#'
#' @param df_city_pop df with city populations
#' @param geo_county name if county
#' @param df_grocery_only API call with just grocery stores
#' @param df_geocode latlong of store
#' @param popbinder inherited list from the call to DSPGrocery::Calc_Market_Size
#' containing df_city_pop and county_name.
#'
#' @importFrom tidycensus get_decennial
#' @importFrom tidyr separate
#' @importFrom stringr str_split
#' @importFrom magrittr %>%
#'
#' @returns Count of people who would shop at the store who do not live in a city
#'
#' @export



Rural_Pop <- function(df_city_pop, geo_county, df_grocery_only, df_geocode, popbinder) {


  #Jay's function takes a two value dataframe with state and county.
  #Take the values from df_city_pop

  city_df <- data.frame(state = df_city_pop$State, county = geo_county)
  city_in_county <- Get_Cities_in_County(city_df[1,])
  county_cities_list <- str_split(city_in_county$city_list, ", ")

  county_name <- geo_county

  county_pop_df <- get_decennial(year = 2020,
                  geography = "county",
                  variables = "DP1_0001C",
                  sumfile = "dp",
                  state = df_city_pop$State)
  #String cleaning

  county_pop_df$NAME <- gsub( " County", "", as.character(county_pop_df$NAME))
  county_pop_df <- separate(data = county_pop_df, col = NAME,
                            into = c("County", "State"), sep = ", ")

  #Filter county_pop_df to be only the county the store is in
  county_pop_df <- county_pop_df %>% filter(County == county_name$county[1])
  county_pop <- county_pop_df$value


  dist_list <- Haversine_Calculator(df_grocery_only,
                                    df_geocode)


  pct_county <- Auto_Pct(dist_list$northeast_dist,
                                dist_list$northwest_dist,
                                dist_list$northeast_dist,
                                dist_list$southwest_dist,
                                df_city_pop = popbinder$df_city_pop,
                                geo_county = popbinder$county_name$county[1])


  sum_val = 0
  for(i in 1:nrow(df_city_pop)) {
    sum_val = sum_val + as.numeric(df_city_pop$value[i])
  }
  rural <- ((county_pop - sum_val) * pct_county)
  return(floor(rural))
}



