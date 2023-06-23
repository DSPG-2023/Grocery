#'@author Jay Maxwell
#' Identifies States, Counties, and Cities from a given set of points.

library(sf)
library(dplyr)
library(tigris)
options(tigris_use_cache=TRUE)


get_county <- function(x) {
  #input: a single-row data frame, columns 1, 2 = lon, lat
  #                                column 3 = state name
  #output: x with extra column for county name
  counties <- counties(state=x[[3]])
  
  point <- st_as_sf(x, coords = c("lon", "lat"), crs=st_crs(counties))
  
  point %>%
    st_join(counties, join=st_intersects) %>%
    mutate(county = NAME) %>%
    select(county) %>%
    st_drop_geometry() -> county

    return(cbind(x, county) )
}




get_city <- function(x) {
  # input: a single-row data frame, columns 1, 2 = lon, lat
  #                                column 3 = state name
  # (does not require county column)
  # output: x with extra column for city name

  cities <- places(state=x[[3]])
  
  point <- st_as_sf(x, coords = c("lon", "lat"), crs=st_crs(cities))
  
  point %>%
    st_join(cities, join=st_intersects) %>%
    mutate(city = NAME) %>%
    select(city) %>%
    st_drop_geometry() -> city
  
  return(cbind(x, city) )
}


