#package librarys

#install.packages("rgbif")
library(rgdal)
library(raster)
library(rgbif) # api access for gbif
library(maptools)

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


# plotting
regio$ADM1_NAME
plot(regio[1,], add = T, col = "green")
plot(regio[2,], add = T, col = "blue")

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

# trying rgbif
# https://damariszurell.github.io/HU-GCIB/1_Data.html
# https://cran.r-project.org/web/packages/rgbif/rgbif.pdf

# Check out the number of occurrences found in GBIF:
occ_count()

# number of observations:
occ_count(basisOfRecord='OBSERVATION')

# number of occurrences reported for Germany:
occ_count(country=isocodes[grep("Germany", isocodes$name), "code"])

# number of observations reported for Germany:
occ_count(country=isocodes[grep("Germany", isocodes$name), "code"],basisOfRecord='OBSERVATION')

# adjusted for antigone
# Check for synonyms
name_suggest(q='Antigone rubicunda', rank='species')
# no synonyms

# Check number of records
occ_search(scientificName = "Antigone rubicunda", limit = 10)

# downloading and plotting
# gbif_antigone <- occ_search(scientificName = "Antigone rubicunda",return='data', limit=500)
occ_key <- name_suggest('Antigone rubicunda')$key[1]
dat <- occ_search(taxonKey = occ_key, limit = 3, hasCoordinate = TRUE)
# head( elevation(dat$data, username = user) )

dat$data
plot(dat$data[1,])

# ?rgbif
points(gbif_antigone$decimalLongitude, gbif_antigone$decimalLatidute, col = "red")
str(gbif_antigone)
head(gbif_antigone)

# example use uf dataset_metrics
dataset_metrics(uuid='863e6d6b-f602-4495-ac30-881482b6f799')
