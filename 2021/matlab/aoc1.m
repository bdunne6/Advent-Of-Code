run(fullfile('inputs','day_1.m'))
% part 1
sum(diff(x)>0)
% part 2
sum(diff(conv(x,[1,1,1],'valid'))>0)