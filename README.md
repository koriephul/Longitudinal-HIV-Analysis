# Longitudinal-HIV-Analysis

## Overview

This project investigates the relationship between HIV-1 RNA and CD4 T-cell counts following an antiviral regimen using longitudinal analysis. 
Using data from the ACTG Protocol 315, linear and nonlinear models were compared to evaluate patient-specific trajectories and overall population trends. 
Model performance was assessed using diagnostic plots and Akaike Information Criterion (AIC), with nonlinear mixed-effects models providing the strongest fit to the data.

## Objectives

- Examine changes in HIV-1 RNA and CD4 counts over time
- Compare linear and nonlinear mixed-effects models
- Evaluate patient-specific variability using random effects
- Assess model performance using diagnostic plots and AIC
- Identify the model that best captures HIV progression dynamics


## Methods

### Statistical Approaches

- Linear Mixed Effects Models (LMM)
- Nonlinear Mixed Effects Models (NLME)
- Random intercept models
- Random coefficient models

### Tools

- R
- nlme
- lme4
- tidyverse
- ggplot2
- corrplot

## Key Findings

- HIV-1 RNA levels decreased following treatment initiation.
- CD4 T-cell counts generally increased over time.
- Nonlinear models captured dynamics more effectively than linear models.
- Subject-specific random coefficients improved model fit.
- Model D achieved the lowest AIC and was selected as the final model.

![HIV RNA Trajectories](figures/RNA_spaghetti.png)

![CD4 Trajectories](figures/cd4_spaghetti.png)
