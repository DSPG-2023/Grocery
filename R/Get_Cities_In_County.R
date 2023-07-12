#' Find all Cities in a County Given State and County
#' @author Jay Maxwell
#' @param x a single-row data frame, a column named "state" a column named "county"
#' @return x with all cities in a column as a list
#' @importFrom dplyr mutate select pull
#' @importFrom magrittr %>%
#' @importFrom sf st_join st_intersects
#' @importFrom tigris counties places
#' @export
Get_Cities_in_County <- function(x) {
  #input: a single-row data frame, a column named "state"
  #                                a column named "county"
  #output: x with extra column for all the cities w/in a county

  state <- x[["state"]]
  county <- x[["county"]]

  # Get TIGER/Line geometry for all the counties and cities/places
  # in our state of interest
  cities <- places(state=state)
  counties <- counties(state=state)

  counties %>%
    filter(NAME == county) %>%
    st_join(cities, join=st_intersects) %>%
    pull(NAME.y) %>%
    sort() %>%
    paste(collapse = ", ") -> city_list

  return(cbind(x, city_list))

}
