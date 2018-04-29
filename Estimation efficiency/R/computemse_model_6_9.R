setwd("C:\\Users\\a0123862\\Desktop\\simulation codes\\Estimation efficiency\\R")

mse_compute_6_9 <- function(model, n,ITER)
{
library(foreach)
library(doSNOW)
  library(mvtnorm)
  library(mJMI)
cL <- makeCluster(32, type="SOCK")
registerDoSNOW(cL)





BB = foreach(iter = 1:ITER,.packages = c("mvtnorm","mJMI"), .combine = "cbind") %dopar%
{


msejmi=rep(0,ITER)

set.seed(iter)

if (model==6){
mu=c(0,0)
      cov = matrix(c(1,0.9,0.9,1),2,2)
	beta = 0.9
	p_con=0.5
      p_dis = 0.5
	gt = 20*(-p_con*0.5*log(det(cov))+p_dis*(log(2)+beta*log(beta)+(1-beta)*log(1-beta))-p_con*log(p_con)-p_dis*log(p_dis))
      normalsample=rmvnorm(n*p_con*20,mu,cov)
	x_con=normalsample[,1]
      y_con=normalsample[,2]
 	x_dis = rbinom(n*p_dis*20,1,0.5)
	y_dis = (x_dis + rbinom(n*p_dis*20,1,1-beta))%%2
	x_dis= 2*x_dis-matrix(1,1,n*p_dis*20)
      y_dis = 2*y_dis-matrix(1,1,n*p_dis*20)

	x = matrix(c(x_con,x_dis),n,20)
	y = matrix(c(y_con,y_dis),n,20)
}

if (model==7){
 gt=(log(5)-0.8*log(2))*20
      x=sample(5,n*20,T)
	z=runif(n*20,0,2)
 	y=x+z
	x = matrix(x,n,20)
	y = matrix(y,n,20)
}



if (model==8){
p=0.15
gt=(1-p)*0.3012*20
x=rexp(n*20,1)
z=rpois(n*20,x)
y0=rbinom(n*20,1,1-p)
y=y0*z
	x = matrix(x,n,20)
	y = matrix(y,n,20)
}


if (model==9){
p=0
gt=(1-p)*0.3012*20
x=rexp(n*20,1)
z=rpois(n*20,x)
y0=rbinom(n*20,1,1-p)
y=y0*z
	x = matrix(x,n,20)
	y = matrix(y,n,20)
}


jmi=mJMICpp(x,y,0)$mi

mseJMI=(jmi-gt)^2
c(mseJMI)
}
stopCluster(cL)

JMI=mean(BB[1,])

MSERESULT=c(JMI)
  return(list(MSERESULT= MSERESULT))
}


