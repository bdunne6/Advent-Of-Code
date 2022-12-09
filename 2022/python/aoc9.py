import numpy as np

input_path = '../inputs/day_9.txt'
x = open(input_path).read()
lines = x.splitlines();

lines = [l.split(' ') for l in lines];
moves = list(map(list,(zip(*lines))))
moves_sizes = list(map(int,moves[1]))
moves = list(zip(moves[0],moves_sizes))

step_lookup = {'R':np.array([1,0]),'L':np.array([-1,0]),'U':np.array([0,1]),'D':np.array([0,-1])}

for n in [2,10]:
    k = np.zeros((n,2))
    t_path = np.zeros((sum(moves_sizes),2))
    ip = 0
    for m in moves:
        for j in range(0,m[1]):
            k[0,:] += step_lookup[m[0]]
            for i in range(1,k.shape[0]):
                d = k[i-1,:] - k[i,:]
                s_t = np.sign(d) if max(abs(d))>1 else np.array([0,0]) 
                k[i,:] += s_t
            t_path[ip,:] =  k[-1,:]
            ip += 1
    urows = np.unique(np.array(t_path),axis=0)
    print(urows.shape[0])