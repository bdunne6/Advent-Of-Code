# -*- coding: utf-8 -*-
#functions ####################################################################
def calc_cost(m_txt,offset):
    c = 0    
    for m in m_txt:
        mp = m.split()
        [xA,yA,xB,yB] = (int(mp[i].split('+')[1].strip(',')) for i in [2,3,6,7])
        [xP,yP] = (int(mp[i].split('=')[1].strip(','))+offset for i in [9,10])
        [nA,nB] = ((xP*yB-xB*yP)/(xA*yB-xB*yA),(xP*yA-xA*yP)/(xB*yA-xA*yB))
        if int(nA) == nA and int(nB) == nB:
            c += nA*3 + nB
    return int(c)
            
#prepare variables ############################################################
input_path = '..\inputs\day_13.txt'
txt = open(input_path).read()
m_txt = txt.split('\n\n')

#part1 ########################################################################
print(calc_cost(m_txt,0))
#part2 ########################################################################
print(calc_cost(m_txt,10000000000000))