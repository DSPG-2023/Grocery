#' No Title?
#'
#' @author Alex Cory
#'
#' @description
#' Finds the distance to the nearest store in each quadrant.
#' No return, just sets four global variables
#'
#' @param df_grocery_only a data frame containing only grocery store observations.
#' Returned from a call to the googleway::google_places api.
#' @param df_geocode a data frame containing only the lat and lng values of a geocoded
#' address. The geocode is returned from googleway::google_geocode.
#'
#'
#' @importFrom oce lonlat2utm
#' @importFrom dplyr %>%, filter
#'
#' @returns ADD RETURNED OBJECTS AND THEIR DESCRIPTION HERE


Distance_Comparator <- function(df_grocery_only, df_geocode) {

  #Creates a new dataframe with the Lat, Long, and Name columns
  #This step is completely unnecessary, but the original DF
  #had awful column names and I didn't want to have to look at all
  #the other columns
  api_stores <- data.frame( Name = df_grocery_only$name,
                            lat = df_grocery_only$lat,
                            lng = df_grocery_only$lng)

  #Add Northing and Easting Columns
  UTM_geo <- lonlat2utm(longitude = df_geocode$lng,
                        latitude = df_geocode$lat,
                        zone = UTM_Zoner(abs(api_stores$lng[1])))
  df_geocode <- cbind(df_geocode, UTM_geo)

  UTM_df <- lonlat2utm(longitude = api_stores$lng,
                       latitude = api_stores$lat,
                       zone = UTM_Zoner(abs(api_stores$lng[1])))
  api_stores <- cbind(api_stores, UTM_df)

  # Save variables for testing.
  #this is not a test I need this
  origin_test <- c(df_geocode$easting, df_geocode$northing)
  end_test <- matrix(c(api_stores$easting, api_stores$northing), ncol = 2)


  #### FUNCTION TEST - Call Function
  #this is not a test function, this is integral to the program functionality
  #this saves a global variable named df_new with the distance appended
  Distance_Euclidean(api_stores, origin = origin_test, end = end_test)



  # Create Dataframes with stores in each quadrant

  #Creates a new dataframe with all of the stores in each quadrant
  northeast_stores <- df_new %>% filter(as.numeric(df_new$northing)
                                        > as.numeric(df_geocode$northing[1])
                                        & as.numeric(df_new$easting)
                                        > as.numeric(df_geocode$easting[1]))

  northwest_stores <- df_new %>% filter(as.numeric(df_new$northing)
                                        > as.numeric(df_geocode$northing[1])
                                        & as.numeric(df_new$easting)
                                        < as.numeric(df_geocode$easting[1]))


  southeast_stores <- df_new %>% filter(as.numeric(df_new$northing)
                                        < as.numeric(df_geocode$northing[1])
                                        & as.numeric(df_new$easting)
                                        > as.numeric(df_geocode$easting[1]))

  southwest_stores <- df_new %>% filter(as.numeric(df_new$northing)
                                        < as.numeric(df_geocode$northing[1])
                                        & as.numeric(df_new$easting)
                                        < as.numeric(df_geocode$easting[1]))


  # Find distance to nearest in each quadrant

  #I guess in a conversion somewhere the value is being squared. Square rooting
  #Makes this correct.
  #Using %/%1 to remove decimal point
  northeast_dist <<- sqrt(min(northeast_stores$distance_vector))%/%1
  northwest_dist <<-sqrt(min(northwest_stores$distance_vector))%/%1
  southeast_dist <<- sqrt(min(southeast_stores$distance_vector))%/%1
  southwest_dist <<- sqrt(min(southwest_stores$distance_vector))%/%1


  #df_new but with only closest stores named df_circle_buffer
  NE_min <- northeast_stores %>% filter(northeast_stores$distance_vector
                                        ==min(northeast_stores$distance_vector))
  NW_min <- northwest_stores %>% filter(northwest_stores$distance_vector
                                        ==min(northwest_stores$distance_vector))
  SE_min <- southeast_stores %>% filter(southeast_stores$distance_vector
                                        ==min(southeast_stores$distance_vector))
  SW_min <- southwest_stores %>% filter(southwest_stores$distance_vector
                                        ==min(southwest_stores$distance_vector))
  return(df_circle_buffer <- rbind(NE_min,NW_min,SE_min,SW_min))
  #add NESW labels


}
