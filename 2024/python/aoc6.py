# -*- coding: utf-8 -*-
import numpy as np
import matplotlib.pyplot as plt

def tupify(X):
    return tuple(tuple(x) for x in X)

def in_range(r,c,shape):
    return (r>=0) and (c>=0) and (r<shape[0]) and (c<shape[1])

def run(p,d,path_set,X,dir_map,V):
    loop = False;
    while True:
        if (tupify([p,d])) in path_set:
            loop = True
            break
        path_set.add(tupify([p,d]))
        V[p[0],p[1]] += 1
        
        pn = p+d
        if not in_range(pn[0],pn[1],X.shape):
            break
        for i in range(4):
            if X[pn[0],pn[1]] == 1:
                d = dir_map[tuple(d)]
                pn = p+d;
        p = p + d
    return [p,d,path_set,V,loop]

#prepare variables ############################################################
input_path = '..\inputs\day_6.txt'
txt = open(input_path).read()

lines = txt.split('\n')

char_map = {'.': 0, '#': 1, '^': 2}

X = np.zeros((len(lines),len(lines[0])))
for i,line in enumerate(lines):
    X[i,:] = np.array([char_map[c] for c in line])

keys = [(-1,0),(0,-1),(0,1),(1,0)]
vals = [(0,1),(-1,0),(1,0),(0,-1)]
dir_map = dict(zip(keys,vals))

#part 1 #######################################################################
V = np.zeros(X.shape)
d = np.array([-1,0])
p = np.array((X == 2).nonzero()).flatten()
path_set = set()

[p,d,path_set,V,loop] = run(p,d,path_set,X,dir_map,V)
pV = np.array(V.nonzero()).transpose()

print(pV.shape[0])

#part 2 #######################################################################
loop_cnt = 0
for i,pi in enumerate(pV):
    path_set = set()
    V = np.zeros(X.shape)
    d = np.array([-1,0])
    p = np.array((X == 2).nonzero()).flatten()
    
    X1 = X.copy()
    
    if X1[pi[0],pi[1]] == 2:
        continue
    X1[pi[0],pi[1]] = 1
    
    [p1,d1,path_set1,V1,loop] = run(p,d,path_set,X1,dir_map,V)
    if loop:
        loop_cnt += 1

print(loop_cnt)





        
    

