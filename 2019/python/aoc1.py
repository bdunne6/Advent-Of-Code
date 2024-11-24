# -*- coding: utf-8 -*-
import numpy as np

input_path = '..\inputs\day_1.txt'
txt = open(input_path).read()

lines = txt.split('\n')
mass = [int(x) for x in lines]
mass = np.array(mass)


#part 1 ################################
fuel_req = sum(mass//3 - 2)
print(fuel_req)


#part 2 ################################
fuel_req = np.zeros(mass.shape,int)
while any(mass>0):
    mass = mass//3 - 2
    mass[mass<0] = 0
    fuel_req += mass
    
print(sum(fuel_req))
