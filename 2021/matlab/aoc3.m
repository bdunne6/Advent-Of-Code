%  x = [0,0,1,0,0;
% 1,1,1,1,0;
% 1,0,1,1,0;
% 1,0,1,1,1;
% 1,0,1,0,1;
% 0,1,1,1,1;
% 0,0,1,1,1;
% 1,1,1,0,0;
% 1,0,0,0,0;
% 1,1,0,0,1;
% 0,0,0,1,0;
% 0,1,0,1,0];
input_path = fullfile('inputs','day_3.txt');

x = read_input(input_path);

g_b = mode(x,1);
e_b = ~g_b;

g = bin2dec(num2str(g_b));
e = bin2dec(num2str(e_b));

%part 1 
g*e

%part 2
x1 = x;
for i1 = 1:size(x1,2)
    frac = sum(x1(:,i1)==1)/sum(x1(:,i1)==0);
    
    b_keep = (frac > 1)|(frac==1);
    
    i_keep = x1(:,i1) == b_keep;
    x1 = x1(i_keep,:);
    
    if size(x1,1) == 1
       break; 
    end
end
og = bin2dec(num2str(x1));

x1 = x;
for i1 = 1:size(x1,2)
    frac = sum(x1(:,i1)==1)/sum(x1(:,i1)==0);
    
    b_keep = ~((frac > 1)|(frac==1));
    
    i_keep = x1(:,i1) == b_keep;
    x1 = x1(i_keep,:);
    
    if size(x1,1) == 1
       break; 
    end
end
co = bin2dec(num2str(x1));

%part 2
og*co

function x = read_input(input_path)
[txt] = read_txt(input_path);
lines = strsplit(txt,newline);
x = zeros(numel(lines),12,'logical');

for i1 = 1:numel(lines)
    for i2 = 1:size(x,2)
        x(i1,i2) = str2num(lines{i1}(i2));
    end
end
end
