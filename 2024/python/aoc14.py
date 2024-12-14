# -*- coding: utf-8 -*-
import numpy as np
import re
#prepare variables ############################################################
input_path = '..\inputs\day_14.txt'
txt = open(input_path).read()
lines = txt.split('\n')
guards = []
pat = re.compile('p=(.*) v=(.*)')
for line in lines:
    p = [int(x) for x in pat.search(line).group(1).split(',')]
    v = [int(x) for x in pat.search(line).group(2).split(',')]
    p.extend(v)
    guards.append(p)

#parts 1 and 2 ################################################################    
size = [101,103]
N = 10000
v = np.zeros(N)
for i,t in enumerate(range(N)):
    pv = np.array(guards)
    m = np.zeros((size[1],size[0]))
    for g in pv:
        g[0:2] += g[2:4]*t
        g[0] = g[0]%size[0]
        g[1] = g[1]%size[1]
        
    q1 = sum((pv[:,0] < (size[0]-1)/2) & (pv[:,1] < (size[1]-1)/2))
    q2 = sum((pv[:,0] < (size[0]-1)/2) & (pv[:,1] > (size[1]-1)/2))
    q3 = sum((pv[:,0] > (size[0]-1)/2) & (pv[:,1] < (size[1]-1)/2))
    q4 = sum((pv[:,0] > (size[0]-1)/2) & (pv[:,1] > (size[1]-1)/2))
    
    v[i] = sum(abs(pv[:,0]-np.mean(pv[:,0]))) + sum(abs(pv[:,1]-np.mean(pv[:,1])))
    if t == 100:
        print(np.prod([q1,q2,q3,q4]))
    
print(np.argmin(v))