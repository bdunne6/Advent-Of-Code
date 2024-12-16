# -*- coding: utf-8 -*-
import numpy as np
import matplotlib.pyplot as plt
from collections import deque
from itertools import product
import networkx as nx


#functions
def find_nonzero(X):
    p = X.nonzero()
    p = list(zip(p[0].tolist(),p[1].tolist()))
    return p
    

#prepare variables ############################################################
input_path = '..\inputs\day_16.txt'
txt = open(input_path).read()
lines = txt.split('\n')

X = np.zeros((len(lines),len(lines[0])))
for i,line in enumerate(lines):
    X[i,:] = np.array([ord(c) for c in line]) #numeric into padded array
    


#part 1 #
s = find_nonzero(X == 83)[0]
e = find_nonzero(X == 69)[0]

X[s] = 46
X[e] = 46

p = set(find_nonzero(X == 46))
#plt.imshow(X)

G = nx.DiGraph()
d = set([(-1,0),(1,0),(0,-1),(0,1)])

pd = set(product(p,d))

mdict = {(-1,0):[(0,1),(0,-1),(-1,0)],
         (1,0):[(0,1),(0,-1),(1,0)],
         (0,1):[(1,0),(-1,0),(0,1)],
         (0,-1):[(1,0),(-1,0),(0,-1)]}

G = nx.Graph()
for pdi in pd:
    pdn  = []
    for di in mdict[pdi[1]]:
        pn = (pdi[0][0] + di[0],pdi[0][1] + di[1])
        pdin = (pn,di)
        if pdin in pd:
            if pdi[1] == pdin[1] :
                G.add_edge(pdi,pdin,weight=1)
            else:
                G.add_edge(pdi,pdin,weight=1001)

sd = (s,(0,1))
ed1 = (e,(0,1))
ed2 = (e,(-1,0))
W1 = nx.dijkstra_path_length(G, sd, ed1)
W2 = nx.dijkstra_path_length(G, sd, ed2)
print(min(W1,W2))