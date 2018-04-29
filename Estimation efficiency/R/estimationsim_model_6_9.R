setwd("C:\\Users\\a0123862\\Desktop\\simulation codes\\Estimation efficiency\\R")
source("computemse_model_6_9.R")




Model =c(6,7,8,9)
Mlength=length(Model)

OUT = matrix(0,  7*Mlength,3)
for (i in 1:Mlength)
{
  model = Model[i]
	print(c('model',model))
   for (j in 1:7)
     {
        n=100+100*j
	print(c('sample size',n))
        out = mse_compute_6_9(model, n,250);
        OUT[(i-1)*7+j,] = c(model, n, out$MSERESULT)
     }
} 
print(OUT)

jmi=matrix(OUT[,3],7,4)
save(jmi, file='jmi_6_9')


library(R.matlab)

writeMat('jmi_6_9.mat', jmi=jmi)




