library(geosphere)





Haversine_Calculator <- function(df_grocery_only, df_geocode) {

  #Creates a new dataframe with the Lat, Long, and Name columns
  #This step is completely unnecessary, but the original DF
  #had awful column names and I didn't want to have to look at all
  #the other columns
  api_stores <- data.frame( Name = df_grocery_only$name,
                            lat = df_grocery_only$lat,
                            lng = df_grocery_only$lng)
  #browser()

  #Add Northing and Easting Columns
  UTM_geo <- lonlat2utm(longitude = df_geocode$lng,
                        latitude = df_geocode$lat,
                        zone = UTM_Zoner(abs(api_stores$lng[1])))
  df_geocode <- cbind(df_geocode, UTM_geo)

  UTM_df <- lonlat2utm(longitude = api_stores$lng,
                       latitude = api_stores$lat,
                       zone = UTM_Zoner(abs(api_stores$lng[1])))
  api_stores <- cbind(api_stores, UTM_df)



  #Create a matrix of GPS coordinates and find distances
  all_stores_matrix <- matrix(data = c(df_grocery_only$lng,
                                 df_grocery_only$lat), ncol = 2)

  all_stores_dist <- distHaversine(p1 = c(df_geocode$lng, df_geocode$lat), p2 = points)

  df_new <- cbind(api_stores, all_stores_dist)


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
  northeast_dist <- (min(northeast_stores$all_stores_dist))%/%1
  northwest_dist <-(min(northwest_stores$all_stores_dist))%/%1
  southeast_dist <- (min(southeast_stores$all_stores_dist))%/%1
  southwest_dist <- (min(southwest_stores$all_stores_dist))%/%1


  #df_new but with only closest stores named df_circle_buffer
  NE_min <- northeast_stores %>% filter(northeast_stores$all_stores_dist
                                        ==min(northeast_stores$all_stores_dist))
  NW_min <- northwest_stores %>% filter(northwest_stores$all_stores_dist
                                        ==min(northwest_stores$all_stores_dist))
  SE_min <- southeast_stores %>% filter(southeast_stores$all_stores_dist
                                        ==min(southeast_stores$all_stores_dist))
  SW_min <- southwest_stores %>% filter(southwest_stores$all_stores_dist
                                        ==min(southwest_stores$all_stores_dist))
  df_circle_buffer <- rbind(NE_min,NW_min,SE_min,SW_min)

  Distance_Comp_List <- list(northeast_dist = northeast_dist,
                             northwest_dist = northwest_dist,
                             southeast_dist = southeast_dist,
                             southwest_dist = southwest_dist,
                             df_circle_buffer = df_circle_buffer)


  return(Distance_Comp_List)
}
