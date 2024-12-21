# -*- coding: utf-8 -*-
import numpy as np
import re

input_path = '..\inputs\day_19.txt'
txt = open(input_path).read()
lines = txt.split('\n')

tpat = lines[0].split(',')
tpat = [s.strip() for s in tpat]

designs = lines[2:]

# pattern = "^({'|'.join()})*$"
pattern = '^(' + ('|'.join(tpat))+ ')*$'
p = re.compile(pattern)

nm = 0
for i,d in enumerate(designs):
    print(str(i))
    nm += bool(p.match(d))
    

print(nm)




