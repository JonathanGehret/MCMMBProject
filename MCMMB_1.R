#package librarys

#install.packages("rgbif")
#install.packages("protolite")
library(rgdal)
library(raster)
library(rgbif) # api access for gbif
#library(maptools)
library(protolite) # needed for rgbif::mvt_fetch 

#Daten einlesen

# setwd("/data")
# working directory = project directory!

# ich würde vorschlagen, den working space zum Ort der Projekt-datei zu setzen und dann
# immer, wenn data benötigt wird, das entsprechend anzugeben, zb:
grid <- readOGR("data/Papua_Birdlife_project/Birdlife_Papua.shp", integer64="allow.loss")
# grid$SCINAME = Amaurornis moluccana -> Amaurornis moluccanus
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
bb = grid[312,]
ast_ni = grid[61,]
ast_sp = grid[62,]
mega = grid[284,]

head(first)
str(first)

# reading in island borders

regio <- readOGR("data/Papua_Birdlife_project/Papua_region.shp", integer64="allow.loss")

str(regio)
head(regio)
crs(regio)

# plotting
regio$ADM1_NAME
plot(regio[1,], add = T, col = "green")
plot(regio[2,], add = T, col = "blue")

plot(regio)
plot(first, add=T, col='blue')
plot(second, add=T, col = "red")
plot(antigone, add=T, col = "green")
plot(bb, add = T, col = "pink")
plot(ast_ni, add = T, col = "yellow")
plot(ast_sp, add = T, col = "turquoise")
plot(mega, add = T, col = "orange")

# random forsest
#import the package
#library(randomForest)
# Perform training:
#rf_classifier = randomForest(Species ~ ., data=training, ntree=100, mtry=2, importance=TRUE)
#rf_classifier
# https://www.blopig.com/blog/2017/04/a-very-basic-introduction-to-random-forests-using-r/

for (i in length(species)) {
  
}
  