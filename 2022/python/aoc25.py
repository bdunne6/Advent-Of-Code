import numpy as np

input_path = '../inputs/day_25.txt'
x = open(input_path).read()
lines = x.splitlines();


ds = {'=':-2,'-':-1,'0':0,'1':1,'2':2}
di = {v: k for k, v in ds.items()}

            
def snafu_to_int(s):
   v = 0
   for (i,c) in enumerate(reversed(s)):
       v += (5**i)*ds[c]
   return v

def int_to_snafu(xi):
    x = np.base_repr(xi, base=5)
    x = [*x]
    x = list(reversed(list(map(int,x))))
    for p in range(0,len(x)):
        if (p == len(x)-1) and (x[p]>2):
            x.append(0)
        if x[p] == 3:
            x[p] = -2
            x[p+1] += 1
        elif x[p] == 4:
            x[p] = -1
            x[p+1] += 1
        elif x[p] == 5:
            x[p] = 0
            x[p+1] += 1
    s =[di[x] for x in x]
    s = ''.join(reversed(s))
    return s

v = [0]*len(lines)
for (i,sn) in enumerate(lines):
    v[i] = snafu_to_int(sn)
    
p1  = int_to_snafu(sum(v))
print(p1)
