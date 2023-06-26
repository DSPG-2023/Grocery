#'@author Jay Maxwell
#install.packages("REAT")

library(tidycensus)
library(tidyverse)
library(sf)
library(REAT)

# BASIC Reilly Example ----
# https://rdrr.io/cran/REAT/man/reilly.html
# Example from Converse (1949):
reilly (39851, 37366, 27, 25)
# two cities (pop. size 39.851 and 37.366) 
# with distances of 27 and 25 miles to intermediate town
myresults <- reilly (39851, 37366, 27, 25)
myresults$prop_A
# proportion of location a
# Distance decay parameter for the given sales relation:
reilly (39851, 37366, 27, 25, gamma = 1, lambda = NULL, relation = 0.9143555)   
# returns 2


# Iowa Reilly Example ----
# Load population + geometry for all Iowa towns. Note the last parameters which
# allow usage of higher-resolution TIGER/Line data instead of cartographic
# boundary data
ia_towns <- get_decennial(geography = "place",
                          state="Iowa",
                          variables  = "DP1_0001C",
                          sumfile = "dp",
                          output = "wide",
                          geometry = TRUE,
                          cb=FALSE,
                          keep_geo_vars = TRUE
)

pop_a <- ia_towns %>% filter(NAME.x =="Ames") %>% pull(DP1_0001C)
pop_a

pop_b <- ia_towns %>% filter(NAME.x =="Marshalltown") %>% pull(DP1_0001C)
pop_b

# Let's use State Center as the intermediate town. 

ia_towns %>% filter(NAME.x =="Ames") %>% st_centroid() -> pt_a
ia_towns %>% filter(NAME.x == "Marshalltown") %>% st_centroid() -> pt_b
ia_towns %>% filter(NAME.x == "State Center") %>% st_centroid() -> pt_c

distA <- as.numeric(st_distance(pt_a, pt_c))
distA

distB <- as.numeric(st_distance(pt_b, pt_c))
distB

reilly(pop_a, pop_b, distA, distB)

# The closer proximity to State Center implies that MTown gets more retail 
# trade from State Center than does Ames, despite Ames' larger 
# population/actractivity



# Custom Reilly Example ----
# Do do this in a function....

custom_reilly <- function(a, b, c) {
  # input: three Iowa town names
  # assumptions: a data frame of ia_towns already in memory
  
  #print(paste0("Inputs: ", a, ", ", b, ", ", c))
  ia_towns %>% filter(NAME.x == a) %>% st_centroid() -> pt_a
  ia_towns %>% filter(NAME.x == b) %>% st_centroid() -> pt_b
  ia_towns %>% filter(NAME.x == c) %>% st_centroid() -> pt_c
  
  pop_a <- pt_a %>% pull(DP1_0001C)
  pop_b <- pt_b %>% pull(DP1_0001C)
  
  dist_a <- as.numeric(st_distance(pt_a, pt_c))
  dist_b <- as.numeric(st_distance(pt_b, pt_c))
  
  
  
  reilly(pop_a, pop_b, dist_a, dist_b)
  
}

# This needs to be run prior to the function call
# alternatively, this could be placed inside the function call
ia_towns <- get_decennial(geography = "place",
                          state="Iowa",
                          variables  = "DP1_0001C",
                          sumfile = "dp",
                          output = "wide",
                          geometry = TRUE,
                          cb=FALSE,
                          keep_geo_vars = TRUE
)

custom_reilly("Ames", "Marshalltown", "State Center")
custom_reilly("Ames", "Marshalltown", "Nevada")
custom_reilly("Waterloo", "Cedar Rapids", "Vinton")


# HUFF ----

## Huff Example 1 ----
# https://rdrr.io/cran/REAT/man/huff.html

# Example from Levy/Weitz (2009):

# Data for the existing and the new location
locations <- c("Existing Store", "New Store")
S_j <- c(5000, 10000)                ## What do these numbers represent??
location_data <- data.frame(locations, S_j)
location_data


# Data for the two communities (Rock Creek and Oak Hammock)
communities <- c("Rock Creek", "Oak Hammock")
C_i <- c(5000000, 3000000)           ## What do these numbers represent??
community_data <- data.frame(communities, C_i)
community_data


# Combining location and submarket data in the interaction matrix
interactionmatrix <- merge (communities, location_data)
interactionmatrix

# Adding driving time:
interactionmatrix[1,4] <- 10
interactionmatrix[2,4] <- 5
interactionmatrix[3,4] <- 5
interactionmatrix[4,4] <- 15
colnames(interactionmatrix) <- c("communities", "locations", "S_j", "d_ij")

interactionmatrix


huff_shares <- huff(interactionmatrix, "communities", "locations", "S_j", "d_ij")
huff_shares
# Market shares of the new location:
huff_shares$ijmatrix[huff_shares$ijmatrix$locations == "New Store",]


huff_all <- huff(interactionmatrix, "communities", "locations", "S_j", "d_ij",
                 localmarket_dataset = community_data, origin_id = "communities", localmarket = "C_i")

huff_all

huff_all$totals


# Apply using local data

## Ask Liesl for help!
