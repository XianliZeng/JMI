MI0 <- function(x,y)
{
n = nrow(x);
p = ncol(x);
q = ncol(y);




ones = matrix(1, 1, n)

kx = 0
ky = 0;
for (i in 1:p)
{
	kxi = x[,i]%*% ones;
	kx = kx + abs(kxi - t(kxi))^2;
}
for (i in 1:q)
{
	kyi = y[,i]%*% ones;
	ky = ky + abs(kyi - t(kyi))^2;
}   

hx1 = (4/(p+2))^(1/(p+4))*mean(apply(x,2,sd))/n^(1/(p+4));
hy1 = (4/(q+2))^(1/(q+4))*mean(apply(y,2,sd))/n^(1/(q+4));

h2=(4/(p+q+2))^(1/(p+q+4))*(p*mean(apply(x,2,sd))+q*mean(apply(y,2,sd)))/(p+q)/n^(1/(p+q+4));



   
hx1sq = 2*hx1^2;
hy1sq = 2*hy1^2;

hx2sq = 2*h2^2;
hy2sq = 2*h2^2; 
   kx1 = 1/hx1*exp(-kx/hx1sq);
   kx2 = 1/h2*exp(-kx/hx2sq);

   fx = colMeans(kx1)*n/(n-1);
   
   ky1 = 1/hy1*exp(-ky/hy1sq);
   ky2 = 1/h2*exp(-ky/hy2sq);

   fy = colMeans(ky1)*n/(n-1);
     fxfy = fx*fy;  
   kxy=kx2*ky2 

   fxy=colMeans(kxy)*n/(n-1);

   mi = mean(log(fxy/fxfy));

return(list(mi=mi))

}







