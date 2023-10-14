# -*- coding: utf-8 -*-

input_path = r'..\inputs\day_5.txt'
txt = open(input_path).read()
lines = txt.split('\n')

vowels = set('aeiou')
disallowed_substrings = ['ab', 'cd', 'pq','xy']

s = lines[0]


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