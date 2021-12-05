with open('aoc6-1.txt', newline='') as f:
    data = f.read()
    
data = data.split('\r\n\r\n')
data = [x.split('\r\n') for x in data]

def char_range(c1, c2):
    """Generates the characters from `c1` to `c2`, inclusive."""
    for c in range(ord(c1), ord(c2)+1):
        yield chr(c)

c_set = list(char_range('a','z'))

g_nums = [len(set(list(''.join(d)))) for d in data]
print(sum(g_nums))

#part 2
a_nums = list()
from functools import reduce
for i1 in range(0,len(data)):
    d = data[i1]
    a_set = [set(list(a)) for a in d ]
    a_numi1 = len(set.intersection(*a_set))
    a_nums.append(a_numi1)

print(sum(a_nums))