# following https://griffithdan.github.io/pages/outreach/SDM-Workshop-OSU-FALL2017.pdf


# read in PRISM data (I have provided it but you could access the data using the
# "prism" R package)

# dont forget to divide temperature by ten
# so far only temperature and precip, others have "differnet extent"
tif_predictors <- stack(list.files(path = "data/indicator_stack/",
                                full.names = TRUE,
                                pattern = ".tif"))
plot(tif_predictors)

#manula extraction
testing_sextract = extract(tif_predictors,cas_una_gbif)

cas_una_gbif$individualCount

cas_una_gbif_sp = as(cas_una_gbif, Class = "Spatial")
class(cas_una_gbif_sp)

# putting the data into right format
# prefers binary presence/absence data, does it also work with our gbif data?
biomod2_cas_una_formated <- BIOMOD_FormatingData(resp.var = cas_una_gbif_sp,
                                     expl.var = stack(tif_predictors),
                                     #eval.resp.var = ,
                                     #PA.strategy = "random",
                                     #PA.nb.rep = 0, # common practice to resample!
                                     #PA.nb.absences = 0,
                                     resp.name = "Casuarius.unappendiculatus")
PIPO.mod.dat
