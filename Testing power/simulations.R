setwd("C:\\Users\\a0123862\\Desktop\\simulation codes\\Testing power")


source("power_calculation.R")

n = 320





Coef =1:25
Model =1:28
Clength=length(Coef)
Mlength=length(Model)

OUT = matrix(0,  Clength*Mlength,6)
for (i in 1:Mlength)
{
  model = Model[i]
  print(c('model',model));
   for (j in 1:Clength)
     {
        coef=Coef[j]
	print(c('coefficient', coef))
        out = POWER_CALCULATION(model, n,coef);
        OUT[(i-1)*Clength+j,] = c(model, coef, out$power)
     }
} 

print(OUT)


save(OUT, file='result')


library(R.matlab)

writeMat('result.mat', OUT = OUT)




