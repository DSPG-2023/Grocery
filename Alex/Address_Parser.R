#'@Author Alex Cory
#'@description returns the address in list form
#'@param address the address we are interested in
#'@return splt_addr a data frame with columns street, city,
#'state abbreviation, county, and state


Address_Parser <- function(address) {
  splt_addr <<- as.list(strsplit(address, ", ")[[1]])
  names(splt_addr) <<- c("street", "city", "state_abbv", "country", "state")
  return(splt_addr)
}
