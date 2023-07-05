library(ggplot2)
library(dplyr)
library(stringr)
library(plotly)
library(tidycensus)

## Making Test data

########################################################################################
### Getting Multiple Variables for Multiple Counties (Within and Across State Lines) ###
########################################################################################


### NOTE: this version of the function outputs decennial data ###

# Make mock dataframe (3 Iowa counties, 2 Illinois counties):


county <- c("Muscatine", "Cedar", "Johnson", "Menard", "Lake")

state <- c("Iowa", "Iowa", "Iowa", "Illinois", "Illinois")

df <- cbind.data.frame(county, state)

# Created variable list

decennialList = c("White" = "P1_003N", "Black" = "P1_004N", "American Indian/Alaskan Native" = "P1_005N",
                  "Asian" = "P1_006N", "Native Hawaiian/Pacific Islander" = "P1_007N", "Other" = "P1_008N",
                  "Total" = "P2_001N", "Hispanic/Latino" = "P2_002N", "Not_Hispanic/Latino" = "P2_003N")



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


decennial_df <- get_census_vars_decennial(df, "county", var_vector = decennialList)

View(decennial_df)
