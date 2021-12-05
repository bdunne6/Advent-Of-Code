import csv
with open('aoc3-1.csv', newline='') as f:
    reader = csv.reader(f)
    data = list(reader)
#data = [e[0] for e in data]

data = [x[0] for x in data]

n_col = len(data[0])
ci1 = 0
print(data[0])
tree_count = 0 
for i1 in range(1,len(data)):
    ci1  = ci1 + 3
    ci1 = ci1%n_col
    data[i1][ci1]
    
    dp = list(data[i1])
    if dp[ci1] =='#':
        dp[ci1] = 'X'
        tree_count += 1
    else:
        dp[ci1] = 'O'
    print(''.join(dp))
    
print(tree_count)
