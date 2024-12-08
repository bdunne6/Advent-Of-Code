# -*- coding: utf-8 -*-
import numpy as np
#prepare variables ############################################################
moves = [x.strip() for x in open('..\inputs\day_1.txt').read().split(',')]

def get_rotation(theta):
    theta = theta*np.pi/180;
    return (np.array([[np.cos(theta), -np.sin(theta)],
            [np.sin(theta), np.cos(theta)]])).round().astype(int)

d = np.array([0,1],int)
p = np.array([0,0],int)

p_set = set()
p_twice_found = False
r_dict = {'R':-90,'L':90}
for m in moves:
    d = get_rotation(r_dict[m[0]])@d
    move_mag = int(m[1:])
    mv_p_set =  (p.reshape(-1,1) +range(1,move_mag+1)*d.reshape(-1,1)).T
    mv_p_set = set([tuple(x) for x in mv_p_set])
    p += move_mag*d
    for mv_p in mv_p_set:
        if mv_p in p_set and not p_twice_found:
            p_twice = np.array(mv_p)
            p_twice_found = True
    p_set = p_set.union(mv_p_set)
            
#part 1
print(sum(abs(p)))
#part 2
print(sum(abs(p_twice)))