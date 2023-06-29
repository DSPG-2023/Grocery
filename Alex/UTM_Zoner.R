#'@author Alex Cory
#'@description Allows the user to enter a longitude and have it return the
#'UTM zone
#'
#'@params lng longitude


UTM_Zoner <- function(lng) {
  counter = 180

  i <- 0
  while(counter > lng)
  {
    i = i + 1
    counter = counter - 6
  }
}
