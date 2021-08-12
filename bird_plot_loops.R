# These two loops were used to plot all species distributions from the two data sets (GBIF and IUCN) 
#to find species that had sufficient data for distribution modeling and 
#to find related species (i.e. of the same genus) with different ranges.


#3. plot all iucn species (for finding the desired one)

# plotting a map for every single bird species in indonesia!
# adjusting for cropped 100 species!

par(mfrow=c(4,4))
for (i in 1:length(bl_species$species)) {
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
}

# accessing all plots of this r session:
# accessing save path
plots.dir.path <- list.files(tempdir(), pattern="rs-graphics", full.names = TRUE); 
plots.png.paths <- list.files(plots.dir.path, pattern=".png", full.names = TRUE)

# copy these files to specified directory:

file.copy(from=plots.png.paths, to="images/gbif_maps_2/")