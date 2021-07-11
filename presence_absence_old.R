
#4. use established raster
source("MCMMB_Main.R")
"test_function = function(bird_list) {

# to-do: loop all steps for any given species list
for (i in gbif_birds) {
  create presence-absence
    
}
}"

#plot(regio)

#1.:get centroids for all grid cells from established raster (here: elevation)
# elevation = raster("data/Indicator/elevation/regio_elev.tif") # from extraction.R (maybe move to main?)

elevation_mask = mask(elevation,regio) # masking elevation over regio
centroids_all = xyFromCell(elevation_mask, which(elevation_mask[]>=0))
#points(centroids_all, add = T)


#2.: get centroids of all grid cells for specific species by use of mask
# 2nd raster
# cas_una_gbif is st -> sp with as_Spatial

cas_una_gbif = gbif_birds[[1]] # remove later
bird_list = gbif_birds # remove later
#plot(regio)

species_raster = rasterize(as_Spatial(cas_una_gbif),elevation,1)
raster_mask = mask(elevation,species_raster)
centroids_occ = xyFromCell(raster_mask, which(raster_mask[] > 0))

#points(occ_centroids, add = T, col = "red")

# add columens with present data
centroids_occ = cbind(centroids_occ,present = c(rep(1,length(centroids_occ[,1]))))
#centroids_occ = cbind(centroids_occ,present = rep(1,nrow(centroids_all)))
#CRS(centroids_occ)
#centroids_all = cbind(centroids_all,present = c(rep(0,length(centroids_all[,1]))))
centroids_all = cbind(centroids_all,present = rep(0,nrow(centroids_all)))


# transform to SP:
centroids_occ = SpatialPointsDataFrame(coords = data.frame(centroids_occ), data = data.frame(centroids_occ))
centroids_occ@proj4string = CRS("+proj=longlat +ellps=WGS84 +no_defs")

centroids_all = SpatialPointsDataFrame(coords = data.frame(centroids_all), data = data.frame(centroids_all))
centroids_all@proj4string = CRS("+proj=longlat +ellps=WGS84 +no_defs")

set.seed(100)
cas_una_abs <- rbind(centroids_all[sample(nrow(centroids_all),nrow(centroids_occ), replace = TRUE),],
                     centroids_occ)

test_spec_abs = rbind(centroids_all[sample(nrow(centroids_all),nrow(centroids_occ), replace = TRUE),],
                      centroids_occ)
#cas_una_abs[[1]]
plot(regio)
# names?? cas_una_pres_abs, cas_una, cas_una_pres, cas_una_occ, cas_una_p_a
plot(cas_una_abs, add = T, col = ifelse(cas_una_abs$present == 1, "red","green"))
plot(regio)
plot(test_spec_abs, add = T, col = ifelse(test_spec_abs$present == 1, "red","green"))
