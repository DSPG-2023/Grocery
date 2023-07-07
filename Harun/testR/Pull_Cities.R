#' Takes a List of States and Retreives All Cities in State
#'
#' @author Harun Celik
#'
#' @description the function takes a list of states and passes them through a loop
#' to pull all cities in the provided states.
#'
#' @param state_list A list of state values to iterate through. State values should be unique.
#'

Pull_Cities <- function(state_list = unique(df_grocery_all$state)) {
  all_cities <- NULL
  for (index in 1:length(state_list)) {
    city_loop <- places(state = state_list[index])

    Sys.sleep(2)

    all_cities <- rbind(all_cities, city_loop)
  }

  return(all_cities)
}
