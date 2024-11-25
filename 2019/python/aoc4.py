# -*- coding: utf-8 -*-
import numpy as np

input_path = '..\inputs\day_4.txt'

txt = open(input_path).read()
parts = txt.split('-')

val_int = list(range(int(parts[0]),int(parts[1])+1))
vals = [[int(d) for d in str(n)] for n in val_int]

#part 1 ##############################################
cnt = 0
for v in vals:
    if np.all(np.diff(v)>=0) and np.any(np.diff(v)==0):
        cnt+=1
print(cnt)

#part 2 ##############################################
cnt = 0
for v in vals:
    d = np.diff(v)
    if np.all(d>=0):
        b = np.pad(d==0,(1, 1), mode='constant', constant_values=False)
        for i in range(1,len(b)-1):
            if b[i] and not b[i-1] and not b[i+1]:
                cnt+=1
                break
print(cnt)

        