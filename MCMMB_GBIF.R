
# how to use gbif with R: https://www.youtube.com/watch?v=RACfDLBIL8A

# comparison gbif dataset for Antigone rubicunda (eine Reiher art)  
# https://www.gbif.org/species/9295466
# GBIF.org (09 June 2021) GBIF Occurrence Download https://doi.org/10.15468/dl.6m2srw

library(raster)
library(rgeos)
# Load the SimpleFeatures library
library(sf)


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
name_suggest(q='Antigone rubicunda', rank='species') # -> no synonyms


# get info on species name
name_antigone = name_lookup(query = "Antigone rubicunda", rank = "species")
name_antigone$hierarchies
name_indonesia = name_lookup("Indonesia")
name_indonesia

occ_download()
# Check number of records
#occ_search(scientificName = "Antigone rubicunda", limit = 10)

# downloading and plotting
# gbif_antigone <- occ_search(scientificName = "Antigone rubicunda",return='data', limit=500)
antigone_key <- name_suggest('Antigone rubicunda')$data[1]
antigone_key
# dat <- occ_search(taxonKey = occ_key, limit = 3, hasCoordinate = TRUE)
# head( elevation(dat$data, username = user) )

#dat$data
#str(dat)
#plot(dat)

# ?rgbif
#points(gbif_antigone$decimalLongitude, gbif_antigone$decimalLatidute, col = "red")
#str(gbif_antigone)
#head(gbif_antigone)

# example use uf dataset_metrics
#dataset_metrics(uuid='863e6d6b-f602-4495-ac30-881482b6f799')

# Fetch aggregated density maps of GBIF occurrences
antigone_map = map_fetch(taxonKey = 9295466, year = 1950:2000)
plot(antigone_map)

#mvt_fetch(taxonKey = 166389564)

nrow(species)

# drop Amaurornis moluccanus/Amaurornis moluccana (#33)
# drop Threskiornis molucca/Threskiornis moluccus (#526)
species = species[-c(33,526),]

for (i in 1:nrow(species)) {
  print(i)
  print(species$species[i])
  species$key[i] = name_suggest(species$species[i])$data[1]
}

test_key = species$key[60][[1]]
str(test_key)

# country = "Indonesia",
test_map2 = map_fetch(taxonKey = 9295466)
test_map
plot(test_map)
plot(test_map2, add = T)
test_map = map_fetch(taxonKey = 2480498)
test_3 = map_fetch(taxonKey = 9295466, srs = "EPSG:3857")
plot(test_3)

test_bb = map_fetch(
  #taxonKey = c(9273800, 9583117, 9570909, 9377677, 9262418, 9389286),
  taxonKey = c(9273800), 
  srs = "EPSG:4326")
plot(test_bb)

test_mega = map_fetch(
  taxonKey = c(3), 
  srs = "EPSG:4326")
plot(test_mega)

plot(regio)
project(test_bb)

test_crop = crop(test_mega,regio)
str(test_crop)
plot(test_crop)
plot(crop(test_bb,regio))
crs(test_bb)
crs(regio)

crs(test_bb) = crs(regio)
regio@proj4string = crs(test_bb)

# aus Übung
#grid <- readOGR("data/30min_grid_select50/30min_grid_select50%.shp",
# integer64 = "allow.loss")
#americas@proj4string <- CRS("+proj=longlat +ellps=WGS84 +no_defs")
test_bb@crs = crs(regio)

#srs (character) Spatial reference system. One of:
#  • EPSG:3857 (Web Mercator)
#• EPSG:4326 (WGS84 plate care?)
#• EPSG:3575 (Arctic LAEA on 10 degrees E)
#• EPSG:3031 (Antarctic stereographic)

# 1,455,702 records works (species 50, Echinodermata) 
# Callipodida with 837 georeferenced records funktoinet auch!!!
# genus grus with 2.4 mio einträgen klappt auch




# christoph code

#insert respective credentials between ""
Sys.setenv(GBIF_USER = "JonathanGehret")
Sys.setenv(GBIF_PWD = "t?-9fAB6*X38k@#")
Sys.setenv(GBIF_EMAIL = "jonathan@gehrets.de")


# understand how to work with environment variables
#Sys.setenv(TEST = "hallo!") # set variable + value
#Sys.getenv("TEST") # get value
#Sys.unsetenv("TEST") # delete variable

#coarse outline of study region
#outline_coarse <- readOGR(dsn = "data", layer = "NG_outline")

# convert coarse New Guinea outline to WKT-format for being able to use it
#for subsetting data set in occ_download()
outline_coarseWKT <- writeWKT(regio)

# Birds: get data #####

# download request: birds in Indonesia
key_birds_ID <- occ_download(
  pred_in("taxonKey", 212),
  pred("country", "ID"),
  pred("hasCoordinate", TRUE),
  pred_within(outline_coarseWKT), # subset via polygon
  format = "SIMPLE_CSV",
  user = Sys.getenv("GBIF_USER"),
  #user = "jonathangehret",
  pwd = Sys.getenv("GBIF_PWD"),
  #pwd = "t?-9fAB6*X38k@#",
  email = Sys.getenv("GBIF_EMAIL")
  #email = "jonathan@gehrets.de"
  )



# gbif download

new_birb = read.csv2("data/gbif/acanthiza_murina/0303128-200613084148143.csv", header = TRUE, sep = "\t")

# jede Zeile einem Punkt zuweisen
new_birb$decimalLatitude[1]
new_birb$decimalLongitude[1]

#remove missing values
#na.omit(new_birb,)
new_birb_corrected = new_birb[!(is.na(new_birb$decimalLatitude) | new_birb$decimalLatitude=="" | is.na(new_birb$decimalLongitude) | new_birb$decimalLongitude ==""), ]

# crs 4326 = WGS84
new_birb_points = st_as_sf(new_birb_corrected, coords = c("decimalLongitude","decimalLatitude"), crs = 4326)
plot(st_geometry(new_birb_points), pch=16, col="navy", add = TRUE)

plot(regio)
# die gröbsten rausfiltern 
# jeweils koordinaten nehmen

# ind_birbs
ind_birbs = read.csv("data/gbif/aves_indonesia/0303155-200613084148143.csv",header = TRUE, sep = "\t")
ind_birbs = ind_birbs[!(ind_birbs$decimalLatitude=="" | ind_birbs$decimalLongitude==""),]

#crop to indenesian papua
 ###

# plot
plot(regio)
plot(st_geometry(new_birb_points), pch=16, col="navy", add = TRUE)
