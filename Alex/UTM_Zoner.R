#'@author Alex Cory
#'@description Allows the user to enter a longitude and have it return the
#'UTM zone
#'
#'@params lng longitude
#'@return zone the UTM zone


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
