import math
import numpy as np
from copy import deepcopy
input_path = '../inputs/day_25.txt'
x = open(input_path).read()
lines = x.splitlines();


def increment(x,p):
    if len(x) <= p:
        x.extend(['0'])
    
    if x[p] == '=':
        x[p] = '-'
        
    elif x[p] == '-':
        x[p] = '0'
        
    elif x[p] == '0':
        x[p] = '1'
        
    elif x[p] == '1':
        x[p] = '2'
        
    elif x[p] == '2':
        x[p] = '='
        increment(x,p+1)

x = ['0'] 
# print(x)
# increment(x,0)

d1 = dict()

for i in range(1,10000000):
    increment(x,0)
    xi = deepcopy(x)
    xi = ''.join(x[::-1])
    d1.update({i:xi})
    #if i%100 == 0:
    #    print(i)
   
d2 = {v: k for k, v in d1.items()}


v = [0]*len(lines)
for (i,sn) in enumerate(lines):
    v[i] = d2[sn]
    
p1  = d1[sum(v)]
print(p1)