#'Calculation for a quarter circle.
#'
#'@param user_area user defined area circle
#'@return outputs output_area
#'
#'@examples
#'quadrant_area(user_area = 4)
#'@export

Quadrant_Area <- function(user_area) {

  output_area <- (pi * (user_area * user_area)) * 1/4
}
