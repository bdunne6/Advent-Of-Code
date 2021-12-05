lines = [0,9 , 5,9;
    8,0 , 0,8;
    9,4 , 3,4;
    2,2 , 2,1;
    7,0 , 7,4;
    6,4 , 2,0;
    0,9 , 2,9;
    3,4 , 1,4;
    0,0 , 8,8;
    5,5 , 8,2];


x1 = lines(:,1);
y1 = lines(:,2);

x2 = lines(:,3);
y2 = lines(:,4);

x_all = [x1(:);x2(:)];
y_all = [y1(:);y2(:)];

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
    
    if (dx == 0)||(dy == 0)
        c = c + ind;
    end
end

%part1
p1 = sum(c>1,'all');
p1

% for i1 = 1:size(lines,1)
%     mi1 = (y2(i1)-y1(i1))/(x2(i1)-x1(i1));
%     bi1 = y1(i1);
%     ind =  yg == xg*mi1 + bi1;
%     ind = ind&(xg >= x1(i1))&(xg <= x2(i1));
% %     if isinf(mi1)
% %         mi1 = (x2(i1)-x1(i1))/(y2(i1)-y1(i1));
% %
% %         bi1 = x1(i1);
% %         ind =  xg == yg*mi1 + bi1;
% %         ind = ind&(yg >= y1(i1))&(yg <= y2(i1));
% %     end
%     if mi1 == 0
%         c = c + ind;
%     end
% end
% c