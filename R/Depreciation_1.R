#' Calculates the Cost of Depreciation Based on List of Assets (For a Building Owner)
#'
#' @author Aaron Null
#'
#' @description
#' This function calculates the estimated cost of the annual depreciation of assets
#' for grocery stores (specifically for scenario 1 in which the building
#' is owned, not rented).
#'
#' @details
#' This function is based upon calculations originally
#' formulated by FFED ISU Extension and Outreach. The values of the various assets
#' are divided by their use life to get the annual loss from depreciation for each asset.
#' These values are added up to get the total annual loss from asset
#' depreciation/amortization. Users can enter in up to 3 miscellaneous assets
#' and each of their corresponding use-lives.
#'
#' @param Building_Remodeling Cost  of Building/Remodeling.
#' @param Parking_Lot_Improvements Cost of Parking Lot Improvements.
#' @param Shelving_Check_Out_Counters Cost of Shelving/Check Out Counters.
#' @param Computer_Equipment_POS Cost of Computer System/POS.
#' @param Vehicles Cost of Vehicles.
#' @param Display_Cases Cost of Display cases.
#' @param Refrigeration Cost of Refrigeration.
#' @param Freezers Cost of Freezers.
#' @param Meat_Cutting_Equipment Cost of Meat-cutting Equipment.
#' @param Miscellaneous_Assets_1 (Optional) Cost of Miscellaneous Asset (1)
#' @param Miscellaneous_Assets_1_Use_Life (Optional) Use Life of Miscellaneous Asset (1)
#' @param Miscellaneous_Assets_2 (Optional) Cost of Miscellaneous Asset (2)
#' @param Miscellaneous_Assets_2_Use_Life (Optional) Use Life of Miscellaneous Asset (2)
#' @param Miscellaneous_Assets_3 (Optional) Cost of Miscellaneous Asset (3)
#' @param Miscellaneous_Assets_3_Use_Life (Optional) Use life of Miscellaneous Asset (3)
#'
#'
#' @returns The output returns the estimated dollar amount lost annually to asset
#' depreciation for a hypoththetical grocery store.
#'
#' @examples Depreciation_1(
#'   Building_Remodeling = 900000,
#'   Parking_Lot_Improvements = 50000,
#'   Shelving_Check_Out_Counters = 60000,
#'   Computer_Equipment_POS = 15000,
#'   Vehicles = 12000,
#'   Display_Cases = 15000,
#'   Refrigeration = 20000,
#'   Freezers = 20000,
#'   Meat_Cutting_Equipment = 10000,
#'   Miscellaneous_Assets_1 = 10000,
#'   Miscellaneous_Assets_1_Use_Life = 10,
#'   Miscellaneous_Assets_2 = 10000,
#'   Miscellaneous_Assets_2_Use_Life = 10,
#'   Miscellaneous_Assets_3 = 10000,
#'   Miscellaneous_Assets_3_Use_Life = 10)
#'
#'
#' @export

Depreciation_1 <- function(Building_Remodeling,
Parking_Lot_Improvements,Shelving_Check_Out_Counters, Computer_Equipment_POS,
Vehicles, Display_Cases, Refrigeration, Freezers, Meat_Cutting_Equipment,
Miscellaneous_Assets_1, Miscellaneous_Assets_1_Use_Life,
Miscellaneous_Assets_2, Miscellaneous_Assets_2_Use_Life,
Miscellaneous_Assets_3, Miscellaneous_Assets_3_Use_Life) {

  Building_Remodeling_D <- Building_Remodeling/39
  Parking_Lot_Improvements_D <- Parking_Lot_Improvements/15
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

  sum(Building_Remodeling_D, Parking_Lot_Improvements_D, Shelving_Check_Out_Counters_D,
      Computer_Equipment_POS_D, Vehicles_D, Display_Cases_D, Refrigeration_D, Freezers_D,
      Meat_Cutting_Equipment_D, Miscellaneous_Assets_1_D, Miscellaneous_Assets_2_D,
      Miscellaneous_Assets_3_D, na.rm = TRUE)
}

