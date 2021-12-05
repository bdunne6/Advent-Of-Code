import csv
with open('aoc3-1.csv', newline='') as f:
    reader = csv.reader(f)
    data = list(reader)
#data = [e[0] for e in data]

data = [x[0] for x in data]

n_col = len(data[0])

print(data[0])

slopes = [[1,1],[3,1],[5,1],[7,1],[1,2]]
tree_count = [0]*len(slopes)

for i0 in range(0,len(slopes)):
    i1 = 0
    ci1 = 0
    si0 = slopes[i0]
    while i1 < len(data):
        i1  = i1 + si0[1]
        if i1 >= len(data):
                break
        
        ci1  = ci1 + si0[0]
        ci1 = ci1%n_col
        #data[i1][ci1]
        dp = list(data[i1])
        if data[i1][ci1] =='#':
            dp[ci1] = 'X'
            tree_count[i0] += 1
        else:
            dp[ci1] = 'O'
        print(''.join(dp))
        
    
print(tree_count)
from functools import reduce
m_sol = reduce(lambda x, y: x*y, tree_count)
print(m_sol)