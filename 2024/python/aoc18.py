# -*- coding: utf-8 -*-
import networkx as nx
from itertools import product

#prepare variables ############################################################
input_path = '..\inputs\day_18.txt'
txt = open(input_path).read()
lines = txt.split('\n')
b =  [tuple(int(x) for x in line.split(',')) for line in lines] 

size = [71,71]
p = list(product(range(size[0]),range(size[1])))
d = set([(-1,0),(1,0),(0,-1),(0,1)])
#part 1 #######################################################################
i_t = 1024
p1 = set(p).difference(b[:i_t])
G = nx.Graph()
for pi in p1:
    for di in d:
        pn = (pi[0] + di[0],pi[1] + di[1])
        if pn in p1:
            G.add_edge(pi,pn)

sp = nx.shortest_path(G, (0,0),(size[0]-1,size[1]-1))
print(len(sp)-1)
# #part 2 #######################################################################
p1 = set(p).difference(b)
G = nx.Graph()
for pi in p1:
    for di in d:
        pn = (pi[0] + di[0],pi[1] + di[1])
        if pn in p1:
            G.add_edge(pi,pn)
            
blocked = True
i_t = len(b)
while blocked:
    i_t -= 1
    p1.add(b[i_t])
    for di in d:
        pn = (b[i_t][0] + di[0],b[i_t][1] + di[1])
        if pn in p1:
            G.add_edge(b[i_t],pn)
    
    if nx.has_path(G, (0,0),(size[0]-1,size[1]-1)):
        blocked = False

print(*b[i_t],sep=',')