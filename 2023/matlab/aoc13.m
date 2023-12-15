clear; close all;
input_path = fullfile(get_input_root,'day_13.txt');
txt = read_txt(input_path);

d = strsplit(txt,[crlf,crlf]);
for i1 = 1:numel(d)
    lines = strsplit(d{i1},crlf);
    x = cat(1,lines{:});
    x = arrayfun(@(x)(strrep(strrep(x,'.','0'),'#','1')),x,'Uniformoutput',false);
    d{i1} = str2double(x);
end

r1 = [];c1 = [];r2 = [];c2 = [];
for i0 = 1:numel(d)
    x = d{i0};
    for i1 = 1:size(x,2)-1
        s = min(i1,size(x,2)-i1);
        p1 = x(:,i1-s+1:i1);
        p2 = x(:,i1+1:i1+s);
        if all(p1 == fliplr(p2),'all')
            c1 = [c1,i1];
        end
        if sum(p1 == fliplr(p2),'all') == numel(p2(:)) - 1
            c2 = [c2,i1];
        end
    end
    
    for i1 = 1:size(x,1)-1
        s = min(i1,size(x,1)-i1);
        p1 = x(i1-s+1:i1,:);
        p2 = x(i1+1:i1+s,:);
        if all(p1 == flipud(p2),'all')
            r1 = [r1,i1];
        end
        if sum(p1 == flipud(p2),'all') == numel(p2(:)) - 1
            r2 = [r2,i1];
        end
    end
end
%part1
disp(sum(r1*100)+sum(c1))
%part2
disp(sum(r2*100)+sum(c2))