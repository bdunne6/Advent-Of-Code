%% parse input
input_path = fullfile(get_input_root,'day_13.txt');
txt = read_txt(input_path);

etxt = ['x = {',txt, '};'];
etxt = strrep(etxt,'[','{');
etxt = strrep(etxt,']','}');

eval(etxt);
n_pairs = numel(x)/2;
r = zeros(n_pairs,1);
for i1 = 1:n_pairs
    disp('%%%%%%%%%%%%%%%%%%%%')
    ind = 2*i1-1;
    
    x1 = x{ind};
    x2 = x{ind+1};
    r(i1) = compare(x1,x2);
    
end
p1 = sum(find(r));
disp(p1)

function r = compare(x1,x2)
r = nan;
for i1 = 1:min(numel(x1),numel(x2))
    disp('comparing:')
    disp(x1{i1})
    disp(x2{i1})
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