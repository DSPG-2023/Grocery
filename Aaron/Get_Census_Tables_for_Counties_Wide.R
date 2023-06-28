##################################################################################################
### Getting Multiple Tables of Variables for Multiple Counties (Within and Across State Lines) ###
##################################################################################################


### NOTE: this version of the function outputs WIDE data frames ###

# Make mock dataframe (3 Iowa counties, 2 Illinois counties):

county <- c("Muscatine", "Cedar", "Johnson", "Menard", "Lake")

state <- c("Iowa", "Iowa", "Iowa", "Illinois", "Illinois")

df <- cbind.data.frame(county, state)

table_vector <- c("B02001", "B08301", "C16001")


# The function:


get_county_vars <- function(df, geography, table_vector) {

  # Create a list to hold the data frames of all of the states

  state_df_list <- list()

  # Loading a list of ACS variables from TidyCensus

  vars <- tidycensus::load_variables(2021, "acs5")

  # Creating an empty vector to store variable names

  var_vector <- c()

  # Iterating through the tables

  for (my_table in table_vector) {

    # Load dplyr

    library(dplyr)

    # Extract variables from the current table in the loop

    vars_1 <- vars %>% filter(stringr::str_detect(name, my_table))

    # Get a vector of the variable names in the column

    vars_1 <- unique(vars_1$name)

    # Concatenate the current set of variables with the previous in the empty variable vector (top)

    var_vector <- c(var_vector, vars_1)

  }

  # Get a vector of all of the states in the data frame

  state_vector <- unique(df$state)

  # Iterate through that vector of states

  for (my_state in state_vector) {

    # Getting state abbreviation for TidyCensus call

    state_abb <- state.abb[match(my_state,state.name)]

    # Subsetting based on current state in the loop

    state_df <- df[df$state==my_state,]

    # Getting a vector of the counties for the current state in the loop

    county_vector <- unique(state_df$county)

    # Calling TidyCensus to get a data frame of the variables for the counties of the state
    # in the loop


    census_geos_df <- tidycensus::get_acs(geography = geography,
                                          variables = var_vector,
                                              state = my_state,
                                             county = county_vector,
                                             output = "wide",
                                           geometry = TRUE)

    # Adding this data frame to the empty state_df_list above

    state_df_list[[my_state]] <- census_geos_df

  }

  # Joining the data frames of each state in the list together into a single data frame

  big_df <- bind_rows(state_df_list)

  # Arranging by GEOID

  big_df <- big_df %>% arrange(GEOID)

  # Outputting large data frame

  return(big_df)

}


census_vars_df <- get_county_vars(df, "tract", table_vector = table_vector)


View(census_vars_df)










