#prepare variables ############################################################
input_path = '..\inputs\day_11.txt'
txt = open(input_path).read()
#lines = txt.split('\n')
X = txt.split()
X = [int(x) for x in X]

#part 1 #######################################################################
for j in range(25):
    for i,x in enumerate(X):
        nd = len(str(x))
        if x == 0:
            X[i] = [1]
        elif nd%2 == 0:
            X[i] = [int(str(x)[:int(nd/2)]),int(str(x)[int(nd/2):])]
        else:
            X[i] = [X[i]*2024]
    X = [x for xs in X for x in xs]
print(len(X))

#part 2 #######################################################################
from collections import Counter
X = txt.split()
X = Counter(dict(zip([int(x) for x in X],[1]*len(X))))
for j in range(75):
    for x,v in list(X.items()):
        nd = len(str(x))
        X[x] -= v
        if x == 0:
            X[1]+=v
        elif nd%2 == 0:
            X[int(str(x)[:int(nd/2)])] += v
            X[int(str(x)[int(nd/2):])] += v
        else:
            X[x*2024] += v
print(sum(X.values()))
