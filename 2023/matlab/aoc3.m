clear;
%input_path = fullfile(get_input_root,'day_3.txt');
input_path = fullfile(get_input_root,'day_3_sample.txt');

x = read_txt(input_path);
lines = strsplit(x,newline);

symbols = {'#','$','%','&','*','+','-','/','=','@'};

%% part 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c1 = [];
for i1 = 1:numel(lines)
    line_i1 = lines{i1};
    line_i1 = strip(line_i1);
    c1 = cat(1,c1,line_i1);
    m = regexp(line_i1,'(\d+)','tokens');
end

c1 = num2cell(c1);
smask = ismember(c1,symbols);
smask_n = conv2(double(smask),ones(3),'same')>0;

nmask = ~isnan(arrayfun(@str2double,c1));

lmask = zeros(size(nmask));
for i1 = 1:size(nmask,1)
    lmask(i1,:) = bwlabel(nmask(i1,:));
    if i1 > 1
        lmask(i1,lmask(i1,:)>0) = lmask(i1,lmask(i1,:)>0) + max(lmask(1:i1-1,:),[],'all');
    end
end

ids = [];
for i1 = 1:size(smask_n,1)
    ids = unique(cat(2,ids,smask_n(i1,:).*lmask(i1,:)));
end
ids = ids(2:end);

p1 = 0;

id_map = containers.Map('KeyType', 'double', 'ValueType', 'double');
for i1 = 1:numel(ids)
    i_i2 = ids(i1) == lmask;
    nc = c1(i_i2);
    v_i2 = str2double([nc{:}]);
    id_map(ids(i1)) = v_i2;
    p1 = p1 + v_i2;
end
disp(p1)

%% part 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[sr,sc] = find(smask);

p2 = 0;
for i1 = 1:numel(sr)
    r0 = sr(i1);
    c0 = sc(i1);
    
    r = r0-1:r0+1;
    c = c0-1:c0+1;
    r((r<1)|(r>size(smask_n,1))) = [];
    c((c<1)|(c>size(smask_n,2))) = [];
    
    su = unique(lmask(r,c));
    if numel(su)==3
        v = id_map(su(2))*id_map(su(3));
        p2 = p2+ v;
    end
end
disp(p2)