import numpy as np

input_path = '../inputs/day_3.txt'
lines = open(input_path).read().split('\n')

bchars = [list(x) for x in lines]
b = np.asarray(bchars,np.uint8) 

g_b = np.uint8(np.median(b,0))
e_b = np.uint8(g_b!= 1)

g_bs = ''.join(g_b.astype('str').tolist())
e_bs = ''.join(e_b.astype('str').tolist())

g = int(g_bs,2)
e = int(e_bs,2)

p1 = g*e
print(p1)

#b1 = bin(1024)
#x = np.array([1,0,0,0,0,0,0,0,0,0,0], dtype=np.bool)
#px = np.packbits(x)

#v1 = np.flip(px).transpose().view(np.int16)
#print(v1)