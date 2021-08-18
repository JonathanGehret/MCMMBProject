# closely following Griffith (2017)

# shows biomod modelling possibilities:
#BIOMOD_ModelingOptions()

# create pres/abs data with script presence_absence.R; moved to MCMMB.rmd
# source("presence_absence.R")
# presence_absence_list = create_pseudo_absence(regio,gbif_birds)

# function to calculate sdms with biomod2
calculate_sdm = function(presence_absence_list, tif_predictors) {
  
  # for testing purposes
  #species = presence_absence_list[1]
  
  # list for models
  model_list = list()
  
  # list to be filled with visual sdms for every species put int
  sdm_list = list()
  
  # variable importance list
  var_imp_list = list()
  
  # ensemble model list
  ensemble_list = list()
  
  # output list to be filled with sdm_list, variable importance and ensemble_models
  output_list = list()
  
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

  for (i in 1:length(presence_absence_list)) {
    
    # get bird_names 
    help_species = presence_absence_list[i]
    bird_name = names(help_species)
    
    # species
    species = help_species[[1]]
    
    # get coordinates from pres/abs data
    species_xy = data.frame(cbind(species$x, species$y))

    # potentially: split dataset into two for evaluation data
    # putting the data into right format
    format_bm = BIOMOD_FormatingData(resp.var = species$present,
                                         expl.var = stack(tif_predictors),
                                         resp.xy = species_xy,
                                         resp.name = bird_name)
    
    # modeling the sdms
    biomodels_1 = BIOMOD_Modeling(data = format_bm,
                                models = c('GLM','GAM','ANN','RF'),
                                SaveObj = TRUE,
                                models.options = myBiomodOptions,
                                # DataSplit = 80, # could be used for validation data
                                VarImport = 1)
    
    # calculate variance importance
    biomod_var_importance = drop(get_variables_importance(biomodels_1))
    
    # plotting moved to markdown script
    #barplot(height = t(biomod_var_importance),
    #        beside = T,
    #        horiz = T,
    #        #ylab = c("Precipitation",...),
    #        xlab = "Variable Importance",
    #        legend = c("GLM", "GAM", "ANN", "RF"))

    # put model together into an ensemble
    biomod_ensemble = BIOMOD_EnsembleModeling(modeling.output = biomodels_1,
                                              chosen.models = 'all',
                                              em.by = 'all',
                                              eval.metric = c('TSS'),
                                              eval.metric.quality.threshold = c(0.6),
                                              prob.mean = TRUE,
                                              prob.mean.weight = FALSE,
                                              prob.cv = FALSE,
                                              prob.ci = FALSE,
                                              prob.median = FALSE)
    
    # creation of projections for sdm visualization by plotting
    biomod_proj = BIOMOD_Projection(modeling.output = biomodels_1,
                                    new.env = stack(tif_predictors), # modern environment
                                    proj.name = 'current' ,
                                    selected.models = 'all' ,
                                    binary.meth = 'TSS' ,
                                    compress = 'xz' ,
                                    clamping.mask = F,
                                    output.format = '.grd' )
    
    # plot moved to .rmd
    #plot(biomod_proj)
    
    # write sd models to lists for return
    model_list[[bird_name]] = biomodels_1
    var_imp_list[[bird_name]] = biomod_var_importance
    ensemble_list[[bird_name]] = biomod_ensemble
    sdm_list[[bird_name]] = biomod_proj
  }
  
  # combine all output lists into one list and return it
  output_list = list(model_list,var_imp_list,ensemble_list,sdm_list)
  names(output_list) = c("sdm","var_imp","ensemble","sdm_proj")
  return(output_list)
  
}


# testing the script:
# test_sdms = calculate_sdm(presence_absence_list, tif_predictors)
# sdm_list[[bird_name]] = biomod