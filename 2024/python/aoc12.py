# -*- coding: utf-8 -*-
import numpy as np
from scipy.signal import convolve2d as conv2
from scipy.ndimage import label

#prepare variables ############################################################
input_path = '..\inputs\day_12.txt'
lines = open(input_path).read().split('\n')
X = np.zeros((len(lines)+2,len(lines[0])+2))
for i,line in enumerate(lines):
    X[i+1,1:-1] = np.array([ord(c) for c in line]) #numeric into padded array
    
#part 1 #######################################################################    
k = np.array([[0,1,0],[1,1,1],[0,1,0]])
uX = np.unique(X.flatten())[1:]
P = 0
for v in uX:
    Xi = (v==X).astype(int)
    XiL = label(Xi,k)[0]
    uXiL = np.unique(XiL.flatten())[1:]
    for u in uXiL:
        Xi2 = (u==XiL).astype(int)
        Xe = conv2(X,k,'same')>0 #image dilation
        Xes = conv2(Xi2,k,'same')
        Xp = Xe-Xi2
        Xp = Xp*Xes
        P += sum(Xp.flatten())*sum(Xi2.flatten())
print(P)

#part 2 #######################################################################
def corr2(X,k):
    X = X - np.mean(X.flatten());
    k = k - np.mean(k.flatten());
    return conv2(X,k,'same')/np.sum(k.flatten()**2);

kd = [np.array([[1,0],[0,1]]),np.array([[0,1],[1,0]])];
ks = [];
ksb = np.array([[1,0],[0,0]]);
for i1 in range(0, 4):  
    ks.extend([np.rot90(1-ksb, i1),np.rot90(ksb, i1)])         
P = 0;
for v in uX:
    Xi = (v==X).astype(int)
    XiL = label(Xi,k)[0]
    uXiL = np.unique(XiL.flatten())[1:]
    for u in uXiL:
        Xi2 = (u==XiL).astype(int)
        sides = 0;
        for kde in kd:
            sides = sides + 2*np.sum(np.isclose(corr2(Xi2,kde),1));
        for kse in ks:
            sides = sides + 1*np.sum(np.isclose(corr2(Xi2,kse),1));
        P = P + sides*sum(Xi2.flatten())
print(P)