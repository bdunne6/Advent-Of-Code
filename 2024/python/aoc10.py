# -*- coding: utf-8 -*-
import numpy as np
import matplotlib.pyplot as plt
import networkx as nx

#functions ####################################################################
def tupify(X):
    return tuple(tuple(x) for x in X)

def in_range(r,c,shape):
    return (r>=0) and (c>=0) and (r<shape[0]) and (c<shape[1])

def find_nodes(G, a, v):
    return [node for node, attr in G.nodes(data=True) if attr.get(a) == v]

#parse input  #################################################################
input_path = '..\inputs\day_10.txt'
txt = open(input_path).read()
lines = txt.split('\n')

X = np.zeros((len(lines),len(lines[0])))

#part 1 #######################################################################
for i,line in enumerate(lines):
    X[i,:] = np.array([int(c) if not c=='.' else -1 for c in line])
    
G = nx.DiGraph()
nn = [[-1,0],[1,0],[0,-1],[0,1]]

for r in range(X.shape[0]):
    for c in range(X.shape[1]):
        h = X[r,c]
        for n in nn:
            r_n = n[0] + r
            c_n = n[1] + c
            
            if in_range(r_n, c_n, X.shape):
                if X[r_n,c_n]-X[r,c] == 1:
                    G.add_edge((r,c),(r_n,c_n))
                    G.nodes[(r,c)]['h'] = int(X[r,c])
                    G.nodes[(r_n,c_n)]['h'] = int(X[r_n,c_n])
            
n_th = find_nodes(G, 'h', 0)
n_top = find_nodes(G, 'h', 9)


path_count = np.zeros((len(n_th),len(n_top)))
for i,th in enumerate(n_th):
    for j,top in enumerate(n_top):
        if nx.has_path(G, th,top):
            path_count[i,j] += 1

th_s = np.sum(path_count,axis = 1)
print(sum(th_s))

#part 2 #######################################################################
path_ratings = np.zeros((len(n_th),len(n_top)))
for i,th in enumerate(n_th):
    for j,top in enumerate(n_top):
        if nx.has_path(G, th,top):
            path_ratings[i,j] += len(list(nx.all_simple_paths(G,th,top)))

th_s = np.sum(path_ratings,axis = 1)
print(sum(th_s))
            

