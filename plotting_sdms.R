# Evaluation

# comparing plots 
# to-do: loop over layers

# compare gbif with elevation

par(mfrow=c(2,3))

bio = biomod_proj@proj@val@layers

for (i in bio) {
plot(elevation)
plot(i, add = T, col =  rgb(red = 0.5, green = 0.5, blue = 0.5, alpha = 0.5))

}


#compare IUCN with GBIF
par(mfrow=c(2,3))

bio = biomod_proj@proj@val@layers

for (i in bio) {
  plot(i)
  plot(iucn_birds$`Pachycephala lorentzi`, add = T, col =  rgb(red = 0, green = 0, blue = 1, alpha = 0.5))
  
}



