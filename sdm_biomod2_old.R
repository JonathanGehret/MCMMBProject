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
#testing_extract = extract(tif_predictors,cas_una_gbif)

#cas_una_gbif$occurrenceStatus

#cas_una_gbif_sp = as(cas_una_gbif, Class = "Spatial")
#class(cas_una_gbif_sp)

#test_gbif = gbif_birds[[3]]
#spatial_points_test = SpatialPoints()

#test_sp = as(test_gbif, Class = "Spatial")
#class(test_sp)
#test_gbif$geometry

#class(test_sp[,1])

#test_sp_2 <- as.numeric(test_sp[,1])

test_spec_abs = create_pseudo_absence(regio,gbif_birds)

#cas_una_xy = data.frame(cbind(cas_una_abs$x, cas_una_abs$y))
test_spec_xy = data.frame(cbind(test_spec_abs$x, test_spec_abs$y))
# use other birds as pseudo absence data????°!!
# > No pseudo absences selection ! ->î
# ! No data has been set aside for modeling evaluation -> needed?
#cas_una_abs[,1]

# split datset into two for evaluation data?
# putting the data into right format
# prefers binary presence/absence data, does it also work with our gbif data?
#biomod2_cas_una_formated <- BIOMOD_FormatingData(resp.var = cas_una_abs$present,
biomod2_cas_una_formated <- BIOMOD_FormatingData(resp.var = test_spec_abs$present,
                                                 #biomod2_cas_una_formated <- BIOMOD_FormatingData(resp.var = cas_una_abs,
                                                 expl.var = stack(tif_predictors),
                                                 resp.xy = test_spec_xy,
                                                 #eval.resp.var = ,
                                                 #PA.strategy = "random",
                                                 #PA.nb.rep = 0, # common practice to resample!
                                                 #PA.nb.absences = 0,
                                                 resp.name = "Test.Spec")
biomod2_cas_una_formated

format_bm = biomod2_cas_una_formated


# shows biomod modelling possibilities:
BIOMOD_ModelingOptions() 

"Be sure to take care when considering the use of pseudo-absences versus true absences for species distribution
modeling. Similarly, it is extremely important to consider the influence of sampling bias in the data used to
train models. Further reading: e.g., Guillera-Arroita et al. 2015, Kramer-Schadt et al. 2013, and Merow et al
2013."

biomodels_1 <- BIOMOD_Modeling(data = format_bm,
                               #models = c('GLM','GAM','ANN','RF'),
                               models = c('GLM','ANN','RF'),
                               SaveObj = TRUE,
                               # models.options = myBiomodOptions,
                               # DataSplit = 80, # common practice to validate!
                               VarImport = 1)

"We will focus TSS (see Allouche et al. 2006 for a comparison of all three). TSS is the sum of the rates that
we correctly classified presences and absences, minus 1. Higher is better (in the range -1 to 1), and represents
a balance between model maximizing sensitivity and specificity."

biomod_eval = get_evaluations(biomodels_1)
biomod_eval["TSS","Testing.data",,,]
biomod_eval["KAPPA","Testing.data",,,]
biomod_eval["ROC","Testing.data",,,]

" GLM   GAM   ANN    RF 
0.725    NA 0.757 0.938 "

"We can also calculate variable importances to compare influences of individual predictor variables within and
among models. For a publication, you might also create partial dependence plots. Do the different models
agree on the importance of the variables?"

biomod_var_importance = drop(get_variables_importance(biomodels_1))
barplot(height = t(biomod_var_importance),
        beside = T,
        horiz = T,
        xlab = "Variable Importance",
        #legend = c("GLM", "GAM", "ANN", "RF"))
        legend = c("GLM", "ANN", "RF"))


"
One approach for using the information in these various models is to combine them into an ensemble, or
collection of models merged together (Thuiller et al. 2009). We can take all models above a given “quality”
threshold and combine them."


biomod_ensemble = BIOMOD_EnsembleModeling(modeling.output = biomodels_1,
                                          chosen.models = 'all',
                                          em.by = 'all',
                                          eval.metric = c('TSS'),
                                          eval.metric.quality.threshold = c(0.4),
                                          prob.mean = TRUE,
                                          prob.mean.weight = FALSE,
                                          prob.cv = FALSE,
                                          prob.ci = FALSE,
                                          prob.median = FALSE)

get_evaluations(biomod_ensemble)
"$Test.Spec_EMmeanByTSS_mergedAlgo_mergedRun_mergedData
      Testing.data Cutoff Sensitivity Specificity
KAPPA        0.846    564       93.75      90.909
TSS          0.847    564       93.75      90.909
ROC          0.979    562       93.75      90.909
"


"In order to visualize the model outputs, we should now use the SDMs to predict species occurrence across
space using our modern environmental data. The models predict probabilities of occurrence, and it is
important to remember the interpretation of these outputs depend on the specific model, our data, and our
assumptions (e.g., see discussion of Maxent outputs in Merow et al 2013)."

biomod_proj = BIOMOD_Projection(modeling.output = biomodels_1,
                                new.env = stack(tif_predictors), # modern environment
                                proj.name = 'current' ,
                                selected.models = 'all' ,
                                binary.meth = 'TSS' ,
                                compress = 'xz' ,
                                clamping.mask = F,
                                output.format = '.grd' )

plot(biomod_proj)
