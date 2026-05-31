# Longitudinal HIV-Analysis

#----------------------------------------
#       PREPROCESSING
#----------------------------------------




#         Load Packages/Libraries: 
#-----------------------------------------

packages = c("dplyr","ggplot2","lme4","nlme","tidyverse","tidyr","knitr","ggsci","corrplot","stats","car")
invisible(lapply(packages,require,character.only = TRUE))



#           Read in dataset: 
#--------------------------------------------

aids_data <- read.table("ACTG315.dat",header = TRUE)



#             Preprocessing:
#----------------------------------------------
aids_sub <- aids_data %>% 
  filter( Day <= 91) %>%  #subset data for <= 91 days
  mutate(patid = as.factor(patid)) %>% #each patient id should be factor so model knows which measurement belongs to who
  select(-c("X.No","No")) #drop the first two columns