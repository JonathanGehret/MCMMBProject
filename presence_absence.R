#library(mapplots)
#library(mapproj)
library(graticule)

#1. using mappplots

#test_grid1 = makegrid(regio)
test_grid = make.grid(x = test_grid1$x1, y = test_grid1$x2, z = 0,
                      byx = 1, byy = 1,
                      xlim = c(129,141),
                      ylim = c(-9,1))
                      #xlim = c(min(test_grid1$x1), max(test_grid1$x1)),
                      #ylim = c(min(test_grid1$x2),max(test_grid1$x2)))


xmin = min(test_grid1$x1)
ymin = min(test_grid1$x2)
xmax = max(test_grid1$x1)
ymax = max(test_grid1$x2)

plot(test_grid1)

#2. using mapproj
# 

limits = c(min(test_grid1$x1),max(test_grid1$x1),
           min(test_grid1$x2),max(test_grid1$x2))

plot(regio)
map.grid(lim = limits,nx = 40, ny = 40, labels = F, pretty = T)

#3.  usnig graticule for grid creation
# https://cran.r-project.org/web/packages/graticule/vignettes/graticule.html

# projection
prj = "+proj=longlat +ellps=WGS84 +no_defs"

## specify exactly where we want meridians and parallels
lons <- seq(xmin,xmax,by = 0.1)
lats <- seq(ymin,ymax,by = 0.1)
## optionally, specify the extents of the meridians and parallels
## here we push them out a little on each side
xl <-  range(lons) + c(-0.4, 0.4)
yl <- range(lats) + c(-0.4, 0.4)
## build the lines with our precise locations and ranges
grat <- graticule(lons, lats, proj = prj, xlim = xl, ylim = yl)
plot(regio)
#plot(grat, add =T)
cropped_grid= crop(grat,regio)
#cropped_grid= crop(grat,precipitation)
plot(cropped_grid, add = T)
plot(precipitation)

#saving the grid
shapefile(cropped_grid,"data/grid/grid_papua.shp")
test_grid_2 = readOGR("data/grid/grid_papua.shp")
plot(test_grid_2)

plot(grid)
grid = cropped_grid

# add orrurence data to grid!! for plotting
grid@data

#Make spatial points dataframe from grid (from practical 3)

# transfrom grid  

grid@lines


plot(grid@lines[[5]]@Lines)

grid_2 = grid
grid_2@lines = coord_list
coords_grid = coordinates(grid)

coords_grid[[3]]

l = length(coords_grid)
c

paste("abd","def")

coord_list = list()
for (i in 1:l) {
  a = coords_grid[[i]]
  for (j in 1:length(a)) {
    name = paste(i,j)
    coord_list[[name]] = a[[j]]
    #print(a[j])
    }
}

coords_grid[[3]][[4]]

c = 0
for (i in 1:l) {
  a = coords_grid[[i]]
  print(a)
  c = c+ 1
}


grid_2
for (i in vector) {
  
}

grid_centroids <- gCentroid(grid_2, byid= T)
#grid_centroids <- gCentroid(coordinates(grid))
grid_centroids <- SpatialPointsDataFrame(grid_centroids, data = data.frame(grid_centroids@coords, present = 0))
names(grid_centroids@data) <- c("longitude","latitude","present")
par(mfrow=c(1,1))
plot(grid_centroids)

grid$ID


r_list = range(length(coord_list))

### 

plot(grid, col=ifelse(grid@data$Geonoma.pauciflora==1,"#ef8a62","#7fbf7b"), border=FALSE, main = "Geonoma pauciflora")


centroids <- project(coordinates(grid), inv = TRUE)
coordinates(grid)
