#'Calculation for a quarter circle.
#'
#'@param north_quad,east_quad,south_quad,west_quad user defined quadrant sizes
#'@param
#'@return outputs sum of quadrant areas
#'
#'@export

Pct_County <- function(north_quad,east_quad,south_quad,west_quad, county_size) {
  sum_val <- sum(QuadrantArea(north_quad),QuadrantArea(east_quad),QuadrantArea(south_quad),QuadrantArea(west_quad))
  return(sum_val / county_size)
}
