# Loops to access iucn birdlife and gbif data by bird_names

# species  vector with all scientific species names, example species
#bird_names = c(cas_ben_species,cas_cas_species,cas_una_species)
#bird_names = c("Casuarius bennetti", "Casuarius casuarius", "Casuarius unappendiculatus")
#bird_names = c("Pachycephala lorentzi", 
#               "Pachycephala meyeri", 
#               "Pachycephala schlegelii",
#               "Pachycephala simplex",
#               "Pachycephala soror")

#1. IUCN
# getting and plotting iucn birdlife birds in loop using scientific names vector:
# Function to create list of with IUCN Birdlife data for spedcified bird_names 
get_iucn_birds = function(bird_names,birdlife,regio) {
  iucn_birds = list()
  for (i in bird_names) {
    iucn_bird = birdlife[birdlife$SCINAME == i,]
    iucn_birds[[i]] = iucn_bird
    #plotting optional
    plot(regio, main = i, cex.main = 0.8)
    plot(iucn_bird, add = T, col = "red")
  }
  return(iucn_birds)
}

#2. GBIF
# loop for getting gibf data for any scientific bird names ("Genus species") in vector
get_gbif_birds <- function(bird_names,gbif_crop,regio) {
  gbif_birds = list() # creaty emtpy list
  for (i in bird_names) {
    gbif_bird = gbif_crop[gbif_crop$species == i,]
    gbif_birds[[i]] = gbif_bird
    #plotting optional
    plot(regio, main = i, cex.main = 0.8)
    plot(st_geometry(gbif_bird), pch=16, col="green", add = TRUE) 
  }
  return(gbif_birds)
}

# legend("bottomleft", legend = c("Casuarius unappendiculatus","Casuarius bennetti","Casuarius casuarius"), 
#       fill = c("black","red","yellow"))
