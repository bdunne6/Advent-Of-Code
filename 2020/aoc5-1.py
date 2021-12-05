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
for i1 in range(0,len(data)):
    r,c = get_rc(data[i1])
    id_i1 = r*8 + c
    if id_i1 > max_id:
        max_id = id_i1

print(max_id)
#data = [ [x[:7],x[7:]] for x in data]