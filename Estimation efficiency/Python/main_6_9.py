from compute_6_9 import MSE_compute_6_9
import numpy as np

def main():
    Model =[6,7,8,9]
    Mlength=len(Model)
    OUT = np.zeros((7*Mlength,4))
    for i in range (Mlength):
        model = Model[i]
        print "model", model
        for j in range (7):
            n=200+100*j
            print "sample size", n
            out =MSE_compute_6_9(model,n,250);
            print "mse", out
            OUT[i*7+j,:] = [model, n, out[0],out[1]];
    print "MSE", OUT
    np.savetxt('result_6_9.txt', OUT)
if __name__ == '__main__':
	main()                    

