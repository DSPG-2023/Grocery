Auto_Pct <- function(northeast_dist,northwest_dist,southeast_dist,southwest_dist, df_city_pop, geo_county) {
  sum_val <- sum(Quadrant_Area(northeast_dist),Quadrant_Area(northwest_dist),
                 Quadrant_Area(southeast_dist),Quadrant_Area(southwest_dist))
  county_tigris <- counties(state = df_city_pop$State)
  county_tigris <- county_tigris %>% filter(county_tigris$NAME == geo_county)
  county_size = county_tigris$ALAND
  return(sum_val / county_size)
}
