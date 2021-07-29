#function to add absence data to bird_list with spatialpointdataframe of bird presence data, 
# using elevation raster for grid coordinates and regio raster for extents 
create_pseudo_absence = function(regio, bird_list) {

  #1.:get centroids for all grid cells from established raster (here: elevation)
  elevation = raster("data/indicator_stack/Elevation.tif") # from extraction.R (maybe move to main?)
  
  elevation_mask = mask(elevation,regio) # masking elevation over regio
  
  # create centroids for grid with column "present" filled with 0 and transformed to sp
  centroids_all = xyFromCell(elevation_mask, which(elevation_mask[]>=0))
  centroids_all = cbind(centroids_all,present = rep(0,nrow(centroids_all)))
  centroids_all = SpatialPointsDataFrame(coords = data.frame(centroids_all), data = data.frame(centroids_all))
  centroids_all@proj4string = CRS("+proj=longlat +ellps=WGS84 +no_defs")

  # empty output list to be filled aith all pres/abs data
  presence_absence_list = list()
  
  set.seed(100)
  for (bird in bird_list) {
      
    #2.: get centroids of all grid cells for specific species by use of mask
    # 2nd raster
    # cas_una_gbif is st -> sp with as_Spatial
    species_raster = rasterize(as_Spatial(bird),elevation,1)
    raster_mask = mask(elevation,species_raster)
    
    # create centroids for occurence data
    centroids_occ = xyFromCell(raster_mask, which(raster_mask[] > 0))
    
    # add columns with presence data 1
    centroids_occ = cbind(centroids_occ,present = c(rep(1,length(centroids_occ[,1]))))
    
    # transform to SP:
    centroids_occ = SpatialPointsDataFrame(coords = data.frame(centroids_occ), data = data.frame(centroids_occ))
    centroids_occ@proj4string = CRS("+proj=longlat +ellps=WGS84 +no_defs")

    # create absence data added to presence data
    presence_absence <- rbind(centroids_all[sample(nrow(centroids_all),nrow(centroids_occ), replace = TRUE),],
                         centroids_occ)
    
    # add to list
    bird_name = unique(bird$species)
    presence_absence_list[[bird_name]] = presence_absence
    
    # plotting the presence absence data
    plot(regio, main = bird_name)
    plot(presence_absence, add = T, col = ifelse(presence_absence$present == 1, "red","green"))
  }
  
  return(presence_absence_list)
  
}