#package libraries


#library(rgdal)
#library(raster)
#library(rgeos)



#Read in Data

#regio <- readOGR("data/Papua_Birdlife_project/Papua_region.shp", integer64="allow.loss")
#plot(regio)

#elevation map

elev <- raster("data/Indicator/elevation/mn30_grd")
plot(elev)

e <- mask(elev,regio)
Elevation <- crop(x = e, y = extent(regio))
plot(Elevation)

#writeRaster(Elevation, filename=file.path("C:/Users/Paul/Desktop/3_Semester/modern concepts and methods in macroecology and biogeography/Projekt/MCMMBProject/data/indicator_stack/Elevation"), format="GTiff", overwrite=TRUE)
#writeRaster(Elevation, filename=file.path("data/indicator_stack/Elevation"), format="GTiff", overwrite=TRUE)


#Temperature

temp <- raster("data/Indicator/CHELSA_bio10_01.tif") 

regio_temp <- mask(temp,regio)
r_temp <- crop(x = regio_temp, y = extent(regio))
plot(r_temp)

#writeRaster(r_temp, filename=file.path("C:/Users/Paul/Desktop/3_Semester/modern concepts and methods in macroecology and biogeography/Projekt/MCMMBProject/data/Indicator/Temperatur/r_temp"), format="GTiff", overwrite=TRUE)
#writeRaster(r_temp, filename=file.path("data/Indicator/Temperatur/r_temp"), format="GTiff", overwrite=TRUE)

#Temperature = raster("data/Indicator/Temperatur/r_temp.tif") / 10  # temperature*10
Temperature = r_temp / 10  # temperature*10
plot(Temperature)
#writeRaster(Temperature, filename=file.path("C:/Users/Paul/Desktop/3_Semester/modern concepts and methods in macroecology and biogeography/Projekt/MCMMBProject/data/indicator_stack/Temperature"), format="GTiff", overwrite=TRUE)
#writeRaster(Temperature, filename=file.path("data/indicator_stack/Temperature"), format="GTiff", overwrite=TRUE)


#Precipitation

precip <- raster("data/Indicator/CHELSA_bio10_12.tif") # precipitation

Precip_mask <- mask(precip,regio)
Precipitation <- crop(x = Precip_mask, y = extent(regio))
plot(Precipitation)

#writeRaster(Precipitation, filename=file.path("C:/Users/Paul/Desktop/3_Semester/modern concepts and methods in macroecology and biogeography/Projekt/MCMMBProject/data/indicator_stack/Precipitation"), format="GTiff", overwrite=TRUE)
#writeRaster(Precipitation, filename=file.path("data/indicator_stack/Precipitation"), format="GTiff", overwrite=TRUE)

#Population-density

regio_popul <- raster("data/Indicator/population/idn_msk_pop.grd")

pop_mask <- mask(regio_popul,regio)

Human_Population <- crop(x = pop_mask, y = extent(regio))
plot(Human_Population)


#writeRaster(Human_Population, filename=file.path("C:/Users/Paul/Desktop/3_Semester/modern concepts and methods in macroecology and biogeography/Projekt/MCMMBProject/data/indicator_stack/Human_Population"), format="GTiff", overwrite=TRUE)
#writeRaster(Human_Population, filename=file.path("data/indicator_stack/Human_Population"), format="GTiff", overwrite=TRUE)


#Primary-forest
primforest <- raster("data/Indicator/Primary_Forest/Asia_2001_primary.tif")
prim_mask <- mask(primforest,regio)

Primary_forest <- crop(x = prim_mask, y = extent(regio))
plot(Primary_forest)

#writeRaster(Primary_forest, filename=file.path("C:/Users/Paul/Desktop/3_Semester/modern concepts and methods in macroecology and biogeography/Projekt/MCMMBProject/data/indicator_stack/Primary_forest"), format="GTiff", overwrite=TRUE)
#writeRaster(Primary_forest, filename=file.path("data/indicator_stack/Primary_forest"), format="GTiff", overwrite=TRUE)


#Landcover

landcover <- raster("data/Indicator/landcover/IDN_msk_cov.grd") 
plot(landcover)   

land_mask <- mask(landcover,regio)
Landcover <- crop(x = land_mask, y = extent(regio))
plot(Landcover)

#writeRaster(Landcover, filename=file.path("C:/Users/Paul/Desktop/3_Semester/modern concepts and methods in macroecology and biogeography/Projekt/MCMMBProject/data/indicator_stack/Landcover"), format="GTiff", overwrite=TRUE)
#writeRaster(Landcover, filename=file.path("data/indicator_stack/Landcover"), format="GTiff", overwrite=TRUE)


# plotting

plot(regio)

plot(Elevation)
plot(regio, add=T)

plot(Precipitation)
plot(regio, add=T)

plot(Temperature)
plot(regio, add=T)

plot(Human_Population)
plot(regio, add=T)

plot(Primary_forest)
plot(regio, add=T)

