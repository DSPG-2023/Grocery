#'
#' @author Alex Cory
#'
#' @description
#' Finds the distance to the nearest store in each quadrant.
#' No return, just sets four global variables
#'
#' @param df_places_grocery API call with nearby stores
#'
#' @importFrom oce lonlat2ut


Distance_Comparator <- function(df_places_grocery) {

  #Creates a new dataframe with the Lat, Long, and Name columns
  #This step is completely unnecessary, but the original DF
  #had awful column names and I didn't want to have to look at all
  #the other columns
  api_stores <- data.frame( Name = df_places_grocery$name,
                            Lat = df_places_grocery$geometry$location$lat,
                            Long = df_places_grocery$geometry$location$lng)

  #Add Northing and Easting Columns
  UTM_geo <- oce::lonlat2utm(longitude = df_geocode$lng,
                             latitude = df_geocode$lat,
                             zone = UTM_Zoner(abs(api_stores$Long[1])))
  df_geocode <- cbind(df_geocode, UTM_geo)

  UTM_df <- oce::lonlat2utm(longitude = api_stores$Long,
                            latitude = api_stores$Lat,
                            zone = UTM_Zoner(abs(api_stores$Long[1])))
  api_stores <- cbind(api_stores, UTM_df)


  #Defines euclidean distance function
  api_stores %>% mutate(Distance = c(euclidean(a <- c(Lat, Long), b <- c(df_geocode$lat, df_geocode$lng))))






  #### FUNCTION TEST - Assign Test Variables

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
