# Evaluation
# compare gbif with iucn for all birds j and sdms i
par(mfrow=c(2,2))
#pdf("plots.pdf")
for (j in 1:length(gbif_sdms$sdm_proj)) {
  bird = gbif_sdms$sdm_proj[[j]]
  sdms = bird@proj@val@layers
  #bird_names = names(test_sdms[j])
  for (i in 1:length(sdms)) {
    sdm = sdms[[i]]
    plot(sdm, main = names(sdm@data))
    plot(iucn_birds[[j]], add = T, col =  rgb(red = 0, green = 0, blue = 1, alpha = 0.3))
  }
  #plot_names = paste("images/sdm_iucn/",names(i),".png")
  
  #savePlot(filename = plot_names, type = "png")
  #tiff("images/sdm_iucn/.tiff")
}