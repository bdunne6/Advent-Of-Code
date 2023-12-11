clear; close all;
input_path = fullfile(get_input_root,'day_11.txt');
x = read_txt(input_path);

lines = strsplit(x,crlf);

g = cat(1,lines{:});


g = arrayfun(@(x)(strrep(strrep(x,'.','0'),'#','1')),g,'Uniformoutput',false);
g = str2double(g);




e_cols = find(all(~g,1));
e_rows = find(all(~g,2));


g = bwlabel(g')';

g = sparse(g);

for i1 = numel(e_cols):-1:1
    g = [g(:,1:e_cols(i1)),sparse(size(g,1),1e6), g(:,e_cols(i1)+1:end)];
end

for i1 = numel(e_rows):-1:1
    g = [g(1:e_rows(i1),:);sparse(1e6,size(g,2));g(e_rows(i1)+1:end,:)];
end


L = g;
% figure;
% imagesc(L)

ul = unique(L(:));
ul = ul(2:end);

D = zeros(numel(ul));
for i1 = 1:numel(ul)
    for i2 = 1:i1-1
        [r1,c1] = find(L == ul(i1));
        [r2,c2] = find(L == ul(i2));
        
        D(i1,i2) = abs(r1-r2) + abs(c1-c2); 
    end
end

sum(D(:))
