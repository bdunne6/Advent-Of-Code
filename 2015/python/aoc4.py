from hashlib import md5

input_path = '../inputs/day_4.txt'
txt = open(input_path).read()
#txt = 'abcdef'


def find_N_zeros(txt,N,imax):
    for i in range(0,imax):
        txt_in = txt + str(i)
        hash_hex = md5(txt_in.encode()).hexdigest()
        if hash_hex[0:N] == '0'*N:
            break

    print(hash_hex)
    return(i)


#part1
N = 5
imax = 1000000000
print(find_N_zeros(txt,N,imax))

#part2
N = 6
imax = 1000000000
print(find_N_zeros(txt,N,imax))