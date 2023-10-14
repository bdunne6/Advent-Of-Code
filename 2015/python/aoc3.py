input_path = '../inputs/day_3.txt'
moves = open(input_path).read()

step_lookup = {'<':[-1,0],'^':[0,1],'>':[1,0],'v':[0,-1]}


def get_present_map(moves):
    position = [0,0]
    presents = {tuple([0,0]):1}

    for d in moves:
        step = step_lookup[d]
        position[0] += step[0]
        position[1] += step[1]
        position_tuple = tuple(position)
        if position_tuple in presents:
            presents[position_tuple] +=1
        else:
            presents[position_tuple] = 1
    return presents
    
    

#day 1
print(len(get_present_map(moves)))

#day 2 
moves1 = moves[::2]
moves2 = moves[1::2]

map1 = get_present_map(moves1)
map2 = get_present_map(moves2)

all_positions = list(map1)
all_positions.extend(list(map2))
all_positions = list(set(all_positions))

print(len(all_positions))