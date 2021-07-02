#package libraries

#install.packages("rgbif")
#install.packages("protolite")
#install.packages("biomod2")
library(biomod2)
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


# iucn birdlife species names dataframe:
species <- birdlife$SCINAME 
species <- data.frame(species)

# drop Amaurornis moluccanus/Amaurornis moluccana (#33)
# drop Threskiornis molucca/Threskiornis moluccus (#527) # are these numbers correct?
#species = species[-c(33,527),] # better: instead of deleting, replace with respective names
species[33,] = "Amaurornis moluccanus"
species[527,] = "Threskiornis molucca"
species = data.frame(species)

# adding keys to species dataframe (obsoloete now?)
for (i in 1:nrow(species)) {
  print(i)
  print(species$species[i])
  species$key[i] = name_suggest(species$species[i])$data[1]
}

# reading in island borders

regio <- readOGR("data/Papua_Birdlife_project/Papua_region.shp", integer64="allow.loss")

# plotting

plot(regio)


# all birbs indonesia gbif (compare scipt MCMMB_GBIF_02.R)
# ind_birbs
ind_birbs = read.csv("data/gbif/aves_indonesia/0303155-200613084148143.csv",header = TRUE, sep = "\t")
ind_birbs_corrected = ind_birbs[!(is.na(ind_birbs$decimalLatitude) | ind_birbs$decimalLatitude=="" | is.na(ind_birbs$decimalLongitude) | ind_birbs$decimalLongitude==""),]

# create points
ind_birbs_points = st_as_sf(ind_birbs_corrected, coords = c("decimalLongitude","decimalLatitude"), crs = 4326)

#crop to indonesian papua