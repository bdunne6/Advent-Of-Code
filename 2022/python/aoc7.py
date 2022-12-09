from collections import defaultdict

input_path = '../inputs/day_7_sample.txt'
x = open(input_path).read()
lines = x.split('\n')



# def add_value_nested_keys(d,keys,val):
    
#     di0 = {keys[-1]:val}
#     for i in range(len(keys)):
#         di0 = {keys[i]:}    
    


def tree(): return defaultdict(tree)

t = tree()



t0 = t
current_dir = []
for i,l in enumerate(lines):

    if l.startswith('$ cd'):
        tdir = l.split('$ cd')[-1]
        tdir = tdir.strip()
        
        
        t1 = dict()
        if tdir != '/':
            t1.update({'..':t0})
            
            
        
        if tdir != '..':
            current_dir.append(tdir)
        else:
            current_dir.pop()
        print(current_dir)
        
    if 
    

