run(fullfile(get_input_root(),'day_1.m'))
% part 1
p1 = sum(diff(x)>0)
% part 2
p2 = sum(diff(conv(x,[1,1,1],'valid'))>0)

assert(p1 == 1692)
assert(p2 == 1724)