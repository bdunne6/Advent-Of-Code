# -*- coding: utf-8 -*-

def base_n(x,n):
    if x == 0:
        return '0'
    nums = []
    while x:
        x, r = divmod(x, n)
        nums.append(str(r))
    return ''.join(reversed(nums))

def parse_line(line):
    [test,inputs] = line.split(':')
    test = int(test)
    inputs = inputs.split();
    inputs = [int(x) for x in inputs]
    return [test,inputs]

#prepare variables ############################################################
input_path = '..\inputs\day_7.txt'
txt = open(input_path).read()

lines = txt.split('\n')

lines = [parse_line(x) for x in lines]

#part 1 #######################################################################
matching = []
for line in lines: 
    test = line[0]
    inputs = line[1];
    n_op = len(inputs)-1;
    
    combos = [base_n(x,2).zfill(n_op) for x in list(range(pow(2,n_op)))]
    for c in combos:
        val = inputs[0]
        for k in range(len(c)):
            if c[k] == '0': #+ case    
                val = val + inputs[k+1]
            elif c[k] == '1': #* case
                val = val * inputs[k+1]
            if val > test:
                break
        if test == val:
            matching.append(val)
            break

print(sum(matching))

#part 2 #######################################################################
matching = []
for i,line in enumerate(lines): 
    test = line[0]
    inputs = line[1];
    n_op = len(inputs)-1;
    
    combos = [base_n(x,3).zfill(n_op) for x in list(range(pow(3,n_op)))]
    for c in combos:
        val = inputs[0]
        for k in range(len(c)):
            if c[k] == '0': #+ case    
                val = val + inputs[k+1]
            elif c[k] == '1': #* case  
                val = val * inputs[k+1]
            elif c[k] == '2': #|| case
                val = int(str(val) + str(inputs[k+1]))
            if val > test:
                break
        if test == val:
            matching.append(val)
            break
        
print(sum(matching))