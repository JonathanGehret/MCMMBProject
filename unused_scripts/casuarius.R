source("MCMMB_Main.R") # libaries and IUCN data read-in

# display 4 graphs simulatenouasly
# par(mfrow = c(1,1))
# par(mfrow = c(2,2))

# casuaries in iucn:
cas_ben_iucn = birdlife[77,]
cas_cas_iucn = birdlife[78,]
cas_una_iucn = birdlife[79,]
cas_ben_iucn$SCINAME

which(birdlife$SCINAME == "Casuarius bennetti")

# getting and plotting birdlife data in loop using index gbif keys:
bird_numbers = c(77,78,79)
iucn_list = list()
for (i in bird_numbers) {
  bird = birdlife[i,]
  bird_name = bird$SCINAME
  iucn_list[[bird_name]] = bird
}

# getting and plotting iucn birdlife birds in loop using scientific names vector:
bird_names = c(cas_ben_species,cas_cas_species,cas_una_species)
iucn_list_2 = list()
for (i in bird_names) {
  bird = birdlife[which(birdlife$SCINAME == i),]
  plot(bird, add = T, col = "red")
  iucn_list_2[[i]] = bird
}

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
ind_birbs_points = st_as_sf(ind_birbs_corrected, coords = c("decimalLongitude","decimalLatitude"), crs = 4326) # crs = coordinate system, which is the same as the iucn one (which one??)

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


# loop for getting gibf data for any scientific bird names ("Genus species") in vector

# creating species vector with all the species
bird_names = c(cas_ben_species,cas_cas_species,cas_una_species)
# add different colors per species?

gbif_birds = list() # creaty emtpy list

for (i in bird_names) {
    gbif_birds[[i]] = ind_birbs_points[ind_birbs_points$species == i,]
    plot(st_geometry(gbif_birds[[i]]), pch=16, col="green", add = TRUE) 
}

# alternative plotting without naming:
# l = length(bird_names) # length of vector =  number of birds
#gbif_birds = vector("list", l) # creating empty list of length l 
#for (i in 1:l) {
#gbif_birds[[i]] = ind_birbs_points[ind_birbs_points$species == bird_names[i],]
#}

plot(regio)
# plot
plot(st_geometry(cas_ben_gbif), pch=16, col="green", add = TRUE)
plot(st_geometry(cas_cas_gbif), pch=16, col="purple", add = TRUE)
plot(st_geometry(cas_una_gbif), pch=16, col="orange", add = TRUE)

legend("bottomleft", legend = c("Casuarius unappendiculatus","Casuarius bennetti","Casuarius casuarius"), 
       fill = c("black","red","yellow"))



test_species = species[300,]$species
test_species_gbif = ind_birbs_points[ind_birbs_points$species == test_species,]
