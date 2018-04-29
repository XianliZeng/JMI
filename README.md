# JMI

This document contains all  codes for simulations of "Jackknifed Mutual Information - an Efficient and Numerically Stable Measure of Dependence".

The codes involves several R packages:
'FOREACH', 'doSNOW', 'FNN', 'HHG', 'minerva', 'energy', 'copula', 'ks','mJMI'.
The file 'install packages.r'is for installing them.

File 'mJMI_0.1.0.zip' contains the R package of JMI method, including estimation of mutual information and calculation of statistical power of independence test based on JMI.

The file 'Estimation efficiency' contains the codes for calculating MSEs for different methods, models and sample sizes.Results for 'mJMI', 'rule of thumb KDE', 'lscv KDE' and 'Plug in KDE' are calculated in R; 
results for Mixed KSG and copula based KSG are calculated in Python; results for Mirrored KDE are calculated in matlab.

The file 'Estimation efficiency' contains the codes for calculating statistical power of independence test for different methods, models and noise levels.All the simulations are conducted in R.
