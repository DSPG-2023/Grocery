#'Calculation for a quarter circle.
#'
#'@param north_quad,east_quad,south_quad,west_quad user defined quadrant sizes
#'@param
#'@return outputs sum of quadrant areas
#'
#'@export

Pct_County <- function(north_quad,east_quad,south_quad,west_quad, county_size) {
  sum_val <- sum(Quadrant_Area(north_quad),Quadrant_Area(east_quad),Quadrant_Area(south_quad),Quadrant_Area(west_quad))
  return(sum_val / county_size)
}
