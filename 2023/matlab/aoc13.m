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


r = [];
c = [];
for i0 = 1:numel(d)
    x = d{i0};
    for i1 = 1:size(x,2)-1
        
        s = min(i1,size(x,2)-i1);
        
        p1 = x(:,i1-s+1:i1);
        p2 = x(:,i1+1:i1+s);
        if all(p1 == fliplr(p2),'all')
            c = [c,i1]
        end
    end
    
    for i1 = 1:size(x,1)-1
        s = min(i1,size(x,1)-i1);
        
        p1 = x(i1-s+1:i1,:);
        p2 = x(i1+1:i1+s,:);
        if all(p1 == flipud(p2),'all')
            r = [r,i1];
        end
    end
end
sum(r*100)+sum(c)