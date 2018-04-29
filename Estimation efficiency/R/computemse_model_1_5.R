setwd("C:\\Users\\a0123862\\Desktop\\simulation codes\\Estimation efficiency\\R")


mse_compute_1_5 <- function(model, n,ITER)
{
library(foreach)
library(doSNOW)
  library(ks)
  library(mvtnorm)
  library(mJMI)
cL <- makeCluster(32, type="SOCK")
registerDoSNOW(cL)





BB = foreach(iter = 1:ITER,.packages = c("ks","mvtnorm","mJMI"), .combine = "cbind") %dopar%
{

  source('MI0.R')
  source('MIlscv.R')
  source('MIplugin.R')




mseLSCV=rep(0,ITER)
msePlugin=rep(0,ITER)
mseThumb=rep(0,ITER)
msejmi=rep(0,ITER)

set.seed(iter)

if (model==1){
mu=c(0,0)
      cov = matrix(c(1,0.9,0.9,1),2,2)
	beta = 0.9
	p_con=0.5
      p_dis = 0.5
	gt = -p_con*0.5*log(det(cov))+p_dis*(log(2)+beta*log(beta)+(1-beta)*log(1-beta))-p_con*log(p_con)-p_dis*log(p_dis)
      normalsample=rmvnorm(n*p_con,mu,cov)
	x_con=normalsample[,1]
      y_con=normalsample[,2]
 	x_dis = rbinom(n*p_con,1,0.5)
	y_dis = (x_dis + rbinom(n*p_con,1,1-beta))%%2
	x_dis= 2*x_dis-matrix(1,1,n*p_dis)
      y_dis = 2*y_dis-matrix(1,1,n*p_dis)

	x = matrix(c(x_con,x_dis),n,1)
	y = matrix(c(y_con,y_dis),n,1)
}

if (model==2){
 gt=log(5)-0.8*log(2)
      x=sample(5,n,T)
	z=runif(n,0,2)
 	y=x+z
	x = matrix(x,n,1)
	y = matrix(y,n,1)
}


if (model==3){
 gt=5*log(5)-4*log(2)

      x=sample(5,n*5,T)
	z=runif(n*5,0,2)
 	y=x+z
      x=matrix(x,n,5)
      y=matrix(y,n,5)
}

if (model==4){
p=0.15
gt=(1-p)*0.3012
x=rexp(n,1)
z=rpois(n,x)
y0=rbinom(n,1,1-p)
y=y0*z
	x = matrix(x,n,1)
	y = matrix(y,n,1)
}


if (model==5){
p=0
gt=(1-p)*0.3012
x=rexp(n,1)
z=rpois(n,x)
y0=rbinom(n,1,1-p)
y=y0*z
	x = matrix(x,n,1)
	y = matrix(y,n,1)
}


if (model==3)
{
lscv=0
plugin=0
} else{
lscv=MIlscv(x,y)$mi
plugin=MIplugin(x,y)$mi
}
simple=MI0(x,y)$mi
jmi=mJMICpp(x,y,0)$mi

if (model==3)
{
mseLSCV=0
msePlugin=0
}else{
mseLSCV=(lscv-gt)^2
msePlugin=(plugin-gt)^2
}
mseSimple=(simple-gt)^2
mseJMI=(jmi-gt)^2
c(mseLSCV,msePlugin,mseSimple,mseJMI)
}
stopCluster(cL)

LSCV=mean(BB[1,])
Plugin=mean(BB[2,])
Simple=mean(BB[3,])
JMI=mean(BB[4,])

MSERESULT=c(LSCV,Plugin,Simple,JMI)
  return(list(MSERESULT= MSERESULT))
}


