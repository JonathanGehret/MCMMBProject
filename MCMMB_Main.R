#package librarys

#install.packages("rgbif")
#install.packages("protolite")
library(rgdal)
library(raster)
library(rgbif) # api access for gbif
#library(maptools)
library(protolite) # needed for rgbif::mvt_fetch 
library(raster)
library(rgeos)
# Load the SimpleFeatures library
library(sf)


# loading of IUCN birdlife data
birdlife <- readOGR("data/Papua_Birdlife_project/Birdlife_Papua.shp", integer64="allow.loss")


# Liste aller species:
species <- birdlife$SCINAME 
species <- data.frame(species)

# reading in island borders

regio <- readOGR("data/Papua_Birdlife_project/Papua_region.shp", integer64="allow.loss")

# plotting

plot(regio)