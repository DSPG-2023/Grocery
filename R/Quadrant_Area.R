#' Calculates the Area for a  Quarter Circle.
#'
#' @param user_area user defined area circle
#'
#' @returns outputs output_area
#'
#' @examples
#' Quadrant_Area(user_area = 4)
#'
#' @export

Quadrant_Area <- function(user_area) {

  output_area <- (pi * (user_area * user_area)) * 1/4
}
