#' Find County from Long/Lat points and state
#' @author Jay Maxwell
#' @param x Single row data frame,columns 1, 2 = lon, lat, column 3 = state name
#' @return x with extra column for county name
#' @importFrom dplyr mutate, select
#' @importFrom magrittr ?>?
#' @importFrom sf st_join, st_drop_geometry, st_intersects, st_as_sf, st_crs
#' @importFrom tigris counties
#' @export
get_county <- function(x) {
  counties <- counties(state=x[["state"]])

  point <- st_as_sf(x, coords = c("lon", "lat"), crs=st_crs(counties))

  point %>%
    st_join(counties, join=st_intersects) %>%
    mutate(county = NAME) %>%
    select(county) %>%
    st_drop_geometry() -> county

  return(cbind(x, county) )
}



#' Find all Cities in a County Given State and County
#' @author Jay Maxwell
#' @param x a single-row data frame, a column named "state" a column named "county"
#' @return x with all cities in a column as a list
#' @importFrom dplyr mutate select pullcollapse
#' @importFrom magrittr ?>?
#' @importFrom sf st_join, st_intersects
#' @importFrom tigris counties, places
#' @export
get_cities_in_county <- function(x) {
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
