import numpy as np
import re

#main script
input_path = '../inputs/day_4.txt'
sections = open(input_path).read().split('\n\n')

n = np.asarray(list(map(int,sections[0].split(','))))

b0 = [list(map(int,s.split())) for s in sections[1:]]
b = np.zeros((5,5,len(sections)-1))
for i1 in range(0,len(b0)):
    b[:,:,i1] = np.reshape(b0[i1], (5,5))

for i1 in range(0,len(n)):
    s = np.uint8(np.isin(b,n[:i1]));
    
    c_win = s.all(axis=0).any()
    r_win = s.all(axis=1).any()
    w =  c_win or r_win
    if w:
        break
    
if r_win :
    i_b_w = np.argwhere(s.all(axis=1))[0][1]
    
if c_win :
    i_b_w = np.argwhere(s.all(axis=0))[0][1]

print(i_b_w)

b_w = b[:,:,i_b_w]

b_w_masked = b_w*np.invert(s[:,:,i_b_w].astype(bool))

p1 = sum(b_w_masked.flatten())*n[i1-1]
print(p1)
#41503