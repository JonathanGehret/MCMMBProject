# get point file, examplary cas_ben_gbif, cas_cas_gbif, cas_cas_gbif from casuarius.R

# get raster files, either from other script or read in here:
elevation = raster("data/Indicator/elevation/regio_elev.tif")
precipitation = raster("data/Indicator/Precipitation/regio_precip.tif")
temperature = raster("data/Indicator/Temperatur/regio_temp.tif") / 10
primary_forest = raster("data/Indicator/Primary_Forest/regio_primforest.tif")
population = raster("data/Indicator/population/regio_popul.tif")
land_reserve <- readOGR("data/Indicator/nature_reserve_papua/land_reserv/land_reserv.shp", integer64="allow.loss")


#cas_una_gbif

# elevation extractions
cas_ben_elev = extract(elevation, cas_ben_gbif)
cas_cas_elev = extract(elevation, cas_cas_gbif)
cas_una_elev = extract(elevation, cas_una_gbif)


# precipitation extractions
cas_ben_prec = extract(precipitation, cas_ben_gbif)
cas_cas_prec = extract(precipitation, cas_cas_gbif)
cas_una_prec = extract(precipitation, cas_una_gbif)

# temperature extractions
cas_ben_temp = extract(temperature, cas_ben_gbif)
cas_cas_temp = extract(temperature, cas_cas_gbif)
cas_una_temp = extract(temperature, cas_una_gbif)

# primary forest extractions
cas_ben_pri = extract(primary_forest, cas_ben_gbif)
cas_cas_pri = extract(primary_forest, cas_cas_gbif)
cas_una_pri = extract(primary_forest, cas_una_gbif)

# population extration
cas_ben_pop = extract(population, cas_ben_gbif)
cas_cas_pop = extract(population, cas_cas_gbif)
cas_una_pop = extract(population, cas_una_gbif)

# land reserve extraction
#cas_ben_lare = over(land_reserve, cas_ben_gbif)
#cas_cas_lare = over(land_reserve, cas_cas_gbif)
#cas_una_lare = over(land_reserve, cas_una_gbif)




# add loop for any birdies
birdie_point_input_list = c("cas_ben_gbif", "cas_cas_gbif", "cas_cas_gbif")
indicator_frame = data.frame()
#names(indicator_frame) = c("species","elevation","precipitation", "temperature","primary_forest","population","land_reserve")
for (i in 1:length(birdie_point_input_list)) {
  indicator_frame$species[i] = birdie_point_input_list[i]
  #indicator_frame$elevation[i] = extract(elevation, birdie_point_input_list[i])
  #indicator_frame$precipitation[i] = extract(elevation, birdie_point_input_list[i])
}
indicator_frame$species= "abc" 

indicator_frame = "a"
birdie_point_input_list[1]

?extract
