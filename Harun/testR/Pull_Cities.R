#' Takes a Vector of States and Retrieves All Cities in State(s)
#'
#' @author Harun Celik
#'
#' @description the function takes a list of states and passes them through a loop
#' to pull all cities in the provided states.
#'
#' @details
#' values in the list are filtered using unique() to avoid repetitive loops.
#'
#' @param state_list A list of unique state values to iterate through.
#'
#'
#' @importFrom tigris places
#'
#' @returns returns a data frame of all the cities in a state(s) called all_cities
#'
#' @export

Pull_Cities <- function(state_list = unique(df_grocery_all$state)) {
  all_cities <- NULL
  for (index in 1:length(state_list)) {
    city_loop <- places(state = state_list[index])

    Sys.sleep(2)

    all_cities <- rbind(all_cities, city_loop)
  }

  return(all_cities)
}
