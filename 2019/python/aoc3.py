# -*- coding: utf-8 -*-
import numpy as np
import matplotlib.pyplot as plt


input_path = '..\inputs\day_3.txt'

txt = open(input_path).read()
lines = txt.split('\n')

mdict = {'R':[1,0],'L':[-1,0],'U':[0,1],'D':[0,-1]}

ws = []
for l in lines:
    ws.append(l.split(','))
    
wires = [np.zeros((1,2),int)]*len(ws)


#part 1 #######################################
for i,w in enumerate(ws):
    for s in w:
        m = mdict[s[0]]
        n = int(s[1:])
        wi = wires[i]
        w_pos = wi[-1]

        w_seg_x = w_pos[0]+np.arange(1,int(s[1:])+1)*m[0]
        w_seg_y = w_pos[1]+np.arange(1,int(s[1:])+1)*m[1]
        
        w_seg = np.column_stack((w_seg_x,w_seg_y))
        wi = np.concatenate((wi,w_seg))
        wires[i] =wi

w1_set = set(map(tuple,wires[0]))
w2_set = set(map(tuple,wires[1]))

w_cross = w1_set.intersection(w2_set)
w_cross = np.array(list(w_cross))
mdist_cross = abs(w_cross[:,0])+abs(w_cross[:,1])

print(min(mdist_cross[mdist_cross>0]))

#part 2 ########################################
lengths = np.zeros(len(w_cross))
for i,c in enumerate(w_cross):
    len_1 = np.argwhere(np.all(c - wires[0]==0,axis=1))
    len_2 = np.argwhere(np.all(c - wires[1]==0,axis=1))
    lengths[i] = len_1 + len_2 

print(min(lengths[lengths>0]))

#plots #########################################
plt.scatter(wires[0][:,0],wires[0][:,1])
plt.scatter(wires[1][:,0],wires[1][:,1])