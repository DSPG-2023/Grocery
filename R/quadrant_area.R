#'Calculation for a quarter circle.
#'
#'@param user_area user defined area circle
#'@return outputs output_area
#'
#'@examples
#'quadrant_area(user_area = 4)
#'@export

quadrant_area <- function(user_area) {

  output_area <- (pi * (user_area * user_area)) * 1/4
}
