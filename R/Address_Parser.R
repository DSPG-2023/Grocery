#' Parses an Address
#'
#' @author Alex Cory
#' @description takes in an address string separated by commas and returns the
#' address parsed in list form.
#' @param address address the address as a character to be parsed.
#' @returns splt_addr a data frame with columns street, city,
#'state abbreviation, county, and state
#' @export



Address_Parser <- function(address) {
  splt_addr <- as.list(strsplit(address, ", ")[[1]])
  names(splt_addr) <- c("street", "city", "state_abbv", "country", "state")
  return(splt_addr)
}

