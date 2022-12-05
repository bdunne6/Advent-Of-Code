input_path = '../inputs/day_4.txt'
lines = open(input_path).read().strip().split('\n')

n_part1 = 0
n_part2 = 0
for (i,l) in enumerate(lines):
    p= l.split(',')
    r1 = p[0].split('-')
    r2 = p[1].split('-')
    s1 = set(range(int(r1[0]),int(r1[1])+1,1))
    s2 = set(range(int(r2[0]),int(r2[1])+1,1))
    if set.issubset(s1, s2) or set.issubset(s2, s1):
        n_part1 += 1
    if set.intersection(s1, s2):
        n_part2 += 1
        
print(n_part1)
print(n_part2)