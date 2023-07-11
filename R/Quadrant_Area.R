#' Calculation for a quarter circle.
#'
#' @param user_area user defined area circle
#' @return outputs output_area
#' @description
#' Quarter Circle Calculation. 1/4(Pi)(r)^2 where r is the distance to the
#' nearest store in a given quadrant
#'
#' @examples
#' Quadrant_Area(user_area = 4)
#' @export

Quadrant_Area <- function(user_area) {

  output_area <- ((pi * (as.numeric(user_area) * as.numeric(user_area))) * 1/4)
  return(output_area)
}
