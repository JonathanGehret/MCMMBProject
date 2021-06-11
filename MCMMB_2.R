#package librarys


library(rgdal)
library(raster)


#Daten einlesen

#setwd("/data")

# ich würde vorschlagen, den working space zum Ort der Projekt-datei zu setzen und dann
# immer, wenn data benötigt wird, das entsprechend anzugeben, zb:
grid <- readOGR("data/Papua_Birdlife_project/Birdlife_Papua.shp", integer64="allow.loss")

# grid <- readOGR("Birdlife_Papua.shp", integer64="allow.loss")

#grid@proj4string <- CRS("+proj=longlat +ellps=WGS84 +no_defs") # remember to include coordinate system

# nature reserve data

nature_reserve <- readOGR("data/Indicator/nature_reserve_papua/nature_reserve/nature_reserve.shp", integer64="allow.loss")
papua_borders <- readOGR("data/Indicator/nature_reserve_papua/papua_borders/IDN_adm1.shp", integer64="allow.loss")

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

regio <- readOGR("data/gbif/Papua_Birdlife_project/Papua_region.shp", integer64="allow.loss")

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
plot(nature_reserve, add=T, col= "purple")
plot(papua_borders, add=T, col= "orange")


