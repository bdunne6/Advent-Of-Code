#load input
input_path = '../inputs/day_2.txt'
lines = open(input_path).read().strip().split('\n')

#common
move_score = dict(zip(['X','Y','Z'],[1,2,3]))

#part 1 #
win_score = dict([ 
    ['A X',3],
    ['A Y',6],
    ['A Z',0],
    ['B X',0],
    ['B Y',3],
    ['B Z',6],
    ['C X',6],
    ['C Y',0],
    ['C Z',3]
    ])
    
scores = [win_score[s] + move_score[s[-1]] for s in lines]

p1 = sum(scores)
print(p1)

#part 2
win_score = dict(zip(['X','Y','Z'],[0,3,6]))
move_lookup = dict([ 
    ['A X','Z'],
    ['A Y','X'],
    ['A Z','Y'],
    ['B X','X'],
    ['B Y','Y'],
    ['B Z','Z'],
    ['C X','Y'],
    ['C Y','Z'],
    ['C Z','X']
    ])

scores = [win_score[s[-1]] + move_score[move_lookup[s]] for s in lines]
p2 = sum(scores)
print(p2)

