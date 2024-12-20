# -*- coding: utf-8 -*-
import numpy as np

#functions
def get_path(p,pc,e):
    d = [(-1,0),(1,0),(0,-1),(0,1)]
    sp = [pc]
    sps = set([pc])
    while pc != e:
        for dx,dy in d:
            pn = (pc[0] + dx,pc[1] + dy)
            if pn in p and not pn in sps:
                sps.add(pn)
                sp.append(pn)
                pc = pn
    return sp

def find_nonzero(X):
    p = X.nonzero()
    p = list(zip(p[0].tolist(),p[1].tolist()))
    return p

def time_saved(p,cheat_time):
    lsave = []
    for i in range(len(p)):
        for j in range(i,len(p)):
            mdist = abs(p[i][0]-p[j][0])+abs(p[i][1]-p[j][1])
            if (mdist <= cheat_time):
                    lsave.append(j-i-mdist)
    return lsave

#prepare variables ############################################################
input_path = '..\inputs\day_20.txt'
txt = open(input_path).read()
lines = txt.split('\n')

X = np.zeros((len(lines),len(lines[0])))
for i,line in enumerate(lines):
    X[i,:] = np.array([ord(c) for c in line]) #numeric into padded array
    
s = find_nonzero(X == 83)[0]
e = find_nonzero(X == 69)[0]
X[s] = 46
X[e] = 46
p = set(find_nonzero(X == 46))

sp = get_path(p,s,e)
#part 1 #######################################################################
print(sum(np.array(time_saved(sp,2))>=100))

#part 2 #######################################################################
print(sum(np.array(time_saved(sp,20))>=100))