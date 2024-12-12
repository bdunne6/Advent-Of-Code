from collections import Counter
#prepare variables ############################################################
input_path = '..\inputs\day_11.txt'
X  = open(input_path).read().split()
X = [int(x) for x in X]
#functions ####################################################################
def count_stones(X,n):
    X = Counter(dict(zip([int(x) for x in X],[1]*len(X))))
    for j in range(n):
        for x,v in list(X.items()):
            X[x] -= v
            nd = len(str(x))
            if x == 0:
                X[1]+=v
            elif nd%2 == 0:
                X[int(str(x)[:int(nd/2)])] += v
                X[int(str(x)[int(nd/2):])] += v
            else:
                X[x*2024] += v
    return sum(X.values())
#part 1 #######################################################################
print(count_stones(X, 25))
#part 2 #######################################################################
print(count_stones(X, 75))