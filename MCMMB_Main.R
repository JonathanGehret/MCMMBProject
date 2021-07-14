#package libraries

library(biomod2)
library(rgdal)
library(raster)
library(rgbif) # api access for gbif
#library(maptools)
library(protolite) # needed for rgbif::mvt_fetch 
library(rgeos)
# Load the SimpleFeatures library
library(sf)
# for intersectiong with point.in.poly
library(spatialEco)
# for removing speicies with n < threshold 
library(dplyr)

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

"# adding keys to species dataframe (obsoloete now?)
for (i in 1:nrow(species)) {
  print(i)
  print(species$species[i])
  species$key[i] = name_suggest(species$species[i])$data[1]
}"

# reading in island borders

regio <- readOGR("data/Papua_Birdlife_project/Papua_region.shp", integer64="allow.loss")

# plotting

#plot(regio)


# all birbs indonesia gbif (compare scipt MCMMB_GBIF_02.R)
# remove all unnecessary columns
# ind_birbs
gbif_birds = read.csv("data/gbif/aves_indonesia/0303155-200613084148143.csv",header = TRUE, sep = "\t")
gbif_birds_corrected = gbif_birds[!(is.na(gbif_birds$decimalLatitude) | gbif_birds$decimalLatitude=="" | is.na(gbif_birds$decimalLongitude) | gbif_birds$decimalLongitude==""),]

# create points
gbif_points = st_as_sf(gbif_birds_corrected, coords = c("decimalLongitude","decimalLatitude"), crs = 4326)

#crop to indonesian papua
gbif_crop_all = st_crop(gbif_points, regio)

#remove birds with occurance < x
# https://stackoverflow.com/questions/37497763/r-delete-rows-in-data-frame-where-nrow-of-index-is-smaller-than-certain-value
# using 100 as per Van-Proosdij et al. (2016)
gbif_crop = gbif_crop_all %>% group_by(species) %>% filter(n() >= 100 ) %>% ungroup()
#gbif_crop = gbif_crop_all
# species list 
species = sort(unique(gbif_crop$species))
#species = sort(unique(gbif_crop_all$species))


# for plotting:
#plot(regio)
#plot(st_geometry(gbif_crop[gbif_crop$species == ""]), add = TRUE)

#source("MCMMB_2.R")