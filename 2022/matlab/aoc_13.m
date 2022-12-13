%% parse input
input_path = fullfile(get_input_root,'day_13.txt');
txt = read_txt(input_path);

etxt = ['x = {',txt, '};'];
etxt = strrep(etxt,'[','{');
etxt = strrep(etxt,']','}');

eval(etxt);
n_pairs = numel(x)/2;

%% part 1
r = zeros(n_pairs,1);
for i1 = 1:n_pairs
    ind = 2*i1-1;
    x1 = x{ind};
    x2 = x{ind+1};
    r(i1) = compare(x1,x2);
end
p1 = sum(find(r));
disp(p1)

%% part 2
dp1 = {{2}};
dp2 = {{6}};
xs = cat(1,x,dp1,dp2);
xs = insertion_sort(xs,@compare);
xs = flipud(xs);

i_dp = [];
for i1 = 1:numel(xs)
   if isnan(compare(xs(i1),dp1))
       i_dp = [i_dp,i1];
   elseif isnan(compare(xs(i1),dp2))
       i_dp = [i_dp,i1];
   end
end
p2 = prod(i_dp);
disp(p2)

function r = sort_func(x1,x2)
r = compare(x1,x2);
if r == 0
    r = -1;
elseif isnan(r)
    r = 0;
end
end

function r = compare(x1,x2)
r = nan;
for i1 = 1:min(numel(x1),numel(x2))
    if isnumeric(x1{i1})&&isnumeric(x2{i1})
        if x1{i1} < x2{i1}
            r = 1;
        elseif x1{i1} > x2{i1}
            r = 0;
        end
    elseif iscell(x1{i1})&&isnumeric(x2{i1})
        r = compare(x1{i1},x2(i1));
    elseif isnumeric(x1{i1})&&iscell(x2{i1})
        r = compare(x1(i1),x2{i1});
    elseif iscell(x1{i1})&&iscell(x2{i1})
        r = compare(x1{i1},x2{i1});
    end
    if ~isnan(r)
        return;
    end
end
if isnan(r)
    if numel(x1) > numel(x2)
        r = 0;
        return;
    elseif (numel(x1) < numel(x2))
        r = 1;
        return;
    end
end
end

function [x] = insertion_sort(x,cfun)
%insertion_sort with optional comparison function
if nargin < 2
   cfun = @(x,y) (x > y); 
end
i = 2;
while i <= length(x)
    j = i;
    while j > 1 && cfun(x(j-1),x(j))
        t =  x(j);
        x(j) = x(j-1);
        x(j-1) = t;
        j = j - 1;
    end 
    i = i + 1;
end 
end