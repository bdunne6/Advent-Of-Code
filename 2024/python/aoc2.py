# -*- coding: utf-8 -*-
import numpy as np

input_path = '..\inputs\day_2.txt'
txt = open(input_path).read()

lines = txt.split('\n')

v = [[int(x) for x in l.split()] for l in lines]

#part1 ########################################################################
s = 0
for e in v: 
    n = np.array(e)
    nd = np.diff(n)
    if (np.all(nd < 0) or np.all(nd > 0)) and (np.all(abs(nd)>=1) and np.all(abs(nd)<=3)):
        s+=1
print(s)

#part2 ########################################################################
s = np.zeros(len(v))
for i,e in enumerate(v): 
    n0 = np.array(e)
    for j in range(len(e)):
        n = np.delete(n0,j)
        nd = np.diff(n)
        if (np.all(nd < 0) or np.all(nd > 0)) and (np.all(abs(nd)>=1) and np.all(abs(nd)<=3)):
            s[i] = 1
            break

print(sum(s))