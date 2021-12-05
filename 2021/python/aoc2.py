input_path = '../inputs/day_2.txt'
lines = open(input_path).read().split('\n')

move = [float(x.split(' ')[-1]) for x in lines]
direction = [x.split(' ')[0] for x in lines]
move_pairs = list(zip(direction,move));

move = [-m if d == 'up' else m for d,m in move_pairs]
direction = ['d' if d in {'up','down'} else 'h' for d in direction]

move_pairs = list(zip(direction,move));

dh = dict(zip(['h','d'],[0,0]))

for k,v in move_pairs: dh[k] += v

p1 = dh['d']*dh['h']
print(p1)

#part 2
dha= dict(zip(['h','d','a'],[0,0,0]))

for k,v in move_pairs: 
    if k == 'd':
        dha['a'] += v
    elif k == 'h':
        dha['h'] += v
        dha['d'] += v*dha['a']
        
p2 = dha['d']*dha['h']
print(p2)