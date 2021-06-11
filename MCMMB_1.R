#package librarys

library(rgdal)
library(raster)

#Daten einlesen

setwd("/data")

# ich würde vorschlagen, den working space zum Ort der Projekt-datei zu setzen und dann
# immer, wenn data benötigt wird, das entsprechend anzugeben, zb:
grid <- readOGR("data/Papua_Birdlife_project/Birdlife_Papua.shp", integer64="allow.loss")
 
# grid <- readOGR("Birdlife_Papua.shp", integer64="allow.loss")

#grid@proj4string <- CRS("+proj=longlat +ellps=WGS84 +no_defs") # remember to include coordinate system

str(grid)
head(grid)

# Liste aller species:

species <- grid$SCINAME 
species <- data.frame(species)

# getting individual species

first <- grid[1,]
second <- grid[2,]
antigone <- grid[42,]

head(first)
str(first)

# reading in island borders

regio <- readOGR("data/Papua_Birdlife_project/Papua_region.shp", integer64="allow.loss")

str(regio)
head(regio)

regio$ADM1_NAME
plot(regio[1,], add = T, col = "green")
plot(regio[2,], add = T, col = "blue")


# plotting

plot(regio)
plot(first, add=T, col='blue')
plot(second, add=T, col = "red")
plot(antigone, add=T, col = "green")

# how to use gbif with R: https://www.youtube.com/watch?v=RACfDLBIL8A

# comparison gbif dataset for Antigone rubicunda (eine Reiher art)  
# https://www.gbif.org/species/9295466
# GBIF.org (09 June 2021) GBIF Occurrence Download https://doi.org/10.15468/dl.6m2srw



#gbif_antigone <- xmlParse(file= "data/gbif/antigone_rubicunda/dataset/4fa7b334-ce0d-4e88-aaae-2e0c138d049e.xml")
#str(gbif_antigone)
#plot(gbif_antigone)

antigone_occ = read.table("data/gbif/antigone_rubicunda/occurrence.txt")

