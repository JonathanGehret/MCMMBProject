# Evaluation

# comparing plots 
# to-do: loop over layers

# loading model
#biomod_proj = BIOMOD_LoadModels(bm.out = "Test.Spec/Test.Spec.1625930744.models.out")

# compare gbif with elevation

par(mfrow=c(2,3))

par(mfrow=c(1,1))

biomod_proj = test_sdms[[3]]
#biomod_proj@proj@val@crs = CRS("+proj=longlat +ellps=WGS84 +no_defs")

bio = biomod_proj@proj@val@layers

for (i in bio) {
  plot(Elevation, fill = FALSE)
  plot(i, add = T, col =  rgb(red = 0.5, green = 0.5, blue = 0.5, alpha = 0.5))
  
}


#compare IUCN with GBIF
par(mfrow=c(2,3))

bio = biomod_proj@proj@val@layers

pdf("plots.pdf")
for (i in bio) {
  plot(i)
  plot(iucn_birds$`Casuarius unappendiculatus`, add = T, col =  rgb(red = 0, green = 0, blue = 1, alpha = 0.3))
  #plot_names = paste("images/sdm_iucn/",names(i),".png")
  #print(plot_names)
  #print()
  #savePlot(filename = plot_names, type = "png")
  #tiff("images/sdm_iucn/.tiff")
  
}


iucn_birds$`Pachycephala lorentzi`

pdf("plots.pdf")
for (i in 1:length(bio)) {
  plot(bio[[i]])
  plot(iucn_birds[[i]], add = T, col =  rgb(red = 0, green = 0, blue = 1, alpha = 0.3))
  #plot_names = paste("images/sdm_iucn/",names(i),".png")
  #print(plot_names)
  #print()
  #savePlot(filename = plot_names, type = "png")
  #tiff("images/sdm_iucn/.tiff")
  
}

# save pdfs as code
# par/gridarrange um plots zu arrangieren (wenig white space)
