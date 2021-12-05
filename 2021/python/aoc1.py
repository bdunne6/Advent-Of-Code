import numpy as np

input_path = '../inputs/day_1.txt'
lines = open(input_path).read().split('\n')
x = np.asarray(list(map(float,lines)))

#part 1
p1 = sum(np.diff(x) > 0)
print(p1)
#part 2
p2 = sum(np.diff(np.convolve(x, [1,1,1],'valid' )) > 0)
print(p2)