
# read in PRISM data (I have provided it but you could access the data using the
# "prism" R package)

# dont forget to divide temperature by ten
tif_predictors <- stack(list.files(path = "data/indicator_stack/",
                                full.names = TRUE,
                                pattern = ".tif"))
plot(tif_predictors)


# putting the data into right format
biomod2_first_formated <- BIOMOD_FormatingData(resp.var = PIPO.dat,
                                     expl.var = stack(env.present),
                                     #eval.resp.var = ,
                                     #PA.strategy = "random",
                                     #PA.nb.rep = 0, # common practice to resample!
                                     #PA.nb.absences = 0,
                                     resp.name = "Pinus.ponderosa")
PIPO.mod.dat
