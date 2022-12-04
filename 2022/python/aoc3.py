input_path = '../inputs/day_3.txt'
lines = open(input_path).read().strip().split('\n')

def get_points(x):
    letters = 'abcdefghijklmnopqrstuvwxyz' 
    letters = letters + letters.upper()
    return letters.find(x) + 1
    
points = 0   

#part 1
for i,l in enumerate(lines):
    nc = int(len(l)/2)
    c1 = set(l[0:nc])
    c2 = set(l[nc:])
    c_intersect = list(set.intersection(c1,c2))[0]
    points += get_points(c_intersect)

print(points)

#part2 
points = 0   
for i in range(0,len(lines),3):
    group_i = lines[i:i+3]
    group_sets = list(map(set,group_i))
    c_intersect = list(set.intersection(*group_sets))[0]
    points += get_points(c_intersect)
    
print(points)