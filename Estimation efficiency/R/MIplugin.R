MIplugin <- function(x,y)
{
#library(ks)

n = nrow(x);
p = ncol(x);
q = ncol(y);

x = matrix(x, n,p)
y = matrix(y, n,q)
y = apply(y,2,rank)/(n+1);
x = apply(x,2,rank)/(n+1);
if (p==1)
{
fhat = kde(x)
h=fhat$h
if (h<=0.001){h=0.001}
fx = kde(x, h=h,eval.point=x)$estimate
}else{
h=Hpi.diag(x)
for (ip in 1:p)
{
if (h[ip,ip]<=0.001^2) {h[ip,ip]=0.001^2}
}
fx = kde(x, h=h,eval.point=x)$estimate
}

if (q==1)
{
fhat = kde(y)
h=fhat$h
if (h<=0.001){h=0.001}
fy = kde(y, h=h,eval.point=y)$estimate
}else{
h=Hpi.diag(y)
for (iq in 1:q)
{
if (h[iq,iq]<=0.001^2) {h[iq,iq]=0.001^2}
}
fy = kde(y, h=h,eval.point=y)$estimate
}
xy = matrix(c(x,y), n, p+q)
H = Hpi.diag(xy);
for (i in 1:(p+q))
{
if (H[i,i]<=0.001^2) {H[i,i]=0.001^2}
}

fxy = kde(xy, H=H,eval.point=xy)$estimate


mi = mean(log(fxy/fx/fy))

return(list(mi=mi))
}