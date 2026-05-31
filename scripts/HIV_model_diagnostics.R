# Longitudinal HIV-Analysis

#--------------------------------
#       MODEL DIAGNOSTICS
#--------------------------------




#Diagnostic Plots 
#-----------------------------------

diagnostic_plt <- function(df,model){
  
  residualval <- resid(model)
  fittedval <- fitted(model)
  
  plot_df <- df %>% 
    mutate(
      resmod = residualval,
      fitmod = fittedval
    )
  
  re <- ranef(model)[[1]]
  re_df <- data.frame(random_intercept = as.numeric(re))
  
  # Residual vs fitted plot
  p1 <- ggplot(plot_df, aes(x = fitmod, y = resmod)) +
    geom_point(alpha = 0.7, color = "grey35") +
    geom_smooth(aes(group = 1), color = "grey20", linewidth = 0.8, se = FALSE) +
    geom_hline(yintercept = 0, linetype = "dashed", color = "grey50") +
    labs(
      x = "Fitted values",
      y = "Residuals",
      title = "Residuals vs Fitted"
    ) +
    theme_minimal(base_size = 12) +
    theme(
      panel.grid.minor = element_blank(),
      panel.grid.major = element_line(color = "grey85"),
      axis.title = element_text(size = 12),
      axis.text = element_text(size = 11),
      plot.title = element_text(size = 13, face = "bold")
    )
  
  # QQ Plot for residuals
  p2 <- ggplot(plot_df, aes(sample = resmod)) +
    geom_qq(alpha = 0.7, color = "grey35") +
    geom_qq_line(color = "grey20", linewidth = 0.8) +
    labs(
      x = "Theoretical quantiles",
      y = "Sample quantiles",
      title = "QQ Plot of Residuals"
    ) +
    theme_minimal(base_size = 12) +
    theme(
      panel.grid.minor = element_blank(),
      panel.grid.major = element_line(color = "grey85"),
      axis.title = element_text(size = 12),
      axis.text = element_text(size = 11),
      plot.title = element_text(size = 13, face = "bold")
    )
  
  # QQ Plot for random effects
  p3 <- ggplot(re_df, aes(sample = random_intercept)) +
    geom_qq(alpha = 0.7, color = "grey35") +
    geom_qq_line(color = "grey20", linewidth = 0.8) +
    labs(
      x = "Theoretical quantiles",
      y = "Sample quantiles",
      title = "QQ Plot of Random Effects"
    )+
    theme_minimal(base_size = 12) +
    theme(
      panel.grid.minor = element_blank(),
      panel.grid.major = element_line(color = "grey85"),
      axis.title = element_text(size = 12),
      axis.text = element_text(size = 11),
      plot.title = element_text(size = 13, face = "bold")
    )
  list(
    resid_fit = p1,
    fixed_qq_plot = p2,
    re_qq_plot = p3
  )
  
}





#           Model Diagnostics: 
#---------------------------------------------


# Model 1: 

diag_mod1 <- diagnostic_plt(aids_sub,model1_reml)

ggsave("model1_resid_fit.png",plot = diag_mod1$resid_fit,width = 10,height = 6,dpi = 300)
ggsave("model1_residual_qq.png",plot = diag_mod1$fixed_qq_plot,width = 10,height = 6,dpi = 300)
ggsave("model1_random_effects_qq.png",plot = diag_mod1$re_qq_plot,width = 10,height = 6,dpi = 300)


# Model 2: 

diag_mod2 <- diagnostic_plt(aids_sub,model2_reml)

ggsave("model2_resid_fit.png",plot = diag_mod2$resid_fit,width = 10,height = 6,dpi = 300)
ggsave("model2_residual_qq.png",plot = diag_mod2$fixed_qq_plot,width = 10,height = 6,dpi = 300)
ggsave("model2_random_effects_qq.png",plot = diag_mod2$re_qq_plot,width = 10,height = 6,dpi = 300)


# Model 3: 

diag_mod3 <- diagnostic_plt(aids_sub,model3_reml)

ggsave("model3_resid_fit.png",plot = diag_mod3$resid_fit,width = 10,height = 6,dpi = 300)
ggsave("model3_residual_qq.png",plot = diag_mod3$fixed_qq_plot,width = 10,height = 6,dpi = 300)
ggsave("model3_random_effects_qq.png",plot = diag_mod3$re_qq_plot,width = 10,height = 6,dpi = 300)


# Model 4: 

diag_mod4 <- diagnostic_plt(aids_sub,model4_reml)

ggsave("model4_resid_fit.png",plot = diag_mod4$resid_fit,width = 10,height = 6,dpi = 300)
ggsave("model4_residual_qq.png",plot = diag_mod4$fixed_qq_plot,width = 10,height = 6,dpi = 300)
ggsave("model4_random_effects_qq.png",plot = diag_mod4$re_qq_plot,width = 10,height = 6,dpi = 300)