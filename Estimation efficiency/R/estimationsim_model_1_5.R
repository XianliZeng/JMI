setwd("C:\\Users\\a0123862\\Desktop\\simulation codes\\Estimation efficiency\\R")
source("computemse_model_1_5.R")




Model =c(1,2,3,4,5)
Mlength=length(Model)

OUT = matrix(0,  7*Mlength,6)
for (i in 1:Mlength)
{
  model = Model[i]
	print(c('model',model))
   for (j in 1:7)
     {
        n=400+400*j
	print(c('sample size',n))
        out = mse_compute_1_5(model, n,250);
        OUT[(i-1)*7+j,] = c(model, n, out$MSERESULT)
     }
} 
print(OUT)
lscv=matrix(OUT[,3],7,5)
plugin=matrix(OUT[,4],7,5)
thumb=matrix(OUT[,5],7,5)
jmi=matrix(OUT[6],7,5)



save(lscv, file='lscv_1_5')
save(plugin, file='plugin_1_5')
save(thumb, file='thumb_1_5')
save(jmi, file='jmi_1_5')


library(R.matlab)

writeMat('lscv_1_5.mat', lscv=lscv)
writeMat('plugin_1_5.mat', plugin=plugin)
writeMat('thumb_1_5.mat', thumb=thumb)
writeMat('jmi_1_5.mat', jmi=jmi)
