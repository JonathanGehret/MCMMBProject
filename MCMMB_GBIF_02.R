# using manually downloaded gbif data


library(raster)
library(rgeos)
# Load the SimpleFeatures library
library(sf)

source("MCMMB_Main.R")


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
chris_birbs = read.csv("data/gbif/birds_indonesia.csv",header = TRUE, sep = "\t")
ind_birbs = chris_birbs
ind_birbs_corrected = ind_birbs[!(is.na(ind_birbs$decimalLatitude) | ind_birbs$decimalLatitude=="" | is.na(ind_birbs$decimalLongitude) | ind_birbs$decimalLongitude==""),]

# create points
ind_birbs_points = st_as_sf(ind_birbs_corrected, coords = c("decimalLongitude","decimalLatitude"), crs = 4326)

#crop to indenesian papua
###

# plot
plot(regio)
plot(st_geometry(ind_birbs_points), pch=16, col="navy", add = TRUE)
plot(st_geometry(ind_birbs_points), pch=16, col="green", add = TRUE)
