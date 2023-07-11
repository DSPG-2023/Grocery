#' Find County from Long/Lat points and state
#'
#' @author Jay Maxwell
#' @param x Single row data frame,columns 1, 2 = lon, lat, column 3 = state name
#'
#' @returns x with extra column for county name
#'
#' @importFrom dplyr mutate select
#' @importFrom magrittr %>%
#' @importFrom sf st_join st_drop_geometry st_intersects st_as_sf st_crs
#' @importFrom tigris counties
#'
#' @export

County_Identifier <- function(x) {
  counties <- counties(state=x[["state"]])

  point <- st_as_sf(x, coords = c("lon", "lat"), crs=st_crs(counties))

  point %>%
    st_join(counties, join=st_intersects) %>%
    mutate(county = NAME) %>%
    select(county) %>%
    st_drop_geometry() -> county

  return(cbind(x, county) )
}

