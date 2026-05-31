# Longitudinal HIV-Analysis

#------------------------------------
#          NONLINEAR MODELS
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




#             Model 3: 
#--------------------------------------


model3_ml <- nlme(RNA ~ b1*exp(-b2*Day) + b3*exp(-b4*cd4),
                  fixed = b1 + b2 + b3 + b4 ~ 1, #all parameters have a fixed effect
                  random = b1 ~ 1 | patid, #b1 has a random intercept
                  method = "ML",
                  data = aids_sub,
                  start = c(b1 = 1, b2 = 0.01, b3 = 1, b4 = 0.01)
) #ML used for AIC

model3_reml <- nlme(RNA ~ b1*exp(-b2*Day) + b3*exp(-b4*cd4),
                    fixed = b1 + b2 + b3 + b4 ~ 1, #all parameters have a fixed effect
                    random = b1 ~ 1 | patid, #b1 has a random intercept
                    method = "REML",
                    data = aids_sub,
                    start = c(b1 = 1, b2 = 0.01, b3 = 1, b4 = 0.01)
)  #REML used for final estimation


model3_results <- summary_res(model3_reml)
model3_results$fixed_effects_res
model3_results$var_cov_matrix
model3_results$var_corr_matrix
model3_results$random_effect_res
model3_results$Vij_est





#                 Model 4:
#---------------------------------------


model4_ml <- nlme(RNA ~ b1*exp(-b2*Day) + b3*exp(-b4*Day_cd4),
                  fixed = b1 + b2 + b3 + b4 ~ 1, 
                  random = list(patid = pdDiag(list(b1 ~ 1, b2 ~ 1, b3 ~ 1, b4 ~ 1))), 
                  method = "ML",
                  data = aids_sub,
                  start = c(b1 = 1, b2 = 0.01, b3 = 1, b4 = 0.01),
                  control = nlmeControl(
                    maxIter = 200,
                    pnlsMaxIter = 50,
                    msMaxIter = 200,
                    msVerbose = TRUE
                  )
) #ML used for AIC

model4_reml <- nlme(RNA ~ b1*exp(-b2*Day) + b3*exp(-b4*cd4),
                    fixed = b1 + b2 + b3 + b4 ~ 1,
                    random = list(patid = pdDiag(list(b1 ~ 1, b3 ~ 1))), 
                    method = "ML",
                    data = aids_sub,
                    start =  c(b1 = 1, b2 = 0.01, b3 = 1, b4 = 0.01),
                    control = nlmeControl(
                      maxIter = 200,
                      pnlsMaxIter = 50,
                      msMaxIter = 200,
                      msVerbose = TRUE
                    )
) #REML used for AIC

model4_results <- summary_res(model4_reml)
model4_results$fixed_effects_res
model4_results$var_cov_matrix
model4_results$var_corr_matrix
model4_results$random_effect_res
model4_results$Vij_est