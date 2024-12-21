# -*- coding: utf-8 -*-
import numpy as np
import re
import networkx as nx

#prepare variables ############################################################
input_path = '..\inputs\day_19.txt'
txt = open(input_path).read()
lines = txt.split('\n')

tpat = lines[0].split(',')
tpat = [s.strip() for s in tpat]

designs = lines[2:]

#part 1 #######################################################################
nm = 0
for d in designs:
    dse = {}
    for p in tpat:
        m = re.finditer(p,d)
        if m:
            for mi in m:
                dse.setdefault(mi.start(), []).append(mi.end())
    G = nx.DiGraph()
    for s,e in dse.items():
        for ei in e:
            G.add_edge(s,ei)
    nm += (0 in G and (len(d)) in G and nx.has_path(G,0,len(d)))
print(nm)
#part 2 #######################################################################

nx.draw(G,with_labels=True)

