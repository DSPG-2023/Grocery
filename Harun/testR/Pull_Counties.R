#' Takes a Vector of States and Retrieves All Counties in State(s)
#'
#' @author Harun Celik
#'
#' @description the function takes a list of states and passes them through a loop
#' to pull all counties in the provided states.
#'
#' @details
#' values in the list are filtered using unique() to avoid repetitive loops.
#'
#' @param state_list A list of unique state values to iterate through.
#'
#'
#' @importFrom tigris counties
#'
#' @returns returns a data frame of all the counties in a state(s) called all_counties
#'
#' @export

Pull_Counties <- function(state_list = unique(df_grocery_all$state)) {
  all_counties <- NULL
  for (index in 1:length(state_list)) {
    county_loop <- counties(state = state_list[index])

    Sys.sleep(2)

    all_counties <- rbind(all_counties, county_loop)
  }

  return(all_counties)
}
