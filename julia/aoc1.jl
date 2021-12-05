#x = [199,200,208,210,200,207,240,269,260,263];




fid1 = open("..\\inputs\\day_1.txt") ; 
x = readlines(fid1) ; 
close(fid1)
x = parse.(Int64,x);
sum(diff(x).> 0) 

using DSP

xc_valid = conv(x,[1;1;1])[3:end-2];
sum(diff(xc_valid).>0)