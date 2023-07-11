get_county <- function(x) {
  #input: a single-row data frame, columns 1, 2 = lon, lat
  #                                column 3 = state name
  #output: x with extra column for county name
  counties <- counties(state=x[["state"]])

  point <- st_as_sf(x, coords = c("lon", "lat"), crs=st_crs(counties))

  point %>%
    st_join(counties, join=st_intersects) %>%
    mutate(county = NAME) %>%
    select(county) %>%
    st_drop_geometry() -> county

  return(cbind(x, county) )
}




get_city <- function(x) {
  # input: a single-row data frame, columns 1, 2 = lon, lat
  #                                column 3 = state name
  # (does not require county column)
  # output: x with extra column for city name

  cities <- places(state=x[["state"]])

  point <- st_as_sf(x, coords = c("lon", "lat"), crs=st_crs(cities))

  point %>%
    st_join(cities, join=st_intersects) %>%
    mutate(city = NAME) %>%
    select(city) %>%
    st_drop_geometry() -> city

  return(cbind(x, city) )
}


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
