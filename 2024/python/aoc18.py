# -*- coding: utf-8 -*-
import numpy as np
import matplotlib.pyplot as plt
import networkx as nx
from itertools import product

#prepare variables ############################################################
input_path = '..\inputs\day_18.txt'
txt = open(input_path).read()
lines = txt.split('\n')

b =  [tuple(int(x) for x in line.split(',')) for line in lines] 


#part 1 #######################################################################
i_t = 1024
b = b[:i_t]
size = [71,71]
p = list(product(range(size[0]),range(size[1])))
p = set(p).difference(b)


d = set([(-1,0),(1,0),(0,-1),(0,1)])

G = nx.Graph()
for pi in p:
    for di in d:
        pn = (pi[0] + di[0],pi[1] + di[1])
        if pn in p:
            G.add_edge(pi,pn)


sp = nx.shortest_path(G, (0,0),(size[0]-1,size[1]-1))
print(len(sp)-1)

[x,y] = zip(*sp)
plt.plot(x,y)
plt.gca().invert_yaxis()