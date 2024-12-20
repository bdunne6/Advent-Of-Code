# -*- coding: utf-8 -*-
import numpy as np
from itertools import product
import networkx as nx
import matplotlib.pyplot as plt

#functions
def find_nonzero(X):
    p = X.nonzero()
    p = list(zip(p[0].tolist(),p[1].tolist()))
    return p

def cheat_paths(p):
    p = list(p)
    cp = []
    for i in range(len(p)):
        for j in range(i,len(p)):
            if abs(p[i][0]-p[j][0])+abs(p[i][1]-p[j][1]) == 2:
                    cp.append((p[i],p[j]))
    return cp
            

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
d = set([(-1,0),(1,0),(0,-1),(0,1)])
dc = set([(-2,0),(2,0),(0,-2),(0,2),(-1,-1),(1,-1),(1,-1),(1,1)])

#part 1

G = nx.Graph()
for px,py in p:
    for dx,dy in d:
        pn = (px + dx,py + dy)
        if pn in p:
            G.add_edge((px,py),pn,weight =1)
sp0 = nx.shortest_path(G, s,e)

cp = cheat_paths(p)
plens = []
for ps,pe in cp:
    G.add_edge(ps,pe,weight = 2)
    plens.append(len(nx.shortest_path(G, s,e)))
    G.remove_edge(ps,pe)
        

print(sum(len(sp0) - np.array(plens) >= 100))


# plens = []
# for px,py in p:
#     for dx,dy in dc:
#         pn = (px + dx,py + dy)
#         if pn in p:
#             G.add_edge((px,py),pn,weight =1)
#             plens.append(len(nx.shortest_path(G, s,e)))
#             G.remove_edge((px,py),pn)
        

# print(sum(len(sp0) - np.array(plens) >= 100))


# plt.imshow(X)
# [px,py] = zip(*sp)
# px = np.array(px)
# py = np.array(py)
# plt.plot(py,px,'.r')

            