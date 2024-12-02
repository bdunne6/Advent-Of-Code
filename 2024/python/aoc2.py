# -*- coding: utf-8 -*-
import numpy as np

input_path = '..\inputs\day_2.txt'
txt = open(input_path).read()

lines = txt.split('\n')

r = [[int(x) for x in l.split()] for l in lines]

def is_safe(n):
    nd = np.diff(n)
    return (np.all(nd < 0) or np.all(nd > 0)) and (np.all(abs(nd)>=1) and np.all(abs(nd)<=3))

#part1 ########################################################################
print(sum([is_safe(n) for n in r]))

#part2 ########################################################################
print(sum(any(is_safe(np.delete(n,j)) for j in range(len(n))) for n in r))