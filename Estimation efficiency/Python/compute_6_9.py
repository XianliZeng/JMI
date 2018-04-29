import numpy as np
import numpy.random as nr
from math import log
import mixed 
import random

def MSE_compute_6_9(model,n,ITER):
        res1=np.zeros(ITER)
        res2=np.zeros(ITER)
        for j in range (ITER):
                random.seed(j)
                if model==6:
                        cov = [[1,0.9],[0.9,1]]
                        beta = 0.9
                        p_con, p_dis = 0.5, 0.5
                        gt = (-p_con*0.5*log(np.linalg.det(cov))+p_dis*(log(2)+beta*log(beta)+(1-beta)*log(1-beta))-p_con*log(p_con)-p_dis*log(p_dis))*20
                        x_con,y_con = nr.multivariate_normal([0,0],cov,int(n*p_con*20)).T
                        x_con=x_con.reshape(int(n*p_con),20)
                        y_con=y_con.reshape(int(n*p_con),20)
                        x_dis = nr.binomial(1,0.5,int(n*p_dis*20))
                        y_dis = (x_dis + nr.binomial(1,1-beta,int(n*p_dis*20)))%2
                        x_dis, y_dis = 2*x_dis-np.ones(int(n*p_dis*20)), 2*y_dis-np.ones(int(n*p_dis*20))
                        x_dis=x_dis.reshape(int(n*p_dis),20)
                        y_dis=y_dis.reshape(int(n*p_dis),20)
                        x = np.concatenate((x_con,x_dis)).reshape((n,20))
                        y = np.concatenate((y_con,y_dis)).reshape((n,20))
                if model==7:
                        m=5
                        gt = (log(m)-0.8*log(2))*20
                        x= nr.randint(m,size=n*20)
                        z= nr.uniform(0,2,size=n*20)
                        y=x+z
                        x=x.reshape(n,20)
                        y=y.reshape(n,20)
                if model==8:
                        p=0.15
                        gt = (1-p)*0.3012*20
                        x= nr.exponential(1,size=n*20)
                        z= nr.binomial(1,1-p,size=n*20)
                        w=nr.poisson(x,size=n*20)
                        y=z*w
                        x=x.reshape(n,20)
                        y=y.reshape(n,20)                        
                if model==9:
                        p=0
                        gt = (1-p)*0.3012*20
                        x= nr.exponential(1,size=n*20)
                        z= nr.binomial(1,1-p,size=n*20)
                        w=nr.poisson(x,size=n*20)
                        y=z*w
                        x=x.reshape(n,20)
                        y=y.reshape(n,20)
                res1[j]=(mixed.Mixed_KSG(x,y)-gt)*(mixed.Mixed_KSG(x,y)-gt)
                res2[j]=(mixed.KSG(x,y)-gt)*(mixed.KSG(x,y)-gt)
        MSE_Mixed_KSG = np.mean(res1)
        MSE_copulaksg = np.mean(res2)
        return [MSE_Mixed_KSG,MSE_copulaksg]             
        
