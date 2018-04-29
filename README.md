# JMI

This folder contains all the codes for our simulations.

Our simulation involves the following R packages: 'FOREACH', 'doSNOW', 'FNN', 'HHG', 'minerva', 'energy', 'copula', 'ks','mJMI'.  We provide the file 'install packages.r' to install all of them.

File 'mJMI_0.1.0.zip' is the R package for our JMI method. It implements the estimation of mutual information and calculation of p-values for independence test. It can be installed directly under R.

Subfolder 'Estimation efficiency' contains the codes for calculating MSEs for different methods, models and sample sizes.  Because the codes provided by their corresponding authors were written using different languages, we put those code under different sub-subfolders  

 (1) sub-subfolder R contains 'mJMI', 'rule of thumb KDE', 'lscv KDE' and 'Plug in KDE';
 
 (2) sub-subfolder Python contains 'Mixed KSG' and 'copula based KSG' (see https://github.com/wgao9/mixed_KSG);
 
 (3) sub-subfolder Matlab contains 'Mirrored KDE' (see https://github.com/sss1/mirror-kde).

Subfolder 'Testing power' contains the codes for calculating statistical power of independence for different methods, models and noise levels. All the simulations are conducted in R. 

