

Metro_Pop <- function(address) {
  #We should be saving address as a global variable so we don't have to pass it
  #as a parameter in most of my functions
  df %>% filter(City == splt_addr["city"])
  return(df$value)
}
