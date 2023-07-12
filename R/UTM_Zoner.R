#' Finding UTM Zone from Longitude in North America
#' @author Alex Cory
#' @description Allows the user to enter a longitude and have it return the
#' UTM zone. Works only in North America.
#'
#' @param lng longitude
#' @returns zone the UTM zone
#' @export


UTM_Zoner <- function(lng) {
  counter = 180
  zone <- 0
  while(counter > lng)
  {
    zone = zone + 1
    counter = counter - 6
  }
  return(zone)
}
