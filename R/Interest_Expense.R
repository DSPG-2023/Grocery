#'Calculation of first-year interest on a loan
#'@param Loan_Amount Total dollar amount for loan
#'@param Interest_Rate Interest rate (decimal form) on the loan
#'@details This function is taken from the "Estimating_Expenses.xlsx" sheet and calculated in Step Five.
#'@return Outputs first-year loan interest (in dollars)
#'@examples
#'# Interest_Expense(Loan_Amount = 1000000, Interest_Rate = .06)
#'
#'@export


Interest_Expense <- function(Loan_Amount, Interest_Rate) {
  Loan_Amount * Interest_Rate
}
