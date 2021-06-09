#package librarys

library(rgdal)
library(raster)


#Daten einlesen

setwd("/data")

grid <- readOGR("Birdlife_Papua.shp", integer64="allow.loss")

#grid@proj4string <- CRS("+proj=longlat +ellps=WGS84 +no_defs") # remember to include coordinate system

str(grid)
head(grid)

first <- grid[1,]

head(first)
str(first)

plot(first)


regio <- readOGR("Papua_region.shp", integer64="allow.loss")

str(regio)
head(regio)



str(first)

plot(regio)
plot(first, add=T, col='blue')
