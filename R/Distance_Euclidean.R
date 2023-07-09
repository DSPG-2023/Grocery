#' Calculates Euclidean Distance from an Origin point to End Points
#'
#' @author Harun Celik
#'
#' @description The function calculates the euclidean distance from a provided origin
#' point to provided end points. The origin and param parameters should be provided
#' in a vector format.
#'
#' @param df this is the data frame containing the latitude and longitude points
#' to which the distance column will be binded to.
#' @param origin this is a vector containing a single latitude and longitude point
#' to be used as the origin point.
#' @param end this is a matrix of latitude and longitude points to be used as the
#' end points.
#'
#' @returns The function returns df_new, a data frame that has the distance calculations
#' appended in the distance_vector column.
#'
#' @export

Distance_Euclidean <- function(df, origin, end) {

  end_matrix = matrix(end, ncol = 2)

  distance_vector <- apply(end_matrix, 1, function(origin, end) {
    sqrt(sum((end_matrix - origin)^2))
  })

  df_new <- cbind(df, distance_vector)
}

