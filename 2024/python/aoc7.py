# -*- coding: utf-8 -*-

#prepare variables ############################################################
input_path = '..\inputs\day_7.txt'
txt = open(input_path).read()

lines = txt.split('\n')

#part 1 #######################################################################
matching = []
for i,line in enumerate(lines): 

    [test,inputs] = line.split(':')
    inputs = inputs.split();
    n_op = len(inputs)-1;
    int_vals =  list(range(pow(2,n_op)))
    bin_vals = [('{0:0' + str(n_op)+ 'b}').format(x) for x in int_vals]
    
    for j,b in enumerate(bin_vals):
        o = b.replace('0','+')
        o = o.replace('1','*')
        
        estr = inputs[0]
        for k in range(len(o)):
            estr = '('+ estr +o[k]+ inputs[k+1]+')' 
            
        test_i = eval(estr)
            #print(estr)
            #print(test_i)
            #print('\n')
        if test_i == int(test):
            matching.append(int(test))
            break

            
print(sum(matching))

#part 2 #######################################################################
def base3(n):
    if n == 0:
        return '0'
    nums = []
    while n:
        n, r = divmod(n, 3)
        nums.append(str(r))
    return ''.join(reversed(nums))


matching = []
for i,line in enumerate(lines): 
    
    [test,inputs] = line.split(':')
    inputs = inputs.split();
    n_op = len(inputs)-1;
    int_vals =  list(range(pow(3,n_op)))
    
    bin_vals = [base3(x).zfill(n_op) for x in int_vals]
    
    for j,b in enumerate(bin_vals):
        o = b.replace('0','+')
        o = o.replace('1','*')
        o = o.replace('2','|')
        
        estr = inputs[0]
        for k in range(len(o)):
            if not o[k] == '|':
                estr = '('+ estr +o[k]+ inputs[k+1]+')' 
            else:
                estr = eval('(str('+ estr + ') + str(' + inputs[k+1]+'))')

        test_i = eval(estr)
      
        if test_i == int(test):
            matching.append(int(test))
            break
    #print('\n\n')
    print(str(i) + ' of ' + str(len(lines)))
        
print(sum(matching))