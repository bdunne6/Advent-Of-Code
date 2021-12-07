x = csvread(fullfile(get_input_root(),'day_7.txt'));

%x = [16,1,2,0,4,2,7,1,2,14]
d_range = min(x):1:max(x);


dmat = x - d_range';

d_totals = sum(abs(dmat),2);

[~,i_min] = min(d_totals);

d_range(i_min)
% 
% x - 2
