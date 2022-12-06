import re,copy

input_path = '../inputs/day_5.txt'
x = open(input_path).read()

sections = x.split('\n\n')

#parse initial state
stacks = sections[0]
stacks = stacks.split('\n')[:-1]
#stacks = np.asarray(stacks)
stacks = list(map(list,(zip(*stacks))))
stacks = stacks[1:-1:4]
stacks = [[c for c in s[::-1] if c!=' '] for s in stacks]

#parse moves
move_lines = sections[1].split('\n')
get_moves = lambda x : re.search('move (\d+) from (\d+) to (\d+)',x).groups()
moves = list(map(get_moves,move_lines))

#part1 
stacks1 = copy.deepcopy(stacks)
for m in moves:
    m = list(map(int,m))
    n = m[0]
    for i1 in range(n):
        stacks1[m[2]-1].append(stacks1[m[1]-1].pop())
        
p1 = ''.join([s[-1] for s in stacks1])
print(p1)   

#part2
stacks2 = copy.deepcopy(stacks)
for m in moves:
    m = list(map(int,m))
    n = m[0]
    cm = stacks2[m[1]-1][-n:]
    stacks2[m[1]-1] = stacks2[m[1]-1][:-n]
    stacks2[m[2]-1].extend(cm)
        
p2 = ''.join([s[-1] for s in stacks2])
print(p2)     