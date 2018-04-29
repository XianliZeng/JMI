###set path
setwd("C:\\Users\\a0123862\\Desktop\\simulation codes\\Testing power")

POWER_CALCULATION <- function(model, n,coef)
{
library(HHG)
library(minerva)
library(energy)
library(mJMI)
library(foreach)
library(doSNOW)
cL <- makeCluster(60, type="SOCK")
registerDoSNOW(cL)

ITER = 1000;
BB = foreach(iter = 1:ITER,.packages=c("HHG","minerva","energy","mJMI"), .combine = "cbind") %dopar%
#for(iter in 1:ITER) 
{



set.seed(iter)


if (model<=16)
{
noise=10^(1/24*(coef-1))
} else if ((model>17 & model<=24)| (model>=26)){
n1=76-3*coef
} else {
n1=104-4*coef}



###define models
if (model == 1)  #linear with symmetric additive noise

{	
                xs = rnorm(n);
                ys = (2/3)*xs + noise*rnorm(n);
}



  if (model == 2)    #linear with asymmetric additive noise
{
              xs = rnorm(n)
            ys = (0.05)*xs+ noise*(rnorm(n)^2-1);

  
}


if (model == 3)   #quadratic with addtive noise
{
                xs = rnorm(n);
          ys = (2/3)*xs^2 + noise*rnorm(n);

 }               
      
    
if (model == 4)    #circle with additive noise
{
                thetas = 2*pi*runif(n);
                xs = 10*cos(thetas) + noise*rnorm(n);
                ys = 10*sin(thetas) + noise*rnorm(n);
 }
               



  if (model ==5)    # spiral circle with additive noise 
{


     u = runif(n)*4;
            xs = 3*u*sin( u*pi ) + noise*rnorm(n);
            ys = 3*u*cos( u*pi ) + noise*rnorm(n);


}




if (model == 6)    #cloud with additive noise
{
z1=runif(n);
z2=runif(n);
                xcs = floor(5*z1);
                ycs = 2*floor(2*z2) + (xcs%%2);
                xs = 10*(xcs + runif(n)) + noise*rnorm(n);
                ys = 10*(ycs + runif(n)) + noise*rnorm(n);
}      
  
  
  
  if (model == 7)    #sin with additive noise
  {        
    xs =runif(n);
    ys = sin((20+7*noise)*pi*xs) ;
  }
  
  

if (model == 8)   #diamond with additive noise
{

            x = runif(n)*2-1;
            y = runif(n)*2-1;
            theta = -pi/4;

            rr = matrix(c(cos(theta), sin(theta), -sin(theta), cos(theta)),2,2);
         tmp = matrix(c(x, y), n, 2) %*% rr;

            xs = 10*tmp[,1] + noise*rnorm(n);
            ys = 10*tmp[,2] + noise*rnorm(n);

}


   
      if (model==9) #x-para with additive noise
{           
             xs= runif(n)*2-1;
       ys = (4*xs^2 )*((runif(n)>0.5)*2-1)+ noise*rnorm(n);

 }
   
if (model==10) #step with additive noise
{
   xs = runif(n)*8-2
    err=rnorm(n)

    xerr=xs+noise*err
    xerrorder=xerr[order(xerr)]
    ys=(xerr>xerrorder[80] & xerr<xerrorder[241])*1

}




if (model == 11)  #conditional variance
{	

xs=matrix(rnorm(5*n,0,1),n,5);

e=matrix(rnorm(5*n,0,1),n,5);


ys=sqrt(0.5*xs^2+noise)*e;

}

if (model == 12)  #multivariate logarithm with additive noise

{	

xs=matrix(rnorm(5*n,0,1),n,5);

e=matrix(rnorm(5*n,0,1),n,5);


ys=log(xs^2)+2*noise*e;

}




if (model == 13)  #mulltivariate polynomial with additive noise1

{	

xs=matrix(rnorm(5*n,0,1),n,5);

e=matrix(rnorm(5*n,0,1),n,5);

ys1=xs[,1:2]+4*(xs[,1:2])^2+5*noise*e[,1:2]
ys2=5*noise*e[,3:5]

ys=cbind(ys1,ys2)

}


if (model == 14)   #mulltivariate polynomial with additive noise2


{	

xs=matrix(rnorm(5*n,0,1),n,5);

e=matrix(rnorm(5*n,0,1),n,5);

ys1=3*xs[,1:2]+2.5*(xs[,1:2])^2+5*noise*e[,1:2]
ys2=5*noise*e[,3:5]

ys=cbind(ys1,ys2)

}





if (model == 15)  #multivariate logarithm with additive noise

{	

xs=matrix(rnorm(20*n,0,1),n,20);

e=matrix(rnorm(20*n,0,1),n,20);


ys=log(xs^2)+2*noise*e;

}


if (model==16)  #multivariate linear with additive noise
{
xs=matrix(rnorm(50*n,0,1),n,50);
consmt=matrix(0,50,5)
consmt[1:10,1]=rep(1,10)
consmt[11:20,2]=rep(1,10)
consmt[21:30,3]=rep(1,10)
consmt[31:40,4]=rep(1,10)
consmt[41:50,5]=rep(1,10)

e=matrix(rnorm(5*n,0,1),n,5);
ys=0.3*xs%*%consmt+noise*e;
}








if (model == 17)   #linear with contaminatied noise
{	
x1=runif(n-n1,-3,3);
y1=runif(n-n1,-3,3);


                xs = rnorm(n1);
                ys = (2/3)*xs ;
xs=c(xs,x1)
ys=c(ys,y1)
}



if (model == 18)   #quadratic with contaminatied noise
{
x1=runif(n-n1,-3,3);
y1=runif(n-n1,-1,7);
                xs = rnorm(n1);
          ys = (2/3)*xs^2;
xs=c(xs,x1)
ys=c(ys,y1)
 }        

           
if (model == 19)   #circle with contaminatied noise
{
x1=runif(n-n1,-12,12);
y1=runif(n-n1,-12,12);
                thetas = 2*pi*runif(n1);
                xs = 10*cos(thetas) ;
                ys = 10*sin(thetas);
xs=c(xs,x1)
ys=c(ys,y1)

 }
  if (model == 20)   # spiral circle with contaminatied noise 
{

        x1=runif(n-n1-25,-12,10);
       y1=runif(n-n1-25,-12,14);

     u = runif(n1+25)*4;
            xs = 3*u*sin( u*pi );
            ys = 3*u*cos( u*pi );
      xs=c(x1,xs)
      ys=c(y1,ys)
}
   


            
if (model == 21) #cloud with contaminatied noise
{
x1=runif(n-n1,-5,45);
y1=runif(n-n1,-5,35);
z1=runif(n1);
z2=runif(n1);
                xcs = floor(5*z1);
                ycs = 2*floor(2*z2) + (xcs%%2);
            xs=10*xcs
            ys=10*ycs
            xs=c(xs,x1)
            ys=c(ys,y1)

}       


  
  if (model == 22)   #sin with contaminatied noise
  {  
    x1=runif(n-n1,-pi,6*pi);
    y1=runif(n-n1,-3,3);      
    xs = 5*pi*runif(n1);
    ys = 2*sin(xs);
    xs=c(xs,x1)
    ys=c(ys,y1)
    
  }
  
  
  
if (model == 23) #diamond with contaminatied noise
{
x1=runif(n-3*n1,-15,15);
y1=runif(n-3*n1,-15,15);
      
         
        
         x2 = runif(3*n1)*2-1;
        y2 = runif(3*n1)*2-1;
            theta = -pi/4;

   rr = matrix(c(cos(theta), sin(theta), -sin(theta), cos(theta)),2,2);
            tmp = matrix(c(x2, y2), 3*n1, 2) %*% rr;

            xs = 10*tmp[,1] ;
            ys = 10*tmp[,2] ;
            xs=c(xs,x1)
            ys=c(ys,y1)
}


  if (model == 24)   # x-para with contaminatied noise
{


x1=runif(n-n1,-1.5,1.5);
y1=runif(n-n1,-5,5);

        xs= runif(n1)*2-1;
       ys = (xs^2 )*((runif(n1)>0.5)*2-1);
            xs=c(xs,x1)
            ys=c(ys,y1)
  


}

if (model == 25) #step with contaminatied noise
{
x1=runif(n-n1,-5,5)
y1=runif(n-n1,-0.5,1.5)
   xs = runif(n1)*8-4
    xsorder=xs[order(xs)]
    ys=(xs>xsorder[(n1/4)] & xs<xsorder[n1/4*3+1])*1

xs=c(xs,x1)
ys=c(ys,y1)

}




if (model == 26) #multivariate logarithm with contaminated noise

{
x1=matrix(runif(5*(n-n1),-3,3),n-n1,5)
y1=matrix(runif(5*(n-n1),-10,4),n-n1,5)
   xs=matrix(rnorm(5*n1,0,1),n1,5);
   ys=log(xs^2);

   xs=rbind(xs,x1);
   ys=rbind(ys,y1);
}





if (model == 27)   #multivariate polynomial with contaminated noise1

{
x1=matrix(runif(5*(n-n1),-2,2),n-n1,5)
y1=matrix(runif(5*(n-n1),-2,18),n-n1,5)
	
xs=matrix(rnorm(5*n1,0,1),n1,5);

e=matrix(rnorm(5*n1,0,1),n1,5);

ys1=xs[,1:2]+4*(xs[,1:2])^2
ys1=matrix(ys1,n1,2)
ys2=matrix(0,n1,3)

ys=cbind(ys1,ys2)
   xs=rbind(xs,x1);
   ys=rbind(ys,y1);
}

if (model == 28)  #multivariate polynomial with contaminated noise2

{
x1=matrix(runif(5*(n-n1),-2,2),n-n1,5)
y1=matrix(runif(5*(n-n1),-2,18),n-n1,5)
	
xs=matrix(rnorm(5*n1,0,1),n1,5);

e=matrix(rnorm(5*n1,0,1),n1,5);

ys1=3*xs[,1:2]+2.5*(xs[,1:2])^2
ys1=matrix(ys1,n1,2)
ys2=matrix(0,n1,3)

ys=cbind(ys1,ys2)
   xs=rbind(xs,x1);
   ys=rbind(ys,y1);
}






xs=as.matrix(xs)
ys=as.matrix(ys)

ys_null=ys[sample(n),]

	X = xs;
	Y =ys;
	Y_NULL= ys_null;





# MIC  
if ((model>=11 & model<=16) |(model>=26)){
	amic = 0
    amic_null=1
}else
{
	amic = mine(X, Y)$MIC
    amic_null=mine(X,Y_NULL)$MIC
}



	Dx = as.matrix(dist((X)), diag = TRUE, upper = TRUE) 
	Dy = as.matrix(dist((Y)), diag = TRUE, upper = TRUE)
	hhg = hhg.test(Dx, Dy, nr.perm = 1000)
	aHHG = (hhg$perm.pval.hhg.sc <0.05)+0 


adcor=dcor(X,Y)
adcor_null=dcor(X,Y_NULL)

     jmi=mJMICpp(X,Y,1000)
     ajmi=(jmi$pvalue<0.05)+0


c(adcor,aHHG,amic,ajmi,adcor_null,amic_null)
}

stopCluster(cL)
bdcor=quantile(BB[5,],0.95);
bmic=quantile(BB[6,],0.95);

pdcor=mean(BB[1,]>bdcor)
pHHG=mean(BB[2,])
pmic=mean(BB[3,]>bmic)
pJMI=mean(BB[4,])




power=c(pdcor,pHHG,pmic,pJMI)

  return(list(power = power))
}




