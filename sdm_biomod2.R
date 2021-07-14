# following https://griffithdan.github.io/pages/outreach/SDM-Workshop-OSU-FALL2017.pdf


# read in PRISM data (I have provided it but you could access the data using the
# "prism" R package)

# dont forget to divide temperature by ten
# so far only temperature and precip, others have "differnet extent"
# grid@proj4string = CRS("+proj=longlat +ellps=WGS84 +no_defs")


# load everything (move somewhere else)
#source("MCMMB_Main.R")

# move to markdown??
# shows biomod modelling possibilities:
#BIOMOD_ModelingOptions() 


# stacking all predictors found in folder indicator stack in .tif format
# predictors: elevation, precipitation, temperature, primary forest, landcover, population
# move to predictor script?
tif_predictors <- stack(list.files(path = "data/indicator_stack/",
                                full.names = TRUE,
                                pattern = ".tif"))
plot(tif_predictors)

# create pres/abs data with script presence_absence.R (move to main script?)
source("presence_absence.R")
presence_absence_list = create_pseudo_absence(regio,gbif_birds)

# function to calculate sdms with biomod2
calculate_sdm = function(presence_absence_list, tif_predictors) {
  
  # for testing purposes
  #species = presence_absence_list[1]
  
  # list to be filled with sdms for every species put int
  sdm_list = list()
  
  # modify model settings (i.e. k value (degrees of freedom) for GAM)
  # big but not too big for k
  myBiomodOptions = BIOMOD_ModelingOptions(
    GAM = list( algo = 'GAM_mgcv',
                type = 's_smoother',
                #k = 0, 
                k = 4,
                interaction.level = 0,
                myFormula = NULL,
                family = binomial(link = 'logit'),
                method = 'GCV.Cp',
                optimizer = c('outer','newton'),
                select = FALSE,
                knots = NULL,
                paraPen = NULL,
                control = list(nthreads = 1, irls.reg = 0, epsilon = 1e-07, maxit = 200, trace = FALSE, mgcv.tol = 1e-07
                               , mgcv.half = 15, rank.tol = 1.49011611938477e-08
                               , nlm = list(ndigit=7, gradtol=1e-06, stepmax=2, steptol=1e-04, iterlim=200, check.analyticals=0)
                               , optim = list(factr=1e+07), newton = list(conv.tol=1e-06, maxNstep=5, maxSstep=2, maxHalf=30, use.svd=0)
                               , outerPIsteps = 0, idLinksBases = TRUE, scalePenalty = TRUE, efs.lspmax = 15, efs.tol = 0.1, keepData = FALSE
                               , scale.est = "fletcher", edge.correct = FALSE) ), 
    # standard settings
    RF = list( do.classif = TRUE,
               ntree = 500,
               mtry = 'default',
               nodesize = 5,
               #nodesize = 50,
               maxnodes = NULL)
    )
  
  
  #for (species in presence_absence_list) {
  for (i in 1:length(presence_absence_list)) {
    
    # get bird_names 
    # could also hand over names list ("bird_names" in species_loops.R as input for function)
    #bird_name = unique(species$species)
    #bird_name = bird_names[1]
    help_species = presence_absence_list[i]
    bird_name = names(help_species)
    
    # species
    species = help_species[[1]]
    
    # get coordinates from prese/abs data
    species_xy = data.frame(cbind(species$x, species$y))

    # split datset into two for evaluation data?
    # putting the data into right format
    format_bm <- BIOMOD_FormatingData(resp.var = species$present,
                                         expl.var = stack(tif_predictors),
                                         resp.xy = species_xy,
                                         resp.name = bird_name)
    
    "Be sure to take care when considering the use of pseudo-absences versus true absences for species distribution
    modeling. Similarly, it is extremely important to consider the influence of sampling bias in the data used to
    train models. Further reading: e.g., Guillera-Arroita et al. 2015, Kramer-Schadt et al. 2013, and Merow et al
    2013."
    
    biomodels_1 <- BIOMOD_Modeling(data = format_bm,
                                models = c('GLM','GAM','ANN','RF'),
                                #models = c('GLM','ANN','RF'),
                                #models = c('GAM'),
                                SaveObj = TRUE,
                                models.options = myBiomodOptions,
                                # DataSplit = 80, # common practice to validate!
                                VarImport = 1)
    
    "We will focus TSS (see Allouche et al. 2006 for a comparison of all three). TSS is the sum of the rates that
    we correctly classified presences and absences, minus 1. Higher is better (in the range -1 to 1), and represents
    a balance between model maximizing sensitivity and specificity."
    
    # add to markdown?? use other indicators??
    #biomod_eval = get_evaluations(biomodels_1)
    #biomod_eval["TSS","Testing.data",,,]
    #biomod_eval["KAPPA","Testing.data",,,]
    #biomod_eval["ROC","Testing.data",,,]
    #evaluate(biomodels_1, data, stat, as.array=FALSE)
    
    " GLM   GAM   ANN    RF 
    0.725    NA 0.757 0.938 "
    #>     biomod_eval["TSS","Testing.data",,,]
    #GLM   GAM   ANN    RF 
    #1.000 1.000 1.000 0.967 
    #>     biomod_eval["KAPPA","Testing.data",,,]
    #GLM   GAM   ANN    RF 
    #1.000 1.000 1.000 0.967 
    #>     biomod_eval["ROC","Testing.data",,,]
    #GLM   GAM   ANN    RF 
    #1.000 1.000 1.000 0.999 
    
    "We can also calculate variable importances to compare influences of individual predictor variables within and
    among models. For a publication, you might also create partial dependence plots. Do the different models
    agree on the importance of the variables?"
    
    biomod_var_importance = drop(get_variables_importance(biomodels_1))
    barplot(height = t(biomod_var_importance),
            beside = T,
            horiz = T,
            #ylab = c("Precipitation",...),
            xlab = "Variable Importance",
            legend = c("GLM", "GAM", "ANN", "RF"))
            #legend = c("GLM", "ANN", "RF"))
            #legend = c("GAM"))

    
    
    "
    One approach for using the information in these various models is to combine them into an ensemble, or
    collection of models merged together (Thuiller et al. 2009). We can take all models above a given “quality”
    threshold and combine them."
    
    biomod_ensemble = BIOMOD_EnsembleModeling(modeling.output = biomodels_1,
                                              chosen.models = 'all',
                                              em.by = 'all',
                                              eval.metric = c('TSS'),
                                              eval.metric.quality.threshold = c(0.3),
                                              prob.mean = TRUE,
                                              prob.mean.weight = FALSE,
                                              prob.cv = FALSE,
                                              prob.ci = FALSE,
                                              prob.median = FALSE)
    
    #get_evaluations(biomod_ensemble)
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
    
    # to-do: make plots beautiful
    #plot(biomod_proj,xlab="Longitude")
    plot(biomod_proj)
    
    # write sd models to list for return
    sdm_list[[bird_name]] = biomod_proj
    "Fehler in sdm_list[[bird_name]] <- biomod_proj : 
  attempt to select less than one element in OneIndex"
  }
  return(sdm_list)
}

test_sdms = calculate_sdm(presence_absence_list, tif_predictors)
#sdm_list[[bird_name]] = biomod