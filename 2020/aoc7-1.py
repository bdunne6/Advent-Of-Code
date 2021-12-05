import re

with open('aoc7-1.txt', newline='') as f:
    data = f.read()
    
data = data.split('\r\n')



for i1 in range(0,len(data)):
    rule_i1 = re.split('bags|bag',data[i1])
    rule_i1 = [x.strip().replace('contain ','').replace(', ','') for x in rule_i1[:-1]]
