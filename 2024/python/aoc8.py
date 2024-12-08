# -*- coding: utf-8 -*-
import numpy as np
import matplotlib.pyplot as plt

def filter_antinodes(a,X):
    iv = (a[:,0]>=0)&(a[:,0]<X.shape[0])&(a[:,1]>=0)&(a[:,1]<X.shape[1]);
    a = a[iv,:]
    a = np.unique(a,axis=0)
    return a

#prepare variables ############################################################
input_path = '..\inputs\day_8.txt'
txt = open(input_path).read()
lines = txt.split('\n')

X = np.zeros((len(lines),len(lines[0])))
for i,line in enumerate(lines):
    X[i,:] = np.array([ord(c) for c in line])
    
X[X==46] = 0
X[X==35] = 0


ufreq = np.array(list(set(X.flatten())))
ufreq = ufreq[ufreq!=0]
#part 1 #######################################################################
a = np.zeros((0,2))
for f in ufreq:
    rc = np.vstack((f == X).nonzero()).transpose()
    for rci in rc:
        rd  = rci[0] - rc[:,0]
        rd = rd[rd!=0]
        cd  = rci[1] - rc[:,1]
        cd = cd[cd!=0]
        rcd = np.vstack((rd,cd)).transpose()
        for rcdi in rcd:
            a1 = rci - 2*rcdi
            a2 = rci + rcdi
            a = np.vstack((a,a1,a2)) 
            
a = filter_antinodes(a, X)

print(a.shape[0])

#part 2 #######################################################################
a = np.zeros((0,2))
ms = len(X)
for f in ufreq:
    rc = np.vstack((f == X).nonzero()).transpose()
    for rci in rc:
        rd  = rci[0] - rc[:,0]
        rd = rd[rd!=0]
        cd  = rci[1] - rc[:,1]
        cd = cd[cd!=0]
        rcd = np.vstack((rd,cd)).transpose()
        for rcdi in rcd:
            x = np.arange(-ms,ms).reshape(-1,1)
            a1 = rci - x*rcdi
            a = np.vstack((a,a1)) 
            
a = filter_antinodes(a, X)
print(a.shape[0])

