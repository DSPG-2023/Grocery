#' Retrieves Relevant Census Variables from the US Decennial Census (2020)
#'
#' @author Aaron Null
#'
#' @description
#' This function retrieves the variables related to race/ethnicity and total population
#' for each county from the U.S Decennial Census (2020). These variables are then used to
#' render a data table and a plot in the tool.
#'
#'
#' @details
#' This function receives the data frame of cities, counties and states within the
#' circle buffer established by the market size spatial calculations and outputs census data
#' for each county.
#'
#' @param df_locations Data frame of cities, counties and states within the range of a circle buffer
#' determined by the location of nearest grocery stores. This data frame is inherited
#' from the return of DSPGrocery::Create_Circle_Buffer as df_census_call.
#'
#' @returns The output returns a data frame of the 2020 decennial census variables
#' for race/ethnicity and total population for each county.
#'
#' @importFrom dplyr bind_rows
#' @importFrom tidycensus get_decennial
#'
#'
#' @export


Get_Census_Vars_Decennial <- function(df_locations) {

  # Create empty list for the output data frames of each state

  state_df_list <- list()

  # Get vector of states

  state_vector <- as.numeric(unique(df_locations$state))

  # Iterate through that vector of states

  for (my_state in state_vector) {

    # Subsetting based on current state in the loop

    state_df <- df_locations[df_locations$state==my_state,]

    # Getting a vector of the counties for the current state in the loop

    county_vector <- unique(state_df$counties)

    # Establishing list of Census variables to pull

    decennialList = c("Total Population" = "P1_001N", "White" = "P1_003N", "White (Not Hispanic)" = "P2_005N",
                      "Black" = "P1_004N", "American Indian/Alaskan Native" = "P1_005N",
                      "Asian" = "P1_006N", "Native Hawaiian/Pacific Islander" = "P1_007N",
                      "Other" = "P1_008N", "Two or More Races" = "P1_009N",
                      "Hispanic/Latino" = "P2_002N")

    # Calling TidyCensus to get a data frame of the variables for the counties of the state
    # in the loop


    census_geos_df <- tidycensus::get_decennial(geography = "county",
                                                variables = decennialList,
                                                state = my_state,
                                                county = county_vector,
                                                year = 2020,
                                                output = "wide")

    # Adding this data frame to the empty state_df_list above

    state_df_list[[my_state]] <- census_geos_df

  }

  # Joining the data frames of each state in the list together into a single data frame

  big_df <- dplyr::bind_rows(state_df_list)

  return(big_df)

}
