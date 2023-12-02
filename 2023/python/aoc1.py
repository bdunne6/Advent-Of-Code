# -*- coding: utf-8 -*-
import numpy as np
import re

from matplotlib import pyplot as plt


input_path = '..\inputs\day_1.txt'
txt = open(input_path).read()

lines = txt.split('\n')


#part 1 ################################
cal_vals = list()
for l in lines:
    m = re.findall('\d', l)
    cal_vals.append(int(m[0]+m[-1]))


p1 = sum(cal_vals)
print(p1)

#part 2 ################################
digits =  [str(x) for x in range(1,10)]
digit_names = ['one','two','three','four','five','six','seven','eight','nine']
digit_lookup = list(zip(digits,digit_names))


cal_vals = list()
for l in lines:
    l_list = list(l)
    for v in digit_lookup:
        ind = [m.start() for m in re.finditer(v[1],l)]
        for i in ind:
            l_list[i] = v[0]

    l = ''.join(l_list)

    m = re.findall('\d', l)
    cal_val = int(m[0]+m[-1])
    cal_vals.append(cal_val)

p2 = sum(cal_vals)
print(p2)