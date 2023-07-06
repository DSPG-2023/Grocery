#' Calculation of Annual Rent
#'
#' @param Monthly_Rent Monthly rent for the lease
#'
#' @details This function is taken from the "Estimating_Expenses.xlsx" sheet and
#' calculated in Step Four
#'
#' @returns
#' Outputs Annual Rent (in dollars)
#'
#' @usage Annual_Rent(Monthly_Rent)
#'
#' @export


Annual_Rent <- function(Monthly_Rent = 0) {
  Monthly_Rent * 12
}


