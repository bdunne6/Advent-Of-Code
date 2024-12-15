# -*- coding: utf-8 -*-
import numpy as np
import matplotlib.pyplot as plt
#functions 
def in_range(rc,shape):
    r,c = [rc[0],rc[1]]
    return (r>=0) and (c>=0) and (r<shape[0]) and (c<shape[1])

#prepare variables ############################################################
input_path = '..\inputs\day_15.txt'
txt = open(input_path).read()
lines = txt.split('\n')
i_split = [i for i in range(len(lines)) if len(lines[i])==0]
lines_map = lines[:i_split[0]]
lines_moves = lines[i_split[0]+1:]
moves = ''.join(lines_moves)

X = np.zeros((len(lines_map),len(lines_map[0])))
for i,line in enumerate(lines_map):
    X[i,:] = np.array([ord(c) for c in line]) #numeric into padded array

mm = {'^': [-1,0] ,'v':[1,0],'<':[0,-1],'>':[0,1]}

rp = (X == 64).nonzero()
rp = (rp[0][0],rp[1][0])

for i,m in enumerate(moves):
    d = mm[m]
    rpn = (rp[0]+d[0],rp[1]+d[1])
    if X[rpn] == 46:
       X[rpn] = 64
       X[rp] = 46
       rp = rpn
    elif X[rpn] == 79:
        rpt = (rpn[0]+d[0],rpn[1]+d[1])
        while in_range(rpt,X.shape):
            if X[rpt] == 46:
                X[rpt] = 79
                X[rpn] = 64
                X[rp] = 46
                rp = rpn
                break
            if X[rpt] == 35:
                break
            print(str(i))
            rpt = (rpt[0]+d[0],rpt[1]+d[1])

bdist = np.array(np.where(X==79)).T
dsum = sum(bdist[:,0]*100+bdist[:,1])
print(dsum)
        
plt.imshow(X)
plt.title(str(i)+' ' +m )
plt.savefig('plots\\'+str(i)+'.png')