clear;
input_path = fullfile(get_input_root,'day_8.txt');
x = read_txt(input_path);

lines = strsplit(x,crlf);

d = lines{1};
m = containers.Map();
for i1 = 2:numel(lines)
    lp = strsplit(lines{i1},'=');
    LR = strsplit(strip(erase(erase(lp{2},'('),')')),',');
    for i2 = 1:numel(LR)
        LR{i2} = strip(LR{i2});
    end
    m(strip(lp{1})) = LR;
end

i_a = endsWith(m.keys,'A');
k = m.keys;
ka = k(i_a);

N_max = 1e5;
iz = cell(numel(ka),1);
for i1 = 1:N_max
    i_m = mod(i1-1,numel(d))+1;
    for i2 = 1:numel(ka)
        ks = ka{i2};
        if endsWith(ks,'Z')
            continue;
        end
        
        c = m(ks);
        if d(i_m) == 'L'
            ks = c{1};
        elseif d(i_m) == 'R'
            ks = c{2};
        end
        ka{i2} = ks;
        
        if endsWith(ks,'Z')
            iz{i2} =[iz{i2}, i1];
        end
        
    end
    if all(endsWith(ka,'Z'))
        break;
    end
end
p = cellfun(@(x) (x(1)),iz);
p2 = int64(lcms(p));
disp(p2);
