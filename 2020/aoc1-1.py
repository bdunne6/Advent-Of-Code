import csv
with open('aoc1-1.csv', newline='') as f:
    reader = csv.reader(f)
    data = list(reader)

data = [e[0] for e in data]
data = list(map(int, data))

def find_sum(data,tval):
    d1 = dict()
    for i1 in range(0,len(data)):
        datai1 = data[i1]
        if datai1 in d1:
            solution = data[d1[datai1]]*datai1
            return (d1[datai1],i1)
        else:
            d1[tval-datai1] = i1
    return 0
    

tval = 2020
s1 = find_sum(data,tval)
print(data[s1[0]]*data[s1[1]])