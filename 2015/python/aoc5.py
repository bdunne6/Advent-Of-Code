# -*- coding: utf-8 -*-

input_path = r'..\inputs\day_5.txt'
txt = open(input_path).read()
lines = txt.split('\n')


#part 1 
vowels = set('aeiou')
disallowed_substrings = ['ab', 'cd', 'pq','xy']

nice_count = 0

for s in lines:
    vowel_count = 0
    nice = False
    duplicate_count = 0
    for (i,c) in enumerate(s):  
        if c in vowels:
            vowel_count += 1
        if i < len(s)-1:
            if s[i] == s[i+1]:
                duplicate_count +=1
    
    
    bad_substring = False
    for ds in disallowed_substrings:
        if ds in s:
            bad_substring  = True
    
    is_nice = (not bad_substring) and (duplicate_count>0) and (vowel_count>=3)
    
    if is_nice:
        nice_count += 1

print(nice_count)

#part 2

nice_count = 0

for s in lines:
    pcount = dict()
    pair_repeat = False
    for i in range(0,len(s)-1):
        cpair = s[i:i+2]
        if cpair in pcount:
            if i > pcount[cpair][-1] + 1:
                pcount[cpair].append(i)
                pair_repeat = True
                break
        else:
            pcount[cpair] = [i]
    
    max_pair_repeats = max([len(v) for v in pcount.values()])
    
    gap_repeat = False
    for i in range(1,len(s)-1):
       if s[i-1] == s[i+1]:
           gap_repeat = True
           break
    
    is_nice = gap_repeat and pair_repeat
    if is_nice:
        nice_count += 1

print(nice_count)



    



