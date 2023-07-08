Calc_Counties_Pop <- function(states_unique = states_unique) {
  all_counties_pops <- NULL


  for (index_state in 1:length(states_unique)) {

    df_census_subset <- df_census_call %>%
      filter(state == states_unique[index_state])

    counties_unique <- unique(df_census_subset$counties)


    counties_populations <- get_decennial(year = 2020,
                                          geography = "county",
                                          variables = "DP1_0001C",
                                          sumfile = "dp",
                                          county = counties_unique,
                                          state = states_unique[index_state],
                                          geometry = T)

    all_counties_pops <- rbind(all_counties_pops, counties_populations)
  }
  return(all_counties_pops)
}
