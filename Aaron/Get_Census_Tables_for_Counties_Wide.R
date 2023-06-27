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

  state_df_list <- list()

  vars <- tidycensus::load_variables(2021, "acs5")

  var_vector <- c()

  for (my_table in table_vector) {

    library(dplyr)

    vars_1 <- var_df %>% filter(stringr::str_detect(name, my_table))

    vars_1 <- unique(vars_1$name)


    var_vector <- c(var_vector, vars_1)

  }



  state_vector <- unique(df$state)


  for (my_state in state_vector) {


    state_abb <- state.abb[match(my_state,state.name)]

    # Subsetting based on current state in the loop

    state_df <- df[df$state==my_state,]


    county_vector <- unique(state_df$county)


    census_geos_df <- tidycensus::get_acs(geography = geography,
                                          variables = var_vector,
                                              state = my_state,
                                             county = county_vector,
                                             output = "wide",
                                           geometry = TRUE)


    state_df_list[[my_state]] <- census_geos_df

  }

  big_df <- bind_rows(state_df_list)

  big_df <- big_df %>% arrange(GEOID)

  return(big_df)

}


county_df <- get_county_vars(df, "tract", table_vector = table_vector)


View(county_df)










