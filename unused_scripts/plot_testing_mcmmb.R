# plotting for the ensemble models
for (i in 1:length(bird_names)) {
  bird_name = bird_names[i]
  png(file = paste0("plots/", strsplit(bird_name, split = " ")[[1]][1],"_", strsplit(bird_name, split = " ")[[1]][2],"_ensemble.png"))
  plot(BIOMOD_EnsembleForecasting(EM.output = gbif_sdms$ensemble[[i]],
                                  projection.output = gbif_sdms$sdm_proj[[i]],
                                  selected.models = 'all'))
  plot(iucn_birds[[i]], add = T, col =  rgb(red = 0, green = 0, blue = 1, alpha = 0.3))
  dev.off()
}



library(ggplot2)


par(mfrow = c(1,1))
for (i in 1:length(bird_names)) {
  bird_name = bird_names[i]
  #png(file = paste0("plots/", strsplit(bird_name, split = " ")[[1]][1],"_", strsplit(bird_name, split = " ")[[1]][2],"_ensemble.png"))
  ggplot(BIOMOD_EnsembleForecasting(EM.output = gbif_sdms$ensemble[[i]],
                                  projection.output = gbif_sdms$sdm_proj[[i]],
                                  selected.models = 'all') +
           geom_sf(iucn_birds[[i]], add = T, col =  rgb(red = 0, green = 0, blue = 1, alpha = 0.3)))
  #dev.off()
}



test_ensemble = BIOMOD_EnsembleForecasting(EM.output = gbif_sdms$ensemble[[1]],
                                           projection.output = gbif_sdms$sdm_proj[[1]],
                                           selected.models = 'all')

plot(test_ensemble)
plot(iucn_birds[[1]], add = T, col =  rgb(red = 0, green = 0, blue = 1, alpha = 0.3))
#ggplot(test_ensemble, aes(x,y))

plot(regio)
plot(test_ensemble@proj@val@layers)#, extent(regio))#, ylim(130,150))
plot(iucn_birds[[1]], add = T, col =  rgb(red = 0, green = 0, blue = 1, alpha = 0.3))


#plot(stack(test_ensemble@proj@val,iucn_birds[[1]])


par(mfrow=c(2,2))
for (i in 1:length(gbif_sdms$ensemble)) {
  sdm_ensemble = BIOMOD_EnsembleForecasting(EM.output = gbif_sdms$ensemble[[i]],
                                            projection.output = gbif_sdms$sdm_proj[[i]],
                                            selected.models = 'all')
  sdm = sdm_ensemble@proj@val
  plot(sdm, main = names(sdm_ensemble@sp.name))
  plot(iucn_birds[[i]], add = T, col =  rgb(red = 0, green = 0, blue = 1, alpha = 0.3))
}

sdm_ensemble@sp.name

sdms = sdm_ensemble@proj@val
plot(sdms)
sdms[[i]]

for (i in 1:length(gbif_sdms$ensemble)) {
  sdm_ensemble = BIOMOD_EnsembleForecasting(EM.output = gbif_sdms$ensemble[[i]],
                                            projection.output = gbif_sdms$sdm_proj[[i]],
                                            selected.models = 'all')
  sdm = sdm_ensemble@proj@val
  plot(sdm, main = names(sdm_ensemble@sp.name))
  plot(iucn_birds[[i]], add = T, col =  rgb(red = 0, green = 0, blue = 1, alpha = 0.3))
}
