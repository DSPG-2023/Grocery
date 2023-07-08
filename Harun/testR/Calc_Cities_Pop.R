Calc_Cities_Pop <- function(states_unique = states_unique) {
  all_cities_pops <- NULL


  for (index_state in 1:length(states_unique)) {

    df_census_subset <- df_census_call %>%
      filter(state == states_unique[index_state])

    counties_unique <- unique(df_census_subset$counties)


    for (index_county in 1:length(counties_unique)) {

      cities_populations <- get_decennial(year = 2020,
                                          geography = "place",
                                          variables = "DP1_0001C",
                                          sumfile = "dp",
                                          county = counties_unique[index_county],
                                          state = states_unique[index_state])

      all_cities_pops <- rbind(all_cities_pops, cities_populations)
    }
  }
  return(all_cities_pops)
}
