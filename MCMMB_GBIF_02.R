# using manually downloaded gbif data


#library(raster)
#library(rgeos)
# Load the SimpleFeatures library
#library(sf)

# loading libraries, border shapefile, birds
source("MCMMB_Main.R")


# gbif download example species
# acanthiza_murian, guinea thornbill

new_birb = read.csv2("data/gbif/acanthiza_murina/0303128-200613084148143.csv", header = TRUE, sep = "\t")

# names der long/lat spalten
#new_birb$decimalLatitude[1]
#new_birb$decimalLongitude[1]

#remove missing values
#na.omit(new_birb,)
new_birb_corrected = new_birb[!(is.na(new_birb$decimalLatitude) | new_birb$decimalLatitude=="" | is.na(new_birb$decimalLongitude) | new_birb$decimalLongitude ==""), ]

# crs 4326 = WGS84
# create points by use of long/lat data
new_birb_points = st_as_sf(new_birb_corrected, coords = c("decimalLongitude","decimalLatitude"), crs = 4326)

#cropping points to regio
#new_birb_points = st_intersection(x = new_birb_points, poly = regio)
#new_birb_points = st_union(x = new_birb_points, poly = regio)
#new_birb_points = point.in.poly(new_birb_points,regio)


# plot example birbs 
plot(birdlife[2,], add=T, col = "red")
#plot(new_birb_points, pch=16, col="navy", add = TRUE)
plot(st_geometry(new_birb_points), pch=16, col="navy", add = TRUE)

# die gröbsten rausfiltern 
# jeweils koordinaten nehmen

# same for all birbs indonesia
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
plot(st_geometry(ind_birbs_points), pch=16, col="navy", add = TRUE)
plot(st_geometry(ind_birbs_points), pch=16, col="green", add = TRUE)
