# -*- coding: utf-8 -*-
from functools import lru_cache

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
@lru_cache(maxsize=None)
def iterate_val_p1(val,ck,next_input):
    if ck == '0': #+ case    
        val = val + next_input
    elif ck == '1': #* case
        val = val * next_input
    return val


def find_match_p1(combos,inputs,test):
    mval = 0
    for c in combos:
        val = inputs[0]
        for k in range(len(c)):
            val = iterate_val_p1(val,c[k],inputs[k+1])
            if val > test:
                break
        if test == val:
            mval = test
    return mval

#run part 1
matching = []
for line in lines: 
    test = line[0]
    inputs = line[1];
    n_op = len(inputs)-1;
    
    combos = [base_n(x,2).zfill(n_op) for x in list(range(pow(2,n_op)))]
    if find_match_p1(combos,inputs,test):
          matching.append(test)

print(sum(matching))

#part 2 #######################################################################
@lru_cache(maxsize=None)
def iterate_val_p2(val,ck,next_input):
    if ck == '0': #+ case    
        val = val + next_input
    elif ck == '1': #* case
        val = val * next_input
    elif ck == '2': #|| case
        val = int(str(val) + str(next_input))
    return val


def find_match_p2(combos,inputs,test):
    mval = 0
    for c in combos:
        val = inputs[0]
        for k in range(len(c)):
            val = iterate_val_p2(val,c[k],inputs[k+1])
            if val > test:
                  break
        if test == val:
            mval = test
    return mval

#run part 2
matching = []
for i,line in enumerate(lines): 
    test = line[0]
    inputs = line[1];
    n_op = len(inputs)-1;
    
    combos = [base_n(x,3).zfill(n_op) for x in list(range(pow(3,n_op)))]
    if find_match_p2(combos,inputs,test):
        matching.append(test)
        
print(sum(matching))