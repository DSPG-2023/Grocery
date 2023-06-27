##################################################################################################
### Getting Multiple Tables of Variables for Multiple Counties (Within and Across State Lines) ###
##################################################################################################

# Make mock dataframe (3 Iowa counties, 2 Illinois counties):

county <- c("Muscatine", "Cedar", "Johnson", "Menard", "Lake")

state <- c("Iowa", "Iowa", "Iowa", "Illinois", "Illinois")

df <- cbind.data.frame(county, state)


# The function:


get_county_vars <- function(df, geography) {

  # Creates empty list

  county_var_list <- list()

  # Selected vector of census tables to gather for each county

  table_vector <- c("B02001", "B08301", "B08303", "B19013", "B23025", "C16001")

  # Getting a vector of the states within the input data frame

  state_vector <- unique(df$state)

  # Iterating through the vector of states

  for (my_state in state_vector) {

    # Getting state abbreviation for TidyCensus call

    state_abb <- state.abb[match(my_state,state.name)]

    # Subsetting based on current state in the loop

    state_df <- df[df$state==my_state,]

    # Getting a vector of the counties for the current state in the loop

    county_vector <- unique(state_df$county)

    # Iterating through the vector of census tables

    for (table in table_vector) {

      # Getting the current Census table in the loop for the counties of the
      # current state in the bigger loop

      census_geos <- tidycensus::get_acs(geography = geography,
                                    table = table,
                                    state = my_state,
                                    county = county_vector,
                                    geometry = TRUE)

      # Adding the census tables for these state counties into the empty list

      county_var_list[[my_state]][[table]] <- census_geos
    }

  }

  # Outputting large list of tables for all counties grouped by state

  return(county_var_list)
}



### Testing the function ###

test_list <- get_county_vars(df, "tract")


View(test_list)
