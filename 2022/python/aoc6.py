input_path = '../inputs/day_6.txt'
x = open(input_path).read()

#part 1
n = 4
for i in range(0,len(x)-n):
    i_end = i+n
    ci = x[i:i_end]
    if len(set(ci)) == n:
        print(i_end)
        break
    
#part 2
n = 14
for i in range(0,len(x)-n):
    i_end = i+n
    ci = x[i:i_end]
    if len(set(ci)) == n:
        print(i_end)
        break
        
    
