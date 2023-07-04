########################################################################################
### Getting Multiple Variables for Multiple Counties (Within and Across State Lines) ###
########################################################################################


### NOTE: this version of the function outputs WIDE data frames ###

# Make mock dataframe (3 Iowa counties, 2 Illinois counties):


county <- c("Muscatine", "Cedar", "Johnson", "Menard", "Lake")

state <- c("Iowa", "Iowa", "Iowa", "Illinois", "Illinois")

df <- cbind.data.frame(county, state)

var_vector <- c("B19013_001", "B23025_002", "C16001_001", "C16001_002")

# Variable list:
# Median Household Income: B19013



get_census_vars_acs <- function(df, geography, var_vector = var_vector) {

  library(dplyr)

  state_df_list <- list()

  # Get vector of states

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
                                          geometry = TRUE)

    # Adding this data frame to the empty state_df_list above

    state_df_list[[my_state]] <- census_geos_df

  }

  # Joining the data frames of each state in the list together into a single data frame

  big_df <- bind_rows(state_df_list)


  # Getting list of ACS variables with labels

  var_codes <- tidycensus::load_variables(2021, "acs5")

  # Selecting only name and label columns

  var_codes <- var_codes[,1:2]

  # Subsetting variable/label list by only the variables in the user-defined variable vector

  var_codes <- var_codes %>% filter(name %in% var_vector)

  # Renaming "name" column to "variable" to match main data frame

  var_codes <- var_codes %>% rename(variable = name)

  # Adding variable label column

  big_df_2 <- merge(big_df, var_codes)

  # Arranging by GEOID

  big_df_2 <- big_df_2 %>% arrange(GEOID)

  # Returning final data frame

  return(big_df_2)

}


### Test Function ###


result_df <- get_census_vars(df, "tract", var_vector)

View(result_df)

library(ggplot2)
library(tidycensus)

vary <- load_variables(2021, "acs5")

