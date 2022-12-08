input_path = fullfile(get_input_root,'day_8.txt');
x = read_txt(input_path);
lines = strsplit(x,'\r\n');

%parse input
x = nan(numel(lines),numel(lines{1}));
for i1 = 1:numel(lines)
    for i2 = 1:numel(lines{i1})
        x(i1,i2) = str2double(lines{i1}(i2));
    end
end

%part 1
x_vis = false([size(x,1),size(x,2),4]);
x1 = x;
for i1 = 1:4
    x1 = rot90(x1,1);
    x_vis = rot90(x_vis);
    for i2 = 1:size(x1,2)
        m = -1;
        for i3 = 1:size(x1,1)
            if x1(i3,i2) > m
                m = x1(i3,i2);
                x_vis(i3,i2) = true;
            end
        end
    end
end
p1 = sum(x_vis(:));
disp(p1);

%part 2
vt = 0;
x_vis = false([size(x,1),size(x,2),4]);
x1 = x;
scores = zeros(size(x1));
for i1 = 1:size(x1,1)
    for i2 = 1:size(x1,1)
        h1 = x1(i1,i2);
        dvects = [-1,0;1,0;0,-1;0,1];
        si2 = zeros(size(dvects,1),1);
        for i3 = 1:size(dvects,1)
            n = 0;
            while (1)
                n = n+1;
                r = i1+dvects(i3,1)*n;
                c = i2+dvects(i3,2)*n;
                if (r < 1)||(r > size(x1,1))||(c < 1)||(c > size(x1,1))
                    si2(i3) = n-1;
                   break; 
                end
                
                ht = x1(r,c);
                if ht >=h1
                    si2(i3) = n;
                   break; 
                end
                
            end
        end
        scores(i1,i2) = prod(si2);
    end
end

p2 = max(scores(:));
disp(p2);