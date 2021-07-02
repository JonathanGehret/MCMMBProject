# following https://griffithdan.github.io/pages/outreach/SDM-Workshop-OSU-FALL2017.pdf


# read in PRISM data (I have provided it but you could access the data using the
# "prism" R package)

# dont forget to divide temperature by ten
# so far only temperature and precip, others have "differnet extent"
# grid@proj4string = CRS("+proj=longlat +ellps=WGS84 +no_defs")

tif_predictors <- stack(list.files(path = "data/indicator_stack/",
                                full.names = TRUE,
                                pattern = ".tif"))
plot(tif_predictors)

#manual extraction
testing_extract = extract(tif_predictors,cas_una_gbif)

cas_una_gbif$occurrenceStatus

cas_una_gbif_sp = as(cas_una_gbif, Class = "Spatial")
class(cas_una_gbif_sp)

test_gbif = gbif_birds[[3]]
spatial_points_test = SpatialPoints()

test_sp = as(test_gbif, Class = "Spatial")
class(test_sp)
test_gbif$geometry

class(test_sp[,1])

test_sp_2 <- as.numeric(test_sp[,1])

# use other birds as pseudo absence data????°!!
# > No pseudo absences selection ! ->î
# ! No data has been set aside for modeling evaluation -> needed?


# putting the data into right format
# prefers binary presence/absence data, does it also work with our gbif data?
biomod2_cas_una_formated <- BIOMOD_FormatingData(resp.var = test_sp[,1],
                                     expl.var = stack(tif_predictors),
                                     #eval.resp.var = ,
                                     #PA.strategy = "random",
                                     #PA.nb.rep = 0, # common practice to resample!
                                     #PA.nb.absences = 0,
                                     resp.name = "Casuarius.unappendiculatus")
biomod2_cas_una_formated

format_bm = biomod2_cas_una_formated


# shows biomod modelling possibilities:
BIOMOD_ModelingOptions() 


biomodels_1 <- BIOMOD_Modeling(data = format_bm,
                            models = c('GLM','GAM','ANN','RF'),
                            SaveObj = TRUE,
                            # models.options = myBiomodOptions,
                            # DataSplit = 80, # common practice to validate!
                            VarImport = 1)
PIPO.mod