# Loops to access iucn birdlife and gbif data by bird_names
# could even combine booth loops into one!

# use MCMMB_main for libraries and data
#source("MCMMB_Main.R")

# add different colors per species?


# species  vector with all scientific species names
#bird_names = c(cas_ben_species,cas_cas_species,cas_una_species)
#bird_names = c("Casuaries bennetti", "Casuarius casuarius", "Casuarius unappendiculatus")
bird_names = c("Pachycephala lorentzi", 
               "Pachycephala meyeri", 
               "Pachycephala schlegelii",
               "Pachycephala simplex",
               "Pachycephala soror")

#1. IUCN

# getting and plotting iucn birdlife birds in loop using scientific names vector:
iucn_birds = list()
for (i in bird_names) {
  iucn_bird = birdlife[birdlife$SCINAME == i,]
  iucn_birds[[i]] = iucn_bird
  #plotting optional
  plot(regio)
  plot(iucn_bird, add = T, col = "red")
}


#2. GBIF

# loop for getting gibf data for any scientific bird names ("Genus species") in vector
gbif_birds = list() # creaty emtpy list
for (i in bird_names) {
  gbif_bird = gbif_crop[gbif_crop$species == i,]
  gbif_birds[[i]] = gbif_bird
  #plotting optional
  plot(regio)
  plot(st_geometry(gbif_bird), pch=16, col="green", add = TRUE) 
}



# legend("bottomleft", legend = c("Casuarius unappendiculatus","Casuarius bennetti","Casuarius casuarius"), 
#       fill = c("black","red","yellow"))


#3. plot all iucn species (for finding the desired one)

# plotting a map for every single bird species in indonesia!
# adjusting for cropped 100 species!
par(mfrow=c(4,4))
for (i in 1:length(species$species)) {
  #for (i in 1:16) {
  #print(i)
  plot(regio, main = paste(birdlife[i,]$SCINAME, i))
  plot(birdlife[i,], add=T, col = "green")
}

#4. plot all gbif species
par(mfrow=c(3,3))

#adjusting species list for gbif_crop
bird_names_2 = sort(unique(gbif_crop$species))
gbif_birds = list() # creaty emtpy list
for (i in bird_names) {
  bird = gbif_crop[gbif_crop$species == i,]
  gbif_birds[[i]] = bird
  plot(regio, main = paste(i,nrow(bird)))
  plot(st_geometry(bird), pch=16, col="green", add = TRUE) 
  # only use birds withe gernea >2
}

# accessing all plots of this r session:
# https://stackoverflow.com/questions/35321775/save-all-plots-already-present-in-the-panel-of-rstudio

# accessing save path
plots.dir.path <- list.files(tempdir(), pattern="rs-graphics", full.names = TRUE); 
plots.png.paths <- list.files(plots.dir.path, pattern=".png", full.names = TRUE)

#Now, you can copy these files to your desired directory, as follows:
  
file.copy(from=plots.png.paths, to="images/gbif_maps_2/")

# alternative approach:
#1. crop gbif-point data to regio
#2. count number of occurences
