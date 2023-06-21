#'Calculation of Depreciation (for Leasing)
#'@param Leasehold_Improvements
#'@param Shelving_Check_Out_Counters
#'@param Computer_Equipment_POS
#'@param Vehicles
#'@param Display_Cases
#'@param Refrigeration
#'@param Freezers
#'@param Meat_Cutting_Equipment
#'@param Miscellaneous_Assets_1
#'@param Miscellaneous_Assets_1_Use_Life
#'@param Miscellaneous_Assets_2
#'@param Miscellaneous_Assets_2_Use_Life
#'@param Miscellaneous_Assets_3
#'@param Miscellaneous_Assets_3_Use_Life
#'@return Outputs total estimated loss from depreciation for leasers
#'@details This function is taken from the "Estimating Expense" excel sheet (step three)
#'@examples
#'#
#'
#'@export

Depreciation_2 <- function(Leasehold_Improvements, Leasehold_Improvements_Use_Life, Shelving_Check_Out_Counters, Computer_Equipment_POS,
                           Vehicles, Display_Cases, Refrigeration, Freezers, Meat_Cutting_Equipment,
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
