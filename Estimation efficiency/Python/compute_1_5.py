import numpy as np
import numpy.random as nr
from math import log
import mixed 
import random

def MSE_compute_1_5(model,n,ITER):
        res1=np.zeros(ITER)
        res2=np.zeros(ITER)
        for j in range (ITER):
                random.seed(j)
                if model==1:
                        cov = [[1,0.9],[0.9,1]]
                        beta = 0.9
                        p_con, p_dis = 0.5, 0.5
                        gt = -p_con*0.5*log(np.linalg.det(cov))+p_dis*(log(2)+beta*log(beta)+(1-beta)*log(1-beta))-p_con*log(p_con)-p_dis*log(p_dis)
                        x_con,y_con = nr.multivariate_normal([0,0],cov,int(n*p_con)).T
                        x_dis = nr.binomial(1,0.5,int(n*p_dis))
                        y_dis = (x_dis + nr.binomial(1,1-beta,int(n*p_dis)))%2
                        x_dis, y_dis = 2*x_dis-np.ones(int(n*p_dis)), 2*y_dis-np.ones(int(n*p_dis))
                        x = np.concatenate((x_con,x_dis)).reshape((n,1))
                        y = np.concatenate((y_con,y_dis)).reshape((n,1))
                if model==2:
                        m=5
                        gt = log(m)-0.8*log(2)
                        x= nr.randint(m,size=n)
                        z= nr.uniform(0,2,size=n)
                        y=x+z   
                if model==3:
                        m=5
                        gt = 5*(log(m)-0.8*log(2))
                        x= nr.randint(m,size=5*n)
                        z= nr.uniform(0,2,size=5*n)
                        y=x+z
                        x=x.reshape((n,5))
                        y=y.reshape((n,5))
                if model==4:
                        p=0.15
                        gt = (1-p)*0.3012
                        x= nr.exponential(1,size=n)
                        z= nr.binomial(1,1-p,size=n)
                        w=nr.poisson(x,size=n)
                        y=z*w
                if model==5:
                        p=0
                        gt = (1-p)*0.3012
                        x= nr.exponential(1,size=n)
                        z= nr.binomial(1,1-p,size=n)
                        w=nr.poisson(x,size=n)
                        y=z*w
                res1[j]=(mixed.Mixed_KSG(x,y)-gt)*(mixed.Mixed_KSG(x,y)-gt)
                res2[j]=(mixed.KSG(x,y)-gt)*(mixed.KSG(x,y)-gt)
        MSE_Mixed_KSG = np.mean(res1)
        MSE_copulaksg = np.mean(res2)
        return [MSE_Mixed_KSG,MSE_copulaksg]             
        
