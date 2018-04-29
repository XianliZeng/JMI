function mirrormse=msecalculate(model,n,Iteration)

 mse=zeros(Iteration,1);

 
parfor j =1:Iteration
rng(j)
 
 if (model==1)
     mu=[0;0];
	cov = [1,0.9;0.9,1];
	beta = 0.9;
	pcon=0.5;
     pdis = 0.5;
	gt = -pcon*0.5*log(det(cov))+pdis*(log(2)+beta*log(beta)+(1-beta)*log(1-beta))-pcon*log(pcon)-pdis*log(pdis)

    xy = mvnrnd(mu,cov,n*pcon);
    xcon=xy(:,1);
    ycon=xy(:,2);
	xdis = binornd(1,0.5,n*pdis,1);
	ydis = mod((xdis + binornd(1,1-beta,n*pdis,1)),2);
	xdis= 2*xdis-ones(n*pdis,1);
	ydis =2*ydis-ones(n*pdis,1);
    x = [xcon;xdis];
    y = [ycon;ydis];
end
if (model==2)
    	gt = log(5)-0.8*log(2);

   x=randsample(5,n,true)-1;
   u=rand(n,1)*2;
   y=u+x;
end
if (model==3)
    gt = 5*(log(5)-0.8*log(2));
      x=randsample(5,n*5,true)-1;
   u=rand(5*n,1)*2;
   y=u+x;
          x=reshape(x,n,5);
          y=reshape(y,n,5);
    
end
if (model==4)
     prob=0.15 ;
gt =0.3012.*(1-prob);  
x=exprnd(1,n,1);
            z=binornd(1,1-prob,n,1);
            w=poissrnd(x,n,1);
            y=z.*w;
end
if (model==5)
         prob=0 ;
gt =0.3012.*(1-prob);  
x=exprnd(1,n,1);
            z=binornd(1,1-prob,n,1);
            w=poissrnd(x,n,1);
            y=z.*w;
end
kernel=@(x) normpdf(x)
   res=mirror_kde_mi(kernel,x,y);

   mse(j)=(res-gt)^2;

end
mirrormse=mean(mse);

