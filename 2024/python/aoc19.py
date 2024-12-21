# -*- coding: utf-8 -*-
import numpy as np
import re
import networkx as nx

input_path = '..\inputs\day_19.txt'
txt = open(input_path).read()
lines = txt.split('\n')

tpat = lines[0].split(',')
tpat = [s.strip() for s in tpat]

designs = lines[2:]

# pattern = '^(' + ('|'.join(tpat))+ ')*$'
# p = re.compile(pattern)

nm = 0
# for i,d in enumerate(designs):
      
for d in designs:
    #d = designs[0]
    dse = {}
    for p in tpat:
        m = re.finditer(p,d)
        if m:
            for mi in m:
                dse.setdefault(mi.start(), []).append(mi.end()-1)
                #print(mi)
                #mse.add((mi.start(),mi.end()-1))
        
    G = nx.DiGraph()
    for s,e in dse.items():
        for ei in e:
            if ei !=s:
                G.add_edge(s,ei)
            if ei+1 in dse:
                G.add_edge(ei,ei+1)
    
        
    nm += (0 in G and (len(d)-1) in G and nx.has_path(G,0,len(d)-1))
    print((0 in G and len(d)-1 in G and nx.has_path(G,0,len(d)-1)))
    # nm += bool(p.match(d))
    

print(nm)


nx.draw(G,with_labels=True)

