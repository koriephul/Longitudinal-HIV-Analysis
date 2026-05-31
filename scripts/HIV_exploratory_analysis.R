# Longitudinal HIV-Analysis

#--------------------------------------
#      EXPLORATORY DATA ANALYSIS 
#--------------------------------------





#          Summary Statistics:
#---------------------------------------

summary_stats <- aids_sub %>%
  summarise(
    across(c(Day,cd4,RNA),
           list(
             n = ~sum(!is.na(.x)),
             mean = ~mean(.x, na.rm = TRUE),
             sd   = ~sd(.x, na.rm = TRUE),
             min  = ~min(.x, na.rm = TRUE),
             p25  = ~quantile(.x, 0.25, na.rm = TRUE),
             median = ~quantile(.x, 0.5, na.rm = TRUE),
             p75  = ~quantile(.x, 0.75, na.rm = TRUE),
             max  = ~max(.x, na.rm = TRUE),
             NAcount = ~sum(is.na(.x))
           )
    )
  ) %>%
  pivot_longer(everything(),
               names_to = c("Variable",".value"),
               names_sep = "_"
  )

summary_stats %>%
  kable(caption = "Summary Statistics")







#             Spaghetti plots:
#------------------------------------------


scatterplot_patid <- function(df, x, y, z) {
  
  ggplot(df, aes(x = {{ x }}, y = {{ y }},group = {{ z }},color = as.factor({{ z }}))) +
    geom_line(alpha = 0.30, linewidth = 0.4) +
    geom_point(alpha = 0.65, size = 1.8) +
    geom_smooth(
      aes(group = 1),
      method = "loess",
      color = "black",
      linewidth = 1,
      se = FALSE
    )  +
    theme_minimal(base_size = 12) +
    theme(
      panel.grid.minor = element_blank(),
      panel.grid.major = element_line(color = "grey85", linewidth = 0.3),
      axis.title = element_text(size = 13),
      axis.text = element_text(size = 11),
      plot.title = element_text(size = 14, face = "bold"),
      legend.position = "none"
    )
}

#save plots to png
rna_sctplot <- scatterplot_patid(aids_sub,Day,RNA,patid)
cd4_sctplot <- scatterplot_patid(aids_sub,Day,cd4,patid)

ggsave("RNA_spaghetti.png",rna_sctplot,width = 14, height = 12, dpi = 300)
ggsave("cd4_spaghetti.png",cd4_sctplot,width = 14, height = 12, dpi = 300)








#             Violin Plots: 
#-----------------------------------------


violin_plots <- function(df, x, y) {
  ggplot(df, aes(x = {{x}}, y = {{y}})) +
    
    geom_violin(fill = "grey85", color = "grey50", alpha = 0.7, trim = FALSE) +
    
    geom_boxplot(
      width = 0.1,
      fill = "white",
      color = "grey30",
      outlier.color = "grey40",
      outlier.size = 1.5
    ) +
    
    theme_minimal(base_size = 12) +
    theme(
      panel.grid.minor = element_blank(),
      panel.grid.major.x = element_blank(),
      panel.grid.major.y = element_line(color = "grey85"),
      axis.title = element_text(size = 12),
      axis.text = element_text(size = 11)
    )
}

#save plot to png
rna_violin <- violin_plots(aids_sub, Day, RNA)
cd4_violin <- violin_plots(aids_sub, Day, cd4)

ggsave("RNA_violin.png",rna_violin,width = 14, height = 12, dpi = 300)
ggsave("cd4_violin.png",cd4_violin,width = 14, height = 12, dpi = 300)








#        Correlation Matrix/Heatmap:
#-----------------------------------------



correlation_matrix <- function(df,x,y,z){
  
  # correlation matrix 
  cor_mat <- df %>% 
    select({{x}},{{y}},{{z}}) %>% 
    cor(use = "complete.obs")
  
  cor_plot <- corrplot(cor_mat,
                       method = "color",
                       col = colorRampPalette(c("deeppink", "black", "plum"))(200),
                       addCoef.col = "white",
                       tl.col = "black",
                       tl.srt = 45)
  
}

correlation_matrix(aids_sub,Day,cd4,RNA)


