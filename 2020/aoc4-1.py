with open('aoc4-1.txt', newline='') as f:
    data = f.read()
    
data = data.split('\r\n\r\n')

#parse text into list of dictionary
for i1 in range(0,len(data)):
    data[i1] = data[i1].replace('\r\n',' ')
    fields = data[i1].split(' ')
    df = dict()
    fparts = [f.split(':')  for f in fields]
    for fp in fparts:
        df[fp[0]] = fp[1]
    data[i1] = df
    


#required fields
req0 = set(['byr','iyr','eyr','hgt','hcl','ecl' ,'pid','cid'])
req1 = set(['byr','iyr','eyr','hgt','hcl','ecl' ,'pid'])
n_req = len(req1)
#validation function dict
r_check = lambda x,r : int(x) >= r[0] and int(x) <= r[1]

def hgt_check(v_str):
    is_valid = 0
    unit = v_str[-2:]
    val = int(v_str[:-2])
    if unit == 'cm':
        is_valid = r_check(val,[150,193])
    elif unit == 'in':
        is_valid = r_check(val,[59,76])
    return is_valid
            
            
def char_range(c1, c2):
    """Generates the characters from `c1` to `c2`, inclusive."""
    for c in range(ord(c1), ord(c2)+1):
        yield chr(c)
            
def hcl_check(v_str):
    v_chars = set(list(map(str,range(0,10))) + list(char_range('a','f')))
    if v_str[0] =='#':
        c_str = v_str[1:]
        n_str = len(c_str)
        all_valid = v_chars.issuperset(list(c_str))
        if all_valid and n_str==6:
            return 1
    return 0
        
def ecl_check(v_str):
    v_color = set(['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'])
    return v_color.issuperset([v_str])
    
def pid_check(v_str):
    v_len = (len(v_str) == 9)
    v_chars = set(list(char_range('0','9')))
    return v_chars.issuperset(list(v_str)) and v_len
    


v_func = {
'byr': lambda x : r_check(x,[1920,2002]),
'iyr': lambda x : r_check(x,[2010,2020]),
'eyr': lambda x : r_check(x,[2020,2030]),
'hgt': hgt_check,
'hcl': hcl_check,
'ecl': ecl_check,
'pid': pid_check,
 }

v_any = lambda x,k : v_func[k](x[k])


is_valid = [0]*len(data)
for i1 in range(0,len(data)):
    d = data[i1]
    req_foundi1 = req1.intersection(d.keys())
    if len(req_foundi1) >= len(req1):
        #is_valid[i1] = 1
        try:    
            validi1 = 1
            for k in req1:
                f_val = v_func[k]
                if not f_val(d[k]):
                    validi1 = 0
                    break
                
            is_valid[i1] = validi1
        except:
            is_valid[i1] = 0
            

            
            
    else:
        continue
    
print(sum(is_valid))    

