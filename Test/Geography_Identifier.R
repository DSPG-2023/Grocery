#'@author Jay Maxwell
#' Identifies States, Counties, and Cities from a given set of points.

library(sf)
library(dplyr)
library(tigris)
options(tigris_use_cache=TRUE)


get_county <- function(x) {

  counties <- counties(state=x[[3]])

  point <- st_as_sf(x, coords = c("lon", "lat"))
  st_crs(point) <- st_crs(counties)

  point %>%
    st_join(counties, join=st_intersects) %>%
    mutate(county = NAME) %>%
    select(county) %>%
    st_drop_geometry() -> county

    return(cbind(x, county) )
}




get_city <- function(x) {

  cities <- places(state=x[[3]])

  point <- st_as_sf(x, coords = c("lon", "lat"))
  st_crs(point) <- st_crs(cities)

  point %>%
    st_join(cities, join=st_intersects) %>%
    mutate(city = NAME) %>%
    select(city) %>%
    st_drop_geometry() -> city

  return(cbind(x, city) )
}


get_cities_in_county <- function(x) {

  state <- x[[3]]
  county <- x[[4]]

  # Get TIGER/Line geometry for all the counties and cities/places
  # in our state of interest
  cities <- places(state=state)
  counties <- counties(state=state)

  counties %>%
    filter(NAME == county) %>%
    st_join(cities, join=st_intersects) %>%
    pull(NAME.y) %>%
    sort() %>%
    paste(collapse = ", ") -> city_list

  return(cbind(x, city_list))

}

# Inititial Setup ----
# Make a layer with some random/fake coordinate
points <- data.frame(lon=c(-93, -92.9062656, -93.635049, -93, -93), lat=c(42, 42.0342997, 42.001649, 45, 33))
points <- data.frame(lon=c(-95.0520959), lat=c(42.3056645))
points

# Convert the points data frame into a spatial object
points_sf <- st_as_sf(points, coords = c("lon", "lat"))
points_sf

# Get states geographic data using TIGRIS,
# Use TIGER/Line, not cb (cartographic boundary) files for best
# resolution / results
states <- states()
plot(states$geometry)

# Set the CRS of the points_sf layer to match the states layer
st_crs(points_sf) <- st_crs(states)

# Examine the initial non-spatial points data again
points


# Get the State ----
states_df <- cbind(points, points_sf %>%
                     st_join(states, join=st_intersects) %>%
                     mutate(state = NAME) %>%
                     select(state) %>%
                     st_drop_geometry())

states_df

 # Get the County ----
# How can we find out which COUNTY a point lies in?
# Assumption: We already know what STATE it is in

# A new data frame to hold points + state + county
counties_df <- data.frame()

for(i in 1:nrow(states_df)) {
  counties_df <- rbind(counties_df, get_county(states_df[i,]))
}

# We now know which county each point lies in
counties_df



# Get the city ----
# A new data frame to holds points + state + county + city
city_df <- data.frame()
for(i in 1:nrow(counties_df)) {
  city_df <- rbind(city_df, get_city(counties_df[i,]))
}

# This data frame now tells us what CITY the dot lies in
city_df



# Get all cities in county ----
# A new data frame to hold points + state + county + city + all the cities in the county

expanded_cities_df <- data.frame()
for(i in 1:nrow(counties_df)) {
  expanded_cities_df <- rbind(expanded_cities_df, get_cities_in_county(city_df[i,]))
}

expanded_cities_df
View(expanded_cities_df)







## Testing Area ----

ia_cities <- places(state="IA")
i =1
x =city_df[i,]
x


# 42.3056645,-95.0520959 try this coordinate
