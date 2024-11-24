# -*- coding: utf-8 -*-
import numpy as np

input_path = '..\inputs\day_2.txt'
txt = open(input_path).read()

elem = txt.split(',')
c = [int(x) for x in elem]
c = np.array(c)

c0 = np.copy(c) #copy original for part 2

#part 1 ########################################################
c[1] = 12
c[2] = 2


for i in range(0,len(c),4):
    #print(c)
    if c[i] == 1:
        c[c[i+3]] = c[c[i+1]]+c[c[i+2]]
    elif c[i] == 2:
        c[c[i+3]] = c[c[i+1]]*c[c[i+2]]
    elif c[i]==99:
        break
print(c[0])

#part 2 ########################################################
c = c0

def run_program(c):
    for i in range(0,len(c),4):
        #print(c)
        if c[i] == 1:
            c[c[i+3]] = c[c[i+1]]+c[c[i+2]]
        elif c[i] == 2:
            c[c[i+3]] = c[c[i+1]]*c[c[i+2]]
        elif c[i]==99:
            break
    return c[0]
    

def find_inputs(c0,o_target):
    for i in range(0,100):
        for j in range(0,100):
            c = np.copy(c0)
            c[1] = i
            c[2] = j
            o = run_program(c)
            if o == 19690720:
                return(i,j)
            #print(o)
            


o_target = 19690720
inputs = find_inputs(c0,19690720)

print(100*inputs[0]+inputs[1])
    
    

