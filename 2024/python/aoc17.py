# -*- coding: utf-8 -*-
import numpy as np

#prepare variables ############################################################
input_path = '..\inputs\day_17.txt'
txt = open(input_path).read()
lines = txt.split('\n')

reg = []
for i in range(0,3):
     reg.append(int(lines[i].split(':')[1]))
prog = [int(x) for x in lines[4].split(':')[1].split(',')]
#prog = list(zip(prog[::2],prog[1::2]))

#part 1 #######################################################################
def combo(op,reg):
    if op == 0 or op == 1 or op == 2 or op == 3:
        return op
    elif op == 4 or op == 5 or op == 6:
        return reg[op-4]
    

def adv(reg,op):
    global ip
    op = combo(op,reg)
    reg[0] = int(reg[0]/(2**op))
    ip += 2
    
def bxl(reg,op):
    global ip
    reg[1] = op^reg[1]
    ip += 2

def bst(reg,op):
    global ip
    reg[1] = combo(op,reg)%8
    ip += 2

def jnz(reg,op):
    global ip
    if not reg[0] == 0:
        ip = op
    else:
        ip+=2

def bxc(reg,op):
    global ip
    reg[1] = reg[1]^reg[2]
    ip += 2

def out(reg,op):
    global ip,pout
    pout += str(combo(op,reg)%8) + ','
    ip += 2
    
def bdv(reg,op):
    global ip
    op = combo(op,reg)
    reg[1] = int(reg[0]/(2**op))
    ip += 2
    
def cdv(reg,op):
    global ip
    op = combo(op,reg)
    reg[2] = int(reg[0]/(2**op))
    ip += 2

opdict = {0:adv,1:bxl,2:bst,3:jnz,4:bxc,5:out,6:bdv,7:cdv}

ip = 0
pout = ''

while ip < len(prog):
    op_fun = opdict[prog[ip]]
    op_fun(reg,prog[ip+1])
    #print(ip)


print(pout.strip(','))

