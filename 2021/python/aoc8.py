import numpy as np
import re

input_path = '../inputs/day_8.txt'
file_data = open(input_path).read()
string_parts = re.split('\||\\n', file_data)
string_parts = list(filter(None, string_parts))

even_parts = string_parts[1::2]

substrings = [list(s.split()) for s in even_parts]
flat_list = [item for sublist in substrings for item in sublist]
n_chars = [len(item) for item in flat_list]

n_chars = np.asarray(n_chars)

p1 = np.isin(n_chars,[2,4,3,7]).sum()
print(p1)