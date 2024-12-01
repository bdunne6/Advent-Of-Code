# -*- coding: utf-8 -*-
import numpy as np

input_path = '..\inputs\day_1.txt'
txt = open(input_path).read()

lines = txt.split('\n')

v = [x.split('  ') for x in lines]
L = list(zip(*v))

#part 1 #######################################################################

L[0] = np.array([int(x) for x in L[0]])
L[1] = np.array([int(x) for x in L[1]])

L[0].sort()
L[1].sort()

print(sum(abs((L[0]) - L[1])))

#part 2 #######################################################################
s = 0
for i in range(0,len(L[0])):
    s += sum(L[0][i] == L[1])*L[0][i]

print(s)