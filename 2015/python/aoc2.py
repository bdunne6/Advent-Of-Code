input_path = '../inputs/day_2.txt'

x = open(input_path).read()
lines = x.split('\n')

def area(s):
    d = [int(x) for x in  s.split('x')]
    a = 2*d[0]*d[1]+2*d[1]*d[2]+2*d[0]*d[2]
    d.remove(max(d))
    a = a + d[0]*d[1]
    return a

def length(s):
    d = [int(x) for x in  s.split('x')]
    v = d[0]*d[1]*d[2]
    d.remove(max(d))
    p = 2*d[0]+2*d[1] + v
    return p

#part 1
a = 0
for l in lines:
    a += area(l)

print(a)

#part 2
p = 0
for l in lines:
    p += length(l)

print(p)
