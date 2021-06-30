source("MCMMB_Main.R") # libaries and IUCN data read-in

# display 4 graphs simulatenouasly
# par(mfrow = c(1,1))
# par(mfrow = c(2,2))

# casuaries in iucn:
cas_ben_iucn = birdlife[77,]
cas_cas_iucn = birdlife[78,]
cas_una_iucn = birdlife[79,]

# plot casuaries
plot(regio)
plot(cas_ben_iucn, add = T, col = "red")
# legend(xlegend= "Red: Bennet")
#plot(regio)
plot(cas_cas_iucn, add = T, col = "yellow")
#plot(regio)
plot(cas_una_iucn, add = T, col = "black")

# read in all birbs indonesia
ind_birbs = read.csv("data/gbif/aves_indonesia/0303155-200613084148143.csv",header = TRUE, sep = "\t")

# remove all NA and empty fields
ind_birbs_corrected = ind_birbs[!(is.na(ind_birbs$decimalLatitude) | ind_birbs$decimalLatitude=="" | is.na(ind_birbs$decimalLongitude) | ind_birbs$decimalLongitude==""),]

# create points by use of Long and Lat
ind_birbs_points = st_as_sf(ind_birbs_corrected, coords = c("decimalLongitude","decimalLatitude"), crs = 4326)

#crop to indonesian papua
###

# get species (in this case casuarius) from gbif

# gbif ID from the table
# the cas_ben keys are without any data, therefore only the first key is needed
# (could also just use species names instead, may be more clear)

cas_ben_species = species[77,]$species
cas_cas_species = species[78,]$species
cas_una_species = species[79,]$species

#cas_ben_ID = species[77,]$key[1][[1]]
#cas_cas_ID = species[78,]$key[[1]]
#cas_una_ID = species[79,]$key[[1]]

# get points form gbif ID
#cas_ben_gbif = ind_birbs_points[ind_birbs_points$gbifID == cas_ben_ID,]
#cas_cas_gbif = ind_birbs_points[ind_birbs_points$gbifID == cas_cas_ID,]
#cas_una_gbif = ind_birbs_points[ind_birbs_points$gbifID == cas_una_ID,]


cas_ben_gbif = ind_birbs_points[ind_birbs_points$species == cas_ben_species,]
cas_cas_gbif = ind_birbs_points[ind_birbs_points$species == cas_cas_species,]
cas_una_gbif = ind_birbs_points[ind_birbs_points$species == cas_una_species,]


# plot
plot(st_geometry(cas_ben_gbif), pch=16, col="green", add = TRUE)
plot(st_geometry(cas_cas_gbif), pch=16, col="purple", add = TRUE)
plot(st_geometry(cas_una_gbif), pch=16, col="orange", add = TRUE)

legend("bottomleft", legend = c("Casuarius unappendiculatus","Casuarius bennetti","Casuarius casuarius"), 
       fill = c("black","red","yellow"))
