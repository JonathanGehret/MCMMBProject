#package librarys


library(rgdal)
library(raster)


#Daten einlesen


birdlife <- readOGR("data/Papua_Birdlife_project/Birdlife_Papua.shp", integer64="allow.loss")


# nature reserve data

nature_reserve <- readOGR("data/Indicator/nature_reserve_papua/nature_reserve/nature_reserve.shp", integer64="allow.loss")

#Papua borders

papua_borders <- readOGR("data/Indicator/nature_reserve_papua/papua_borders/IDN_adm1.shp", integer64="allow.loss")


#elevation map
elev <- raster("data/Indicator/elevationmn30_grd")


#Temperatur
bio1 <- raster("data/CHELSA_bio10_01.tif") # temperature*10

#Precipitation
bio12 <- raster("data/CHELSA_bio10_12.tif") # precipitation


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
plot(grid)
plot(regio[1,], add = T, col = "green")
plot(regio[2,], add = T, col = "blue")


#intersect land_reserv

#land_reserv <- intersect(regio, nature_reserve)
#plot(land_reserv)
#plot(regio)
#plot(land_reserv, add = T, col = "green")
#writeOGR(land_reserv, dsn ="C:/Users/Paul/Desktop/3_Semester/modern concepts and methods in macroecology and biogeography/Projekt/MCMMBProject/data/Indicator/nature_reserve_papua", layer= "land_reserv", driver = "ESRI Shapefile")

#land-reserv
land_reserv <- readOGR("data/Indicator/nature_reserve_papua/land_reserv.shp", integer64="allow.loss")


# plotting

plot(regio)
plot(first, add=T, col='blue')
plot(second, add=T, col = "red")
plot(antigone, add=T, col = "green")
plot(nature_reserve, add=T, col= "purple")
plot(papua_borders, add=T, col= "orange")


