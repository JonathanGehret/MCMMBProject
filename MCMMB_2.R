#package librarys


library(rgdal)
library(raster)


#Daten einlesen

# birdlife --> shows the distriution of all spotted birds in papua

#birdlife <- readOGR("data/Papua_Birdlife_project/Birdlife_Papua.shp", integer64="allow.loss")


# nature reserve data

nature_reserve <- readOGR("data/Indicator/nature_reserve_papua/nature_reserve/nature_reserve.shp", integer64="allow.loss")

#Papua borders

papua_borders <- readOGR("data/Indicator/nature_reserve_papua/papua_borders/IDN_adm1.shp", integer64="allow.loss")


#elevation map
#elev <- raster("data/Indicator/elevation/mn30_grd")
#par(mfrow=c(1,1))
#plot(elev)


#regio_elev <- intersect(elev, regio)
#plot(regio_elev)
#writeRaster(regio_elev, filename=file.path("C:/Users/Paul/Desktop/3_Semester/modern concepts and methods in macroecology and biogeography/Projekt/MCMMBProject/data/Indicator/elevation/regio_elev"), format="GTiff", overwrite=TRUE)

regio_elev <- raster("data/Indicator/elevation/regio_elev.tif")
plot(regio_elev)

#Temperatur
#temp <- raster("data/Indicator/CHELSA_bio10_01.tif") # temperature*10
#regio_temp <- intersect(temp, regio)
#plot(regio_temp)

#writeRaster(regio_temp, filename=file.path("C:/Users/Paul/Desktop/3_Semester/modern concepts and methods in macroecology and biogeography/Projekt/MCMMBProject/data/Indicator/Temperatur/regio_temp"), format="GTiff", overwrite=TRUE)
regio_temp <- raster("data/Indicator/Temperatur/regio_temp.tif")
plot(regio_temp)


#Precipitation

#precip <- raster("data/Indicator/CHELSA_bio10_12.tif") # precipitation
#regio_precip <- intersect(precip, regio)
#plot(regio_precip)

#writeRaster(regio_precip, filename=file.path("C:/Users/Paul/Desktop/3_Semester/modern concepts and methods in macroecology and biogeography/Projekt/MCMMBProject/data/Indicator/Precipitation/regio_precip"), format="GTiff", overwrite=TRUE)
regio_precip <- raster("data/Indicator/Precipitation/regio_precip.tif")
plot(regio_precip)




#intersect land_reserv

#land_reserv <- intersect(regio, nature_reserve)
#plot(land_reserv)
#plot(regio)
#plot(land_reserv, add = T, col = "green")
#writeOGR(land_reserv, dsn ="C:/Users/Paul/Desktop/3_Semester/modern concepts and methods in macroecology and biogeography/Projekt/MCMMBProject/data/Indicator/nature_reserve_papua", layer= "land_reserv", driver = "ESRI Shapefile")

#land-reserv
land_reserv <- readOGR("data/Indicator/nature_reserve_papua/land_reserv/land_reserv.shp", integer64="allow.loss")


# reading in island borders

regio <- readOGR("data/Papua_Birdlife_project/Papua_region.shp", integer64="allow.loss")


#Population-density
#popul <- raster("data/Indicator/population/idn_msk_pop.grd") 
#plot(popul)


#regio_popul <- intersect(popul, regio)
#plot(regio_popul)

#writeRaster(regio_popul, filename=file.path("C:/Users/Paul/Desktop/3_Semester/modern concepts and methods in macroecology and biogeography/Projekt/MCMMBProject/data/Indicator/population/regio_popul"), format="GTiff", overwrite=TRUE)
regio_popul <- raster("data/Indicator/population/regio_popul.tif")
plot(regio_popul)





#Primary-forest
primforest <- raster("data/Indicator/Primary_Forest/Asia_2001_primary.tif") 
plot(primforest)


regio_primforest <- intersect(primforest, regio)
plot(regio_primforest)

writeRaster(regio_primforest, filename=file.path("C:/Users/Paul/Desktop/3_Semester/modern concepts and methods in macroecology and biogeography/Projekt/MCMMBProject/data/Indicator/Primary_Forest/regio_primforest"), format="GTiff", overwrite=TRUE)
regio_primforest <- raster("data/Indicator/Primary_Forest/regio_primforest.tif")
plot(regio_primforest)




# plotting

plot(regio)
plot(papua_borders, add=T, col = "red")
plot(land_reserv, add=T, col='blue')


plot(regio_elev)
plot(regio, add=T)

plot(regio_precip)
plot(regio, add=T)

plot(regio_temp)
plot(regio, add=T)

plot(regio_popul)
plot(regio, add=T)

plot(regio_primforest)
plot(regio, add=T)