get_cities_in_county <- function(x) {
  #input: a single-row data frame, a column named "state"
  #                                a column named "county"
  #output: x with extra column for all the cities w/in a county
  
  state <- x[["state"]]
  county <- x[["county"]]
  
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

# Get states geographic data using TIGRIS, 
# Use TIGER/Line, not cb (cartographic boundary) files for best 
# resolution / results
states <- states()
plot(states$geometry)

# Make a layer with some random/fake coordinate
points <- data.frame(lon=c(-93, -92.9062656, -93.635049, -93, -93), lat=c(42, 42.0342997, 42.001649, 45, 33))
points <- data.frame(lon=c(-95.0520959), lat=c(42.3056645))
points

# Convert the points data frame into a spatial object
points_sf <- st_as_sf(points, coords = c("lon", "lat"), crs=st_crs(states))
points_sf



# Get the State ----

states_vector <- points_sf %>%
  st_join(states, join=st_intersects) %>%
  mutate(state = NAME) %>%
  select(state) %>%
  st_drop_geometry()

states_df <- cbind(points, states_vector)

states_df

# Get the County ----
# How can we find out which COUNTY a point lies in?
# Assumption: We already know what STATE it is in

# A new data frame to hold points + state + county
counties_df <- data.frame()


# Loop through every row in states_df, adds a column for county
for(i in 1:nrow(states_df)) {
  counties_df <- rbind(counties_df, get_county(states_df[i,]))  
}

# We now know which county each point lies in
counties_df



# Get the city ----
# A new data frame to holds points + state + county + city
city_df <- data.frame()

# Loop through every row in county_df, add a column for city
for(i in 1:nrow(counties_df)) {
  city_df <- rbind(city_df, get_city(counties_df[i,]))  
}

# This data frame now tells us what CITY the dot lies in
city_df



# Get all cities in county ----
# A new data frame to hold points + state + county + city + all the cities in the county
list_of_cities_df <- data.frame()

# Loop through every row in city_df, adding a column for the list of cities in the county
# this does not require the existence of the city column to function. 
# I am just doing this in a sequence
for(i in 1:nrow(city_df)) {
  list_of_cities_df <- rbind(list_of_cities_df, get_cities_in_county(city_df[i,]))  
}

# This data frame reads ugly in the console
list_of_cities_df

# Easier to read in View
View(list_of_cities_df)







# Working with Geographic Areas ----

# Get all counties using tigris
ia_counties <- counties(state = "Iowa")

# These plot statements are equivalent
plot(st_geometry(ia_counties))
ia_counties %>% st_geometry() %>% plot()

# Union all the counties to make a single feature
ia <- st_union(ia_counties)
ia   
ia %>% st_geometry() %>% plot()


# Filter four counties from central IA, union their geometry into a 
# single polygon
four_county_area <- ia_counties %>% 
  filter(NAME %in% c("Polk", "Dallas", "Boone", "Story")) %>% 
  st_union() %>% 
  st_sf()


# Plot the geometry - does that look like the expected outcome?
four_county_area %>% st_geometry() %>% plot()

# Plot multiple layers together to view
plot(st_geometry(ia), lwd=2)
plot(st_geometry(ia_counties), add=TRUE)
plot(st_geometry(four_county_area), col='red', add=TRUE)


# Let's make a three-sided polygon using the centroids of three Iowa
# counties as vertices

# First, filter the counties, find their centroids, extract the coordinates
tri_county_coords <- ia_counties %>% 
  filter(NAME %in% c("Tama", "Delaware", "Henry")) %>% 
  st_centroid() %>% 
  st_coordinates()

# These are the centroids of the counties selected above
tri_county_coords

# In order to make a closed polygon, we need to repeat the first & last coord
tri_county_coords <- rbind(tri_county_coords, tri_county_coords[1,])
tri_county_coords

# Turn the coordinates into a list, pass it to st_polygon,
# turn that into an sfc object, then turn that into an sf object
triangle <- tri_county_coords %>% 
  list() %>% 
  st_polygon() %>% 
  st_sfc(crs = st_crs(ia_counties)) %>% 
  st_sf()

# It's a triangle!
plot(st_geometry(triangle))

class(triangle)
st_crs(triangle)

# Plot multiple layers together to view
plot(st_geometry(ia), lwd=2)
plot(st_geometry(ia_counties), add=TRUE)
plot(st_geometry(four_county_area), col='red', add=TRUE)
plot(st_geometry(triangle), col='green', add=TRUE)



# One last area, using a buffered point

# First, filter the counties, find their centroids, extract the coordinates
cherokee_centroid <- ia_counties %>% 
  filter(NAME =="Cherokee") %>% 
  st_centroid()

# I am not sure what unit these are -- meters, maybe?
cherokee_buffer <- cherokee_centroid %>% 
  st_buffer(dist=50000)

# It looks like a circle!
cherokee_buffer %>% st_geometry() %>% plot()

# Plot multiple layers together to view
plot(st_geometry(ia), lwd=2)
plot(st_geometry(ia_counties), add=TRUE)
plot(st_geometry(four_county_area), col='red', add=TRUE)
plot(st_geometry(triangle), col='green', add=TRUE)
plot(st_geometry(cherokee_buffer), col="steelblue", add=TRUE)



# So now we have three geographic areas that overlay with Iowa counties
# Let's try to figure out which counties intersect these geometries

cherokee_buffer %>% 
  st_intersection(ia_counties) %>% 
  pull(NAME.1)

triangle %>% st_sf() %>% 
  st_intersection(ia_counties) %>% 
  pull(NAME)

# Sharing a border counts as an intersect!
four_county_area %>% 
  st_intersection(ia_counties) %>% 
  pull(NAME)




library(tidycensus)
v20 <- load_variables(2020, "dp")

# Load population + geometry for all Iowa towns. Note the last parameters which
# allow usage of higher-resolution TIGER/Line data instead of cartographic
# boundary data
ia_towns <- get_decennial(geography = "place",
                          state="Iowa",
                          variables  = "DP1_0001C",
                          sumfile = "dp",
                          geometry = TRUE,
                          cb=FALSE,
                          keep_geo_vars = TRUE
                          )

# Doing so gives us a way to filter out towns of certain sizes
pop_cutoff <- 1000

big_towns <- ia_towns %>% filter(value>=pop_cutoff)
big_towns

big_towns %>% st_geometry() %>% plot()

# What towns are in the geographic areas we have made?


triangle %>% st_intersection(big_towns) -> triangle_towns

plot(st_geometry(ia), lwd=2)
plot(st_geometry(ia_counties), add=TRUE)
plot(st_geometry(triangle), col='green', add=TRUE)
plot(st_geometry(triangle_towns), col='black', add=TRUE)


cherokee_buffer %>% st_intersection(big_towns) -> buffer_towns

plot(st_geometry(cherokee_buffer), col="steelblue", add=TRUE)
plot(st_geometry(buffer_towns), col='black', add=TRUE)



four_county_area %>% st_intersection(big_towns) -> four_county_towns

plot(st_geometry(four_county_area), col='red', add=TRUE)
plot(st_geometry(four_county_towns), col='black', add=TRUE)

# There is a small problem with this output, though... Look at the red counties...
# The city of Des Moines does not stop at the southern county line--the city
# limits go past that. However, our geometry is only the INTERSECTION of the 
# four-county area & big towns (Des Moines, etc.). If we want to accurately plot
# the towns that are not fully within an area, we need to find another method. 
# But this is a good start!!
#
# (This might be happening in the green triangle, too. But I don't know my eastern
# Iowa cities well enough to pick out if anything is being clipped.)

# Make a vector of just the town names, with no geometry
four_county_towns %>% pull(NAME.x) -> four_county_towns_names
four_county_towns_names

# Add a new layer to the plot of the towns from the list above
ia_towns %>% 
  filter(NAME.x %in% four_county_towns_names) %>% 
  st_geometry() %>% 
  plot(col="black", add=TRUE)

# Now, the southern portion of Des Moines, which falls outside of the red zone,
# will display properly. We should probably do the same for the other areas, 
# in case there are some boundary-crossing towns, but for this example, it's good 
# enough. 



