# -*- coding: utf-8 -*-
import numpy as np
import re

from matplotlib import pyplot as plt


input_path = '..\inputs\day_6.txt'
txt = open(input_path).read()

lines = txt.split('\n')



commands= ['toggle','turn off','turn on']
reg_exp = '(' + '|'.join(commands) + ') ([\d]+),([\d]+) through ([\d]+),([\d]+)'



#day 1
x = np.full((1000,1000),False)
for s in lines:
    m = re.search(reg_exp,s)
    groups = list(m.groups())
    
    command = groups[0]
    row_range = [int(groups[1]),int(groups[3])]
    col_range = [int(groups[2]),int(groups[4])]
    
    r = slice(row_range[0],row_range[1]+1,1)
    c = slice(col_range[0],col_range[1]+1,1)
    match command:
        case 'toggle':
            x[r,c] = ~x[r,c]
        case 'turn off':
            x[r,c] = False
        case 'turn on':
            x[r,c] = True
            
fig = plt.figure()
ax = fig.add_subplot(111)
plt.imshow(x)
ax.set_aspect('auto')

print(sum(x.flatten()))

#day 2
x = np.zeros((1000,1000),dtype = np.int64)
for s in lines:
    m = re.search(reg_exp,s)
    groups = list(m.groups())
    
    command = groups[0]
    row_range = [int(groups[1]),int(groups[3])]
    col_range = [int(groups[2]),int(groups[4])]
    
    r = slice(row_range[0],row_range[1]+1,1)
    c = slice(col_range[0],col_range[1]+1,1)
    match command:
        case 'toggle':
            x[r,c] += 2
        case 'turn off':
            x[r,c] -= 1
            x[x<0] = 0
        case 'turn on':
            x[r,c] += 1
            
fig = plt.figure()
ax = fig.add_subplot(111)
plt.imshow(x)
ax.set_aspect('auto')

print(sum(x.flatten()))
