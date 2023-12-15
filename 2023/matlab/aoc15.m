clear; close all;
input_path = fullfile(get_input_root,'day_15.txt');
txt = read_txt(input_path);

%parse input
lines = strsplit(txt,crlf);
x = strsplit(lines{1},',');

% part 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i1 = 1:numel(x)
    s = x{i1};
    v(i1)  = hash(s);
end
%part 1 answer
disp(sum(v))

%% part 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b = cell(1,256);
for i1 = 1:numel(b)
    b{i1} = struct();
end

for i1 = 1:numel(x)
    s = x{i1};
    if contains(s,'-')
        op = '-';
    else
        op = '=';
    end
    sp = strsplit(s,op);
    ib = hash(sp{1})+1;
    
    m = b{ib};
    if op == '='
        m.(sp{1}) = str2double(sp{2});
    elseif op == '-'
        if isfield(m,(sp{1}))
            m = rmfield(m,sp{1});
        end
    end
    b{ib} = m;
end

ib = find(~cellfun(@isempty,b));

fp = [];
for i1 = 1:numel(ib)
    mi1 = b{ib(i1)};
    vi1 = get_v(mi1);
    for i2 = 1:numel(vi1)
        fpi2 = ib(i1)*i2*vi1(i2);
        fp = [fp,fpi2];
    end
end
%part 2 answer
disp(sum(fp))

function v = hash(s)
v = 0;
for i1 = 1:numel(s)
    for i2 = 1:3
        switch i2
            case 1
                v = v + int64(s(i1));
            case 2
                v = v*17;
            case 3
                v = rem(v,256);
        end
    end
end
end
function v = get_v(m)
    fnames = fieldnames(m);
    v = [];
    for i1 = 1:numel(fnames)
       v = cat(2,v,m.(fnames{i1}));
    end
end

