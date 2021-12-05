with open('aoc5-1.txt', newline='') as f:
    data = f.read()
    
data = data.split('\r\n')

def get_rc(str_val):
    str_val = str_val.replace('B', '1')
    str_val = str_val.replace('F', '0')
    str_val = str_val.replace('R', '1')
    str_val = str_val.replace('L', '0')
    r = int(str_val[:7],2)
    c = int(str_val[7:],2)
    return (r,c)
 
max_id = 0   
ra = list()
ca = list()
for i1 in range(0,len(data)):
    r,c = get_rc(data[i1])
    id_i1 = r*8 + c
    ra.append(r)
    ca.append(c)
    if id_i1 > max_id:
        max_id = id_i1

print(max_id)

#part 2
rc = set(list(zip(ra,ca)))
rc_p = list()
for i1 in range(min(ra),max(ra)):
    for i2 in range(0,8):
        rc_p.append((i1,i2))
#data = [ [x[:7],x[7:]] for x in data]
rc_p = set(rc_p)
sd = list(rc_p.difference(rc))

#print the possible values not listed in input
print(sd)
print(sd[0][0]*8 +sd[0][1])