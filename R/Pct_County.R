#'Calculation for a quarter circle.
#'
#'@param north_quad user defined size of north quadrant
#'@param east_quad user defined size of east quadrant
#'@param south_quad user defined size of south quadrant
#'@param west_quad user defined size of west quadrant
#'@param county_size User defined Size of county
#'@return outputs sum of quadrant areas
#'
#'@export

Pct_County <- function(north_quad,east_quad,south_quad,west_quad, county_size) {
  sum_val <- sum(Quadrant_Area(north_quad),Quadrant_Area(east_quad),
                 Quadrant_Area(south_quad),Quadrant_Area(west_quad))
  return(sum_val / county_size)
}
