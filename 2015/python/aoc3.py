input_path = '../inputs/day_3.txt'
x = open(input_path).read()

step_lookup = {'<':[-1,0],'^':[0,1],'>':[1,0],'v':[0,-1]}


#day 1
position = [0,0]
presents = {tuple([0,0]):1}

for d in x:
    step = step_lookup[d]
    position[0] += step[0]
    position[1] += step[1]
    position_tuple = tuple(position)
    if position_tuple in presents:
        presents[position_tuple] +=1
    else:
        presents[position_tuple] = 1


print(len(presents))
