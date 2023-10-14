input_path = '../inputs/day_1.txt'

x = open(input_path).read()

f = 0
ic = 0
for i,c in enumerate(x):
    if c == '(':
        f += 1
    else:
        f -= 1
    if f == -1 and ic == 0:
        ic = i + 1
        
#part1 
print(f)
#part 2   
print(ic)    