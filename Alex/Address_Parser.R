#' Parses an Address
#'
#' @author Alex Cory
#' @description takes in an address string separated by commas and returns the
#' address parsed in list form.
#' @param address the address as a character to be parsed.
#' @returns split_addr a data frame with columns street, city,
#' state abbreviation, county, and state.
#' @export



Address_Parser <- function(address) {
  split_addr <- as.list(strsplit(address, ", ")[[1]])
  names(split_addr) <- c("street", "city", "state")
  return(split_addr)
}
