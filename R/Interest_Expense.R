#' Calculates the Annual Cost of Interest on a Loan
#'
#' @author Aaron Null
#'
#' @description
#' This function calculates the annual cost of interest on a loan. The amount of the loan
#' and the annual interest rate is provided by the user.
#'
#'
#' @details
#' This function calculates the dollar amount spent on interest for a loan by multiplying
#' the loan by the annual interest rate (provided by the user).
#'
#' @param Loan_Amount Dollar amount of the user's loan.
#' @param Interest_Rate The annual interest rate on that loan.
#'
#' @returns The output returns the estimated dollar amount spent on interest for a loan.
#'
#' @export


Interest_Expense <- function(Loan_Amount, Interest_Rate) {
  Loan_Amount * Interest_Rate
}
