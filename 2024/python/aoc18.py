# -*- coding: utf-8 -*-
import networkx as nx
from itertools import product

#prepare variables ############################################################
input_path = '..\inputs\day_18.txt'
txt = open(input_path).read()
lines = txt.split('\n')
b = [tuple(int(x) for x in line.split(',')) for line in lines] 

size = [71,71]
p = list(product(range(size[0]),range(size[1])))
d = set([(-1,0),(1,0),(0,-1),(0,1)])
#functions ####################################################################
def build_graph(p1):
    G = nx.Graph()
    for px,py in p1:
        for dx,dy in d:
            pn = (px + dx,py + dy)
            if pn in p1:
                G.add_edge((px,py),pn)
    return G
#part 1 #######################################################################
i_t = 1024
G = build_graph(set(p).difference(b[:i_t]))
sp = nx.shortest_path(G, (0,0),(size[0]-1,size[1]-1))
print(len(sp)-1)

# #part 2 #####################################################################
p1 = set(p).difference(b)
G = build_graph(p1)

while b:
    bi = b.pop()
    p1.add(bi)
    for dx,dy in d:
        pn = (bi[0] + dx,bi[1] + dy)
        if pn in p1:
            G.add_edge(bi,pn)
    if nx.has_path(G, (0,0),(size[0]-1,size[1]-1)):
        print(*bi, sep=',')
        break