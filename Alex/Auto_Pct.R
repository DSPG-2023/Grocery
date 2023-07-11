#' Determining Percentage of County Covered in Market Area
#'
#' @author Alex Cory
#' @description
#' Determines size and percentage of County covered by Market Area
#'
#' @param northeast_dist Distance to nearest store to the Northeast
#' @param northwest_dist Distance to nearest store to the Northwest
#' @param southeast_dist Distance to nearest store to the Southeast
#' @param southwest_dist Distance to nearest store to the Southwest
#' @param df_city_pop Dataframe with City Population
#' @param geo_county County Name
#' @return Sum of Market Area Divided by Size of County
#' @importFrom tigris counties
#' @importFrom dplyr filter
#' @export


Auto_Pct <- function(northeast_dist,northwest_dist,southeast_dist,southwest_dist, df_city_pop, geo_county) {
  sum_val <- sum(Quadrant_Area(northeast_dist),Quadrant_Area(northwest_dist),
                 Quadrant_Area(southeast_dist),Quadrant_Area(southwest_dist))
  county_tigris <- counties(state = df_city_pop$State)
  county_tigris <- county_tigris %>% filter(county_tigris$NAME == geo_county)
  county_size = county_tigris$ALAND
  return(sum_val / county_size)
}
