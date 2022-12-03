#load input
input_path = '../inputs/day_1.txt'
sections = open(input_path).read().split('\n\n')
calorie_list = [s.strip().split('\n') for s in sections]
calorie_list = [list(map(int,s)) for s in calorie_list]

#part1 answer
c_totals = [sum(c) for c in calorie_list]
p1 = max(c_totals)
print(p1)

#part2 answer
c_totals.sort(reverse=True)
p2 = sum(c_totals[0:3])
print(p2)