#' Creates a Circle Buffer to the Furthest of Four Nearest Stores in a Quadrant
#'
#' @author Harun Celik
#'
#' @description
#' DESCRIBE
#'
#'

address <- "Main St, McCalsburg, IA"

Create_Circle_Buffer <- function(address = "Main St, McCalsburg, IA",
                              api_key = Sys.getenv("PLACES_KEY"),
                              keyword = "grocery") {

  # Timer Start
  startTime <- Sys.time()

  # Set Google API Key
  set_key(key = api_key)


  # Parse Address
  parsed_addr <- Address_Parser(address = address)


  # Geocode Address
  df_geocode <- google_geocode(address = "Main St, McCalsburg, IA") %>%
    .$results %>%
    .$geometry %>%
    .$location

  # Call Google Places API & Convert Output to Retreive State Information
  df_grocery_all <- google_places(location = c(df_geocode$lat
                                               , df_geocode$lng),
                                  keyword = "grocery",
                                  rankby = "distance") %>%
    .$results %>%
    transmute(name,
              lat = .$geometry$location$lat,
              lng = .$geometry$location$lng,
              types,
              vicinity,
              state = strsplit(.$plus_code$compound_code, split = ", ")) %>%
    filter(state != "NANA") %>%
    mutate(state = sapply(.$state, "[[", 2))


  # Reshape df_grocery_all$types to only keep the first store type
  for (item in 1:nrow(df_grocery_all)) {
    df_grocery_all$types[item] <- df_grocery_all$types[[item]][1]
  }

  Store_Info <<- list(df_grocery_all = df_grocery_all)


  # Timer End
  EndTime <- Sys.time()

  # Total Time
  TotalTime <- EndTime - startTime

  # Return Completion Time
  return(print(sprintf("Run time: %.3f seconds", TotalTime)))
}
