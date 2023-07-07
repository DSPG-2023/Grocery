#' Takes a List of States and Retreives All Counties in State
#'
#' @author Harun Celik
#'
#' @description the function takes a list of states and passes them through a loop
#' to pull all counties in the provided states.
#'
#' @param state_list A list of state values to iterate through. State values should be unique.
#'

Pull_Counties <- function(state_list = unique(df_grocery_all$state)) {
  all_counties <- NULL
  for (index in 1:length(state_list)) {
    county_loop <- counties(state = state_list[index])

    Sys.sleep(2)

    all_counties <- rbind(all_counties, county_loop)
  }

  return(all_counties)
}
