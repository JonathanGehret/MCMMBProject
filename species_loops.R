# Loops to access iucn birdlife and gbif data by bird_names
# could even combine booth loops into one!

# use MCMMB_main for libraries and data
source("MCMMB_Main.R")

# add different colors per species?


# species  vector with all scientific species names
#bird_names = c(cas_ben_species,cas_cas_species,cas_una_species)
bird_names = c("Casuaries bennetti", "Casuarius casuarius", "Casuarius unappendiculatus")

#1. IUCN

# getting and plotting iucn birdlife birds in loop using scientific names vector:
iucn_birds = list()
for (i in bird_names) {
  bird = birdlife[which(birdlife$SCINAME == i),]
  plot(bird, add = T, col = "red")
  iucn_birds[[i]] = bird
}


#2. GBIF

# loop for getting gibf data for any scientific bird names ("Genus species") in vector
gbif_birds = list() # creaty emtpy list
for (i in bird_names) {
  gbif_birds[[i]] = ind_birbs_points[ind_birbs_points$species == i,]
  plot(st_geometry(gbif_birds[[i]]), pch=16, col="green", add = TRUE) 
}



# legend("bottomleft", legend = c("Casuarius unappendiculatus","Casuarius bennetti","Casuarius casuarius"), 
#       fill = c("black","red","yellow"))


#3. plot all species (for finding the desired one)

# plotting a map for every single bird species in indonesia!
par(mfrow=c(4,4))
for (i in 1:length(species$species)) {
  #for (i in 1:16) {
  #print(i)
  plot(regio, main = paste(birdlife[i,]$SCINAME, i))
  plot(birdlife[i,], add=T, col = "green")
}

#4. plot all gbif species
par(mfrow=c(3,3))
bird_names = species$species
gbif_birds = list() # creaty emtpy list
for (i in bird_names) {
  gbif_birds[[i]] = ind_birbs_points[ind_birbs_points$species == i,]
  plot(regio, main = i)
  plot(st_geometry(gbif_birds[[i]]), pch=16, col="green", add = TRUE) 
}
