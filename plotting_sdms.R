# Evaluation

# comparing plots 
# to-do: loop over layers

# compare gbif with elevation
plot(elevation)
plot(biomod_proj@proj@val@layers[[1]], add = T, col =  rgb(red = 0.5, green = 0.5, blue = 0.5, alpha = 0.5))

# cmopare gbif with iucn
plot(biomod_proj@proj@val@layers[[1]])
plot(iucn_birds$`Pachycephala lorentzi`, add = T, col =  rgb(red = 0, green = 0, blue = 1, alpha = 0.5))
