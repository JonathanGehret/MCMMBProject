#package libraries

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
# for intersectiong with point.in.poly
library(spatialEco)


# loading of IUCN birdlife data
birdlife <- readOGR("data/Papua_Birdlife_project/Birdlife_Papua.shp", integer64="allow.loss")


# Liste aller species:
species <- birdlife$SCINAME 
species <- data.frame(species)

# drop Amaurornis moluccanus/Amaurornis moluccana (#33)
# drop Threskiornis molucca/Threskiornis moluccus (#526)
species = species[-c(33,527),]
species = data.frame(species)

for (i in 1:nrow(species)) {
  print(i)
  print(species$species[i])
  species$key[i] = name_suggest(species$species[i])$data[1]
}

# reading in island borders

regio <- readOGR("data/Papua_Birdlife_project/Papua_region.shp", integer64="allow.loss")

# plotting

plot(regio)
