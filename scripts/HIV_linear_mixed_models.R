# Longitudinal HIV-Analysis

#------------------------------------
#            LINEAR MODELS
#------------------------------------




#           Summary Results:
#-------------------------------------

summary_res <- function(model){
  
  #overall summary outputs
  summary_model <- summary(model)
  
  #fixed effects: beta estimates
  fix_eff <- fixed.effects(model)
  
  #random effects: BLUPs of mu_i
  rand_eff <- random.effects(model)
  
  # var-cov matrix 
  VarCovMat <- vcov(model)
  VarCorrMat <- VarCorr(model)
  
  #subject-specific fitted values: Vhat_ij
  Vij <- fitted(model)
  
  list(
    summary_res = summary_model,
    #anova_res = anova_model,
    random_effect_res = rand_eff,
    fixed_effects_res = fix_eff,
    var_cov_matrix= VarCovMat,
    var_corr_matrix = VarCorrMat,
    Vij_est = Vij
  )
}




#             Model 1: 
#--------------------------------------


#create interaction term (or could alternatively use Day:cd4 as interaction)
aids_sub <- aids_sub %>% 
  mutate(Day_cd4 = Day*cd4)


#fit model 1
model1_ml <- lme(RNA ~ Day + Day_cd4,
                 random = ~1 | patid,
                 method = "ML",
                 data = aids_sub) #ML used for AIC

model1_reml <- lme(RNA ~ Day + Day_cd4,
                   random = ~1 | patid,
                   method = "REML",
                   data = aids_sub) #REML used for final estimation


model1_results <- summary_res(model1_reml)
model1_results$fixed_effects_res
model1_results$var_cov_matrix
model1_results$var_corr_matrix
model1_results$random_effect_res
model1_results$Vij_est





#                 Model 2:
#---------------------------------------


model2_ml <- lme(RNA ~ Day + Day_cd4,
                 random = ~ Day + Day_cd4 | patid,
                 method = "ML",
                 data = aids_sub) #ML used for AIC

model2_reml <- lme(RNA ~ Day + Day_cd4,
                   random = ~ Day + Day_cd4 | patid,
                   method = "REML",
                   data = aids_sub) #REML used for final estimation


model2_results <- summary_res(model2_reml)
model2_results$fixed_effects_res
model2_results$var_cov_matrix
model2_results$var_corr_matrix
model2_results$random_effect_res
model2_results$Vij_est
