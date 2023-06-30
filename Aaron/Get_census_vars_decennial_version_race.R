library(ggplot2)
library(dplyr)
library(stringr)
library(plotly)
library(tidycensus)

## Making Test data

########################################################################################
### Getting Multiple Variables for Multiple Counties (Within and Across State Lines) ###
########################################################################################


### NOTE: this version of the function outputs WIDE data frames ###

# Make mock dataframe (3 Iowa counties, 2 Illinois counties):


county <- c("Muscatine", "Cedar", "Johnson", "Menard", "Lake")

state <- c("Iowa", "Iowa", "Iowa", "Illinois", "Illinois")

df <- cbind.data.frame(county, state)

# Created variable list

raceList = c("White" = "P1_003N", "Black" = "P1_004N", "American Indian/Alaskan Native" = "P1_005N", "Asian" = "P1_006N", "Native Hawaiian/Pacific Islander" = "P1_007N", "Other" = "P1_008N")

race_counties <- get_decennial(geography = "county",
                               variables = raceList,
                               state = "IA",
                               county = c("Buchanan County", "Chickasaw County", "Grundy County", "Story County"),
                               year = 2020)

race_counties

# Variable list:
# Median Household Income: B19013



get_census_vars_decennial <- function(df, geography, var_vector) {

  # Load dplyr

  library(dplyr)

  # Create empty list for the output data frames of each state

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


    census_geos_df <- tidycensus::get_decennial(geography = geography,
                                          variables = var_vector,
                                          state = my_state,
                                          county = county_vector,
                                          year = 2020,
                                          geometry = TRUE)

    # Adding this data frame to the empty state_df_list above

    state_df_list[[my_state]] <- census_geos_df

  }

  # Joining the data frames of each state in the list together into a single data frame

  big_df <- bind_rows(state_df_list)

  return(big_df)

}

## Test Function ##


race_df <- get_census_vars_decennial(df, "county", var_vector = raceList)

View(race_df)
