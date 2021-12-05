import csv
with open('aoc2-1.csv', newline='') as f:
    reader = csv.reader(f)
    data = list(reader)
#data = [e[0] for e in data]

data1 = [str.split(x[0],': ') for x in data];

good_pass = list()
for d in data1:
    passwd = d[1]
    cond = d[0]
    c_parts = cond.split(' ')
    letter = c_parts[1]
    nrange = c_parts[0]
    nrange = list(map(int,nrange.split('-')))
    
    #n_cnt = passwd.count(letter)
    m1 = passwd[nrange[0]-1] == letter
    m2 = passwd[nrange[1]-1] == letter
    if (m1 or m2) and (not (m1 and m2)):
        good_pass.append(1)
    else:
        good_pass.append(0)
    #print(d)

print(sum(good_pass))