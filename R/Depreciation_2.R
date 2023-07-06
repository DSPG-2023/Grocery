#' Depreciation Calculation
#'
#' @param Leasehold_Improvements Cost of Leasehold Improvements
#' @param Leasehold_Improvements_Use_Life Use life for Leasehold Improvements
#' @param Shelving_Check_Out_Counters Depreciation of Shelving/Check Out Counters
#' @param Computer_Equipment_POS Cost of Computer System/POS
#' @param Vehicles Cost of Vehicles
#' @param Display_Cases Cost of Display cases
#' @param Refrigeration Cost of Refrigeration
#' @param Freezers Cost of Freezers
#' @param Meat_Cutting_Equipment Cost of Meat-cutting Equipment
#' @param Miscellaneous_Assets_1 Optional parameter. Cost of Miscellaneous Asset 1
#' @param Miscellaneous_Assets_1_Use_Life Optional parameter. Use Life of Miscellaneous Asset 1
#' @param Miscellaneous_Assets_2 Optional parameter. Cost of Miscellaneous Asset 2
#' @param Miscellaneous_Assets_2_Use_Life Optional parameter. Use Life of Miscellaneous Asset 2
#' @param Miscellaneous_Assets_3 Optional parameter. Cost of Miscellaneous Asset 3
#' @param Miscellaneous_Assets_3_Use_Life Optional parameter. Use life of Miscellaneous Asset 3
#' @returns Outputs total estimated loss from depreciation for property owners
#' @details This function is taken from the "Estimating Expense" excel sheet step two
#' @examples
#' Depreciation_2(Leasehold_Improvements = 900000,
#'                Leasehold_Improvements_Use_Life = 10,
#'                Shelving_Check_Out_Counters = 60000,
#'                Computer_Equipment_POS = 15000,
#'                Vehicles = 12000,
#'                Display_Cases = 15000,
#'                Refrigeration = 20000,
#'                Freezers = 20000,
#'                Meat_Cutting_Equipment = 10000,
#'                Miscellaneous_Assets_1 = 10000,
#'                Miscellaneous_Assets_1_Use_Life = 10,
#'                Miscellaneous_Assets_2 = 10000,
#'                Miscellaneous_Assets_2_Use_Life = 10,
#'                Miscellaneous_Assets_3 = 10000,
#'                Miscellaneous_Assets_3_Use_Life = 10)
#' @export

Depreciation_2 <- function(Leasehold_Improvements,
                           Leasehold_Improvements_Use_Life,
                           Shelving_Check_Out_Counters, Computer_Equipment_POS,
                           Vehicles, Display_Cases, Refrigeration,
                           Freezers, Meat_Cutting_Equipment,
                           Miscellaneous_Assets_1, Miscellaneous_Assets_1_Use_Life,
                           Miscellaneous_Assets_2, Miscellaneous_Assets_2_Use_Life,
                           Miscellaneous_Assets_3, Miscellaneous_Assets_3_Use_Life) {

  Leasehold_Improvements_D <- Leasehold_Improvements/Leasehold_Improvements_Use_Life
  Shelving_Check_Out_Counters_D <- Shelving_Check_Out_Counters/15
  Computer_Equipment_POS_D <- Computer_Equipment_POS/5
  Vehicles_D <- Vehicles/5
  Display_Cases_D <- Display_Cases/15
  Refrigeration_D <- Refrigeration/15
  Freezers_D <- Freezers/15
  Meat_Cutting_Equipment_D <- Meat_Cutting_Equipment/12
  Miscellaneous_Assets_1_D <- Miscellaneous_Assets_1/Miscellaneous_Assets_1_Use_Life
  Miscellaneous_Assets_2_D <- Miscellaneous_Assets_2/Miscellaneous_Assets_2_Use_Life
  Miscellaneous_Assets_3_D <- Miscellaneous_Assets_3/Miscellaneous_Assets_3_Use_Life

    sum(Leasehold_Improvements, Shelving_Check_Out_Counters_D,
        Computer_Equipment_POS_D, Vehicles_D, Display_Cases_D, Refrigeration_D, Freezers_D,
        Meat_Cutting_Equipment_D, Miscellaneous_Assets_1_D, Miscellaneous_Assets_2_D,
        Miscellaneous_Assets_3_D)
}
