#' @author Alex Cory
#' @description
#' Determines population that does not live in a town or a city that would likely
#' shop at the proposed store
#'
#' @return Count of people who would shop at the store who do not live in a city



Auto_Rural <- function() {

  #Jay's function takes a two value dataframe with state and county.
  #Take the values from bound_df
  city_df <- data.frame(state = bound_df$State, county = bound_df$County)
  city_in_county <- get_cities_in_county(city_df[1,])
  county_cities_list <- stringr::str_split(city_in_county$city_list, ", ")

  county_name <- bound_df$County

  county_pop_df <- get_decennial(year = 2020,
                  geography = "county",
                  variables = "DP1_0001C",
                  sumfile = "dp",
                  state = bound_df$State)
  #String cleaning
  county_pop_df$NAME <- gsub( " County", "", as.character(county_pop_df$NAME))
  county_pop_df <- separate(data = county_pop_df, col = NAME,
                            into = c("County", "State"), sep = ", ")

  #Filter county_pop_df to be only the county the store is in
  county_pop_df <- county_pop_df %>% filter(county_pop_df$County
                                            == county_name[1])
  county_pop <- county_pop_df$value


  pct_county <- Pct_County(northeast_dist, northwest_dist,
                           southeast_dist, southwest_dist)

  for(i in 1:nrow(bound_df)) {
    sum_val = sum_val + as.numeric(bound_df$value[i])
  }
  rural <- ((county_pop - sum_val) * pct_county)
  return(rural)
}



