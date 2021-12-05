clear;
file_path = 'inputs\day_5.txt';
lines = load_input(file_path);

x_all = [lines(:,1);lines(:,3)];
y_all = [lines(:,2);lines(:,4)];

x_lin = min(x_all):max(x_all);
y_lin = min(y_all):max(y_all);

[xg,yg] = meshgrid(x_lin,y_lin);

c = zeros(size(xg));

for i1 = 1:size(lines,1)
    x1 = lines(i1,1);
    y1 = lines(i1,2);
    
    x2 = lines(i1,3);
    y2 = lines(i1,4);
    
    dx = x2-x1;
    dy = y2-y1;
    
    t1 = (xg - x1)/dx;
    t2 = (yg - y1)/dy;
    
    if (dx == 0)
        ind = (t2 >= 0)&(t2 <= 1)&(xg == x1);
    elseif (dy == 0)
        ind = (t1 >= 0)&(t1 <= 1)&(yg == y1);
    else
        ind = (t1 >= 0)&(t1 <= 1)&(t1==t2);
    end
    
    if (dx == 0)||(dy == 0)||1%comment the ||1 to get part 1 answer
        c = c + ind;
    end
end

%part1
p1 = sum(c>1,'all');
p1

function [lines] = load_input(file_path)
txt = read_txt(file_path );

lines = reshape(str2double(strsplit(strrep(txt, '->',','),{',','\r\n'})),4,[])';
% lines = [0,9 , 5,9;
%     8,0 , 0,8;
%     9,4 , 3,4;
%     2,2 , 2,1;
%     7,0 , 7,4;
%     6,4 , 2,0;
%     0,9 , 2,9;
%     3,4 , 1,4;
%     0,0 , 8,8;
%     5,5 , 8,2];
end