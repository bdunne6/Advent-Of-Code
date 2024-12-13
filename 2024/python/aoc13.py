# -*- coding: utf-8 -*-
import numpy as np

#prepare variables ############################################################
input_path = '..\inputs\day_13.txt'
txt = open(input_path).read()
m_txt = txt.split('\n\n')


mlist = []
for m in m_txt:
    mp = m.split()
    xA = mp[2].split('+')[1].strip(',')
    yA = mp[3].split('+')[1].strip(',')
    xB = mp[6].split('+')[1].strip(',')
    yB = mp[7].split('+')[1].strip(',')
    xP = mp[9].split('=')[1].strip(',')
    yP = mp[10].split('=')[1].strip(',')
    mlist.append({'A':(int(xA),int(yA)),'B':(int(xB),int(yB)),'P':(int(xP)+10000000000000,int(yP)+10000000000000)})
    
c = 0
for m in mlist:
    x1 = m['A'][0]
    y1 = m['A'][1]
    x2 = m['B'][0]
    y2 = m['B'][1]
    x3 = m['P'][0]
    y3 = m['P'][1]
    
    nA = (x3*y2-x2*y3)/(x1*y2-x2*y1)
    nB = (x3*y1-x1*y3)/(x2*y1-x1*y2)
    
    if int(nA) == nA and int(nB) == nB:
        c += nA*3 + nB

print(c)
    
    