input_path = fullfile(get_input_root,'day_5.txt');
lines = strsplit(read_txt(input_path),crlf);

s1 = lines(contains(lines,'|'));
s2 = lines(~contains(lines,'|'));

r = cellfun(@(x)(strsplit(x,'|')) ,s1,'UniformOutput',false);
r = str2double(cat(1,r{:}));

%part 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d_low = containers.Map(r(:,1),cell(numel(r(:,1)),1));
d_high = containers.Map(r(:,2),cell(numel(r(:,2)),1));
for i1 = 1:size(r,1)
    d_low(r(i1,1)) = [d_low(r(i1,1)),r(i1,2)];
    d_high(r(i1,2)) = [d_high(r(i1,2)),r(i1,1)];
end

u_a = cellfun(@(x) (str2double(strsplit(x,','))),s2,'UniformOutput',false);
in_order = true(numel(u_a),1);
for i1 = 1:numel(s2)
    in_order(i1) = check_order(u_a{i1},d_high,d_low);
end
u_c = u_a(in_order);
p1 = sum(cellfun(@(x)(x((numel(x)+1)/2)),u_c));
disp(['part 1: ',num2str(p1)]);

%part 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cfun = @(x,y) (check_order([x,y],d_high,d_low));
u_ic = u_a(~in_order);

for i1 = 1:numel(u_ic)
    u_ic{i1} = insertion_sort(u_ic{i1},cfun);
end
p2 = sum(cellfun(@(x)(x((numel(x)+1)/2)),u_ic));
disp(['part 2: ',num2str(p2)]);

%functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function  in_order = check_order(u,d_high,d_low)
in_order = true;
iu = 1:numel(u);
for i2 = 1:numel(u)
    if  d_low.isKey(u(i2))
        higher = d_low(u(i2));
    else
        higher = [];
    end
    if d_high.isKey(u(i2))
        lower = d_high(u(i2));
    else
        lower = [];
    end
    if any(ismember(u(iu<i2),higher))||any(ismember(u(iu>i2),lower))
        in_order = false;
        break;
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
    while j > 1 && ~cfun(x(j-1),x(j))
        [x(j),x(j-1)] = swap(x(j),x(j-1));
        j = j - 1;
    end
    i = i + 1;
end
end
function [b, a] = swap(a, b);end
