input_path = '../inputs/day_6.txt'
x = open(input_path).read()

#part 1,2
for n in [4,14]:
    for i in range(0,len(x)-n):
        if len(set(x[i:i+n])) == n:
            print(i+n) 
            break
            