#'Calculation for a quarter circle.
#'
#'@param north_quad,east_quad,south_quad,west_quad user defined quadrant sizes
#'@return outputs sum of quadrant areas
#'
#'@export

Total_Area <- function(north_quad,east_quad,south_quad,west_quad) {
  sum(QuadrantArea(north_quad),QuadrantArea(east_quad),QuadrantArea(south_quad),QuadrantArea(west_quad))
}
