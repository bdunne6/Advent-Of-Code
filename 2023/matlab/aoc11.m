clear; close all;
input_path = fullfile(get_input_root,'day_11.txt');
txt = read_txt(input_path);

%parse input
lines = strsplit(txt,crlf);
x = cat(1,lines{:});
x = arrayfun(@(x)(strrep(strrep(x,'.','0'),'#','1')),x,'Uniformoutput',false);
x = str2double(x);


%empty rows and columns
e_cols = find(all(~x,1));
e_rows = find(all(~x,2));

x = bwlabel(x);
ug = unique(x(:));
ug = ug(2:end);
Nr = [2,1e6];
D1 = zeros(numel(ug));
D2 = zeros(numel(ug));
for i1 = 1:numel(ug)
    for i2 = 1:i1-1
        [r1,c1] = find(x == ug(i1));
        [r2,c2] = find(x == ug(i2));
       
        rs = sort([r1,r2]);
        cs = sort([c1,c2]);
      
        nr = sum((e_rows>=rs(1))&(e_rows<=rs(2)));
        nc = sum(e_cols>=cs(1)&e_cols<=cs(2));
        
        D1(i1,i2) = abs(diff(rs))+nr*(Nr(1)-1) + nc*(Nr(1)-1) + abs(diff(cs));
        D2(i1,i2) = abs(diff(rs))+nr*(Nr(2)-1) + nc*(Nr(2)-1) + abs(diff(cs));
    end
end
%print part 1 and 2 answer
disp(int64(sum(D1(:))))
disp(int64(sum(D2(:))))