#package librarys

#install.packages("rgbif")
#install.packages("protolite")
library(rgdal)
library(raster)
library(rgbif) # api access for gbif
#library(maptools)
library(protolite) # needed for rgbif::mvt_fetch 

#Daten einlesen

# working directory = project directory!

# ich würde vorschlagen, den working space zum Ort der Projekt-datei zu setzen und dann
# immer, wenn data benötigt wird, das entsprechend anzugeben, zb:
birdlife <- readOGR("data/Papua_Birdlife_project/Birdlife_Papua.shp", integer64="allow.loss")
# birdlife$SCINAME = Amaurornis moluccana -> Amaurornis moluccanus
# birdlife <- readOGR("Birdlife_Papua.shp", integer64="allow.loss")

#birdlife@proj4string <- CRS("+proj=longlat +ellps=WGS84 +no_defs") # remember to include coordinate system

str(birdlife)
head(birdlife)

# Liste aller species:

species <- birdlife$SCINAME 
species <- data.frame(species)

# getting individual species

first <- birdlife[1,]
second <- birdlife[2,]
antigone <- birdlife[42,]
bb = birdlife[312,]
ast_ni = birdlife[61,]
ast_sp = birdlife[62,]
mega = birdlife[284,]

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
plot(antigone, add=T, col = "yellow")
plot(bb, add = T, col = "pink")
plot(ast_ni, add = T, col = "yellow")
plot(ast_sp, add = T, col = "turquoise")
plot(mega, add = T, col = "orange")

# get row number of species name and plot that species
#species_name = "Melloria quoyi"
#species_name = "Dacelo gaudichaud"
species_name = "Cyclopsitta diophthalma"
species_name = 
species_name = 
species_name = 
species_name = 
species_nr = which(species$species == species_name) + 1
plot(birdlife[species_nr,], add=T, col = "green")


# random forsest
#import the package
#library(randomForest)
# Perform training:
#rf_classifier = randomForest(Species ~ ., data=training, ntree=100, mtry=2, importance=TRUE)
#rf_classifier
# https://www.blopig.com/blog/2017/04/a-very-basic-introduction-to-random-forests-using-r/

par(mfrow=c(4,4))
for (i in 1:length(species$species)) {
#for (i in 1:16) {
  #print(i)
  plot(regio, main = paste(birdlife[i,]$SCINAME, i))
  plot(birdlife[i,], add=T, col = "green")
}

#par(mfrow=c(1,1))
#plot(regio, main="test")

png("range_maps/asdf.png")
