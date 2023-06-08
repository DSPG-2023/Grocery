#'Calculation of Annual Rent
#'@param Monthly_Rent Monthly rent for the lease
#'@details This function is taken from the "Estimating_Expenses.xlsx" sheet and calculated in Step Four
#'@return Outputs Annual Rent (in dollars)
#'@examples
#'# Annual_Rent(Monthly_Building_Rent, Other_Rent_1, Other_Rent_2)
#'
#'@export


Annual_Rent <- function(Monthly_Rent) {
  Monthly_Rent * 12
}


