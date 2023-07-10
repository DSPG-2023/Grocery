#' Retrieves Relevant Census Variables from American Community Survey (2021)
#'
#' @author Aaron Null
#'
#' @description
#' This function retrieves the variables related to median household income, employment
#' status and languages spoken for each county from the American Community Survey (5-year
#' average, 2021). These variables are then used to render plots in the tool.
#'
#'
#' @details
#' This function receives the data frame of cities, counties and states within the
#' circle buffer established by the market size spatial calculations and outputs census data
#' for each county.
#'
#' @param Data Data frame of cities, counties and states within the range of a circle buffer
#' determined by the location of nearest grocery stores.
#'
#' @returns The output returns a data frame of the ACS5 variables for median household
#' income, employment status and languages spoken for each county.
#'
#' @importFrom dplyr bind_rows
#' @importFrom tidycensus get_acs
#'
#'
#' @export


Get_Census_Vars_ACS <- function(Data) {

  state_df_list <- list()

  # Get vector of states

  state_vector <- as.numeric(unique(Data$state))

  # Iterate through that vector of states

  for (my_state in state_vector) {

    # Subsetting based on current state in the loop

    state_df <- Data[Data$state==my_state,]

    # Getting a vector of the counties for the current state in the loop

    county_vector <- unique(state_df$counties)

    # Establishing Census variables to pull

    var_vector <- c("B19013_001", "B23025_003", "B23025_004", "B23025_005", "C16001_001",
                    "C16001_002", "C16001_003", "C16001_006", "C16001_009", "C16001_012",
                    "C16001_015", "C16001_018", "C16001_021", "C16001_024", "C16001_027",
                    "C16001_030", "C16001_033", "C16001_036")

    # Calling TidyCensus to get a data frame of the variables for the counties of the state
    # in the loop


    census_geos_df <- tidycensus::get_acs(geography = "county",
                                          variables = var_vector,
                                          state = my_state,
                                          county = county_vector)

    # Adding this data frame to the empty state_df_list above

    state_df_list[[my_state]] <- census_geos_df

  }

  # Joining the data frames of each state in the list together into a single data frame

  big_df <- dplyr::bind_rows(state_df_list)

  # output big df

  return(big_df)

}

