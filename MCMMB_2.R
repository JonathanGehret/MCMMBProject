#package librarys


library(rgdal)
library(raster)
library(rgeos)



#Daten einlesen

# birdlife --> shows the distriution of all spotted birds in papua

#birdlife <- readOGR("data/Papua_Birdlife_project/Birdlife_Papua.shp", integer64="allow.loss")


# nature reserve data

nature_reserve_project <- readOGR("data/Indicator/nature_reserve_papua/nature_reserve/nature_reserve.shp", integer64="allow.loss")
nature_reserve_project@proj4string = CRS("+proj=longlat +ellps=WGS84 +no_defs")

#Papua borders

papua_borders_project <- readOGR("data/Indicator/nature_reserve_papua/papua_borders/IDN_adm1.shp", integer64="allow.loss")
papua_borders_project@proj4string = CRS("+proj=longlat +ellps=WGS84 +no_defs")

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
#regio_temp <- raster("data/Indicator/Temperatur/regio_temp.tif")
#regio_temperature = raster("data/Indicator/Temperatur/regio_temp.tif") / 10
#writeRaster(regio_temperature, filename=file.path("C:/Users/Paul/Desktop/3_Semester/modern concepts and methods in macroecology and biogeography/Projekt/MCMMBProject/data/Indicator/Temperatur/regio_temperature"), format="GTiff", overwrite=TRUE)
regio_temperature = raster("data/Indicator/Temperatur/regio_temp.tif")

plot(regio_temperature)


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
land_reserv_project <- readOGR("data/Indicator/nature_reserve_papua/land_reserv/land_reserv.shp", integer64="allow.loss")

land_reserv_project@proj4string = CRS("+proj=longlat +ellps=WGS84 +no_defs")
# reading in island borders

regio_project <- readOGR("data/Papua_Birdlife_project/Papua_region.shp", integer64="allow.loss")
regio_project@proj4string = CRS("+proj=longlat +ellps=WGS84 +no_defs")

#Population-density
#popul <- raster("data/Indicator/population/idn_msk_pop.grd") 
#plot(popul)


#regio_popul <- intersect(popul, regio)
#plot(regio_popul)

#writeRaster(regio_popul, filename=file.path("C:/Users/Paul/Desktop/3_Semester/modern concepts and methods in macroecology and biogeography/Projekt/MCMMBProject/data/Indicator/population/regio_popul"), format="GTiff", overwrite=TRUE)
regio_popul <- raster("data/Indicator/population/idn_msk_pop.grd")
plot(regio_popul)



regio_population <- crop(regio_popul, regio_precip)

population_resampled <- projectRaster(regio_population,regio_precip,method = 'bilinear')
population_resampled

writeRaster(population_resampled, filename=file.path("data/Indicator/population/population_resampled"), format="GTiff", overwrite=TRUE)

population_resampled <- raster("data/Indicator/population/population_resampled.tif")
plot(population_resampled)




#Primary-forest
primforest <- raster("data/Indicator/Primary_Forest/Asia_2001_primary.tif")
plot(primforest)

regio_primforest <- crop(primforest, regio_precip)

primforest_resampled <- resample(regio_primforest,regio_precip,method = 'bilinear')
primforest_resampled
plot(primforest_resampled)

writeRaster(primforest_resampled, filename=file.path("C:/Users/Paul/Desktop/3_Semester/modern concepts and methods in macroecology and biogeography/Projekt/MCMMBProject/data/Indicator/Primary_Forest/primforest_resampled"), format="GTiff", overwrite=TRUE)
primforest_resampled <- raster("data/Indicator/Primary_Forest/primforest_resampled.tif")
plot(primforest_resampled)


#Landcover

landcover <- raster("data/Indicator/landcover/IDN_msk_cov.grd") 
plot(landcover)   

regio_precip <- raster("data/Indicator/Precipitation/regio_precip.tif")
plot(regio_precip)


regio_landcover <- crop(landcover, regio_precip)
plot(regio_landcover)


writeRaster(regio_landcover, filename=file.path("data/Indicator/landcover/regio_landcover"), format="GTiff", overwrite=TRUE)
regio_landcover <- raster("data/Indicator/landcover/regio_landcover.tif")
plot(regio_landcover)


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




#Verschneiden der shp-files mit der grid-shp-file 
land_reserv_project
nature_reserve_project
papua_borders_project






