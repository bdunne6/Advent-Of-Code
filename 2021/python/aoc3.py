import numpy as np

def bin_array_to_int(x):
    xs = ''.join(x.astype('str').tolist())
    x_int = int(xs,2)
    return  x_int

#main script
input_path = '../inputs/day_3.txt'
lines = open(input_path).read().split('\n')

bchars = [list(x) for x in lines]
b = np.asarray(bchars,np.uint8) 

g_b = np.uint8(np.median(b,0))
e_b = np.uint8(g_b!= 1)

g = bin_array_to_int(g_b)
e = bin_array_to_int(e_b)

p1 = g*e
#part 1
print(p1)
#4191876

#part 2
o_bit_criteria = lambda x: np.uint8(np.median(x) > 0)
co2_bit_criteria = lambda x: np.uint8(not o_bit_criteria(x))

def iterate_bit_criteria(b,bit_criteria):
    for i1 in range(0,b.shape[1]):
        ci1 = b[:,i1]
        v_keep  = bit_criteria(ci1)
        i_keep = ci1 == v_keep
        b = b[i_keep,:]
        if b.shape[0] == 1:
            return b[0]
    
o_b = iterate_bit_criteria(b,o_bit_criteria)
co2_b = iterate_bit_criteria(b,co2_bit_criteria)

o = bin_array_to_int(o_b)
co2 = bin_array_to_int(co2_b)
print(o*co2)