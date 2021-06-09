#package librarys

library(rgdal)
library(raster)


#Daten einlesen

setwd("/data")

# ich würde vorschlagen, den working space zum Ort der Projekt-datei zu setzen und dann
# immer, wenn data benötigt wird, das entsprechend anzugeben, zb:
# grid <- readOGR("data/Birdlife_Papua.shp", integer64="allow.loss")
 
grid <- readOGR("Birdlife_Papua.shp", integer64="allow.loss")

#grid@proj4string <- CRS("+proj=longlat +ellps=WGS84 +no_defs") # remember to include coordinate system

str(grid)
head(grid)

# Liste aller species:

species <- grid$SCINAME 
species <- data.frame(species)

# getting individual species

first <- grid[1,]
second <- grid[2,]

head(first)
str(first)

# reading in island borders

regio <- readOGR("Papua_region.shp", integer64="allow.loss")

str(regio)
head(regio)

# plotting

plot(regio)
plot(first, add=T, col='blue')
plot(second, add=T, col = "red")
