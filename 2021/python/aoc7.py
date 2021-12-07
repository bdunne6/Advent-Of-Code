import numpy as np
import re

#main script
input_path = '../inputs/day_7.txt'
x = open(input_path).read().split(',')
x = np.asarray(list(map(int,x)))

#x = np.asarray([16,1,2,0,4,2,7,1,2,14])

#this can be replaced with median
d_range = np.asarray((range(x.min(),x.max()+1)))

f_total = np.zeros(len(d_range))
for i1 in range(0,len(d_range)) :
    f_total[i1] = np.abs(x - d_range[i1]).sum()

i_min = f_total.argmin()
f_min = f_total.min()
# x.sort()
# print(x)
p1 = f_min
print(p1)



def c_fun(d): return (abs(d)+1)/2*abs(d)
d_range = np.asarray((range(x.min(),x.max()+1)))

f_total = np.zeros(len(d_range))
for i1 in range(0,len(d_range)) :
    f_total[i1] = sum(list(map(c_fun,x - d_range[i1])))

i_min = f_total.argmin()
f_min = f_total.min()
# x.sort()
# print(x)
p2 = f_min
print(p2)
