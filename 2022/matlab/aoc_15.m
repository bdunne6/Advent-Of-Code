input_path = fullfile(get_input_root,'day_15.txt');
txt = read_txt(input_path);
%lines = strsplit(txt,'\r\n');

rexp = 'Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)';
m = regexp(txt,rexp,'tokens');
x = cellfun(@str2double,cat(1,m{:}));

xy = [[x(:,1);x(:,3)],[x(:,2);x(:,4)]];

s_xy = x(:,1:2);
b_xy = x(:,3:4);

ymin = min(xy(:,2));
ymax = max(xy(:,2));
xmin = min(xy(:,1));
xmax = max(xy(:,1));

xr = 2*xmin:2*xmax;
yr = ymin:ymax;

xy_ranges = [xmin,xmax,ymin,ymax];

if contains(input_path,'sample')
    y_q = 10;
else
    y_q = 2000000;
end
s_d = sum(abs((s_xy - b_xy)),2);

r_o = false(1,numel(xr));

t0 = tic();
for i1 = 1:numel(xr)
    x_q = xr(i1);
    q_d = abs(s_xy(:,1)-x_q)+abs(s_xy(:,2)-y_q);
    if any(q_d <= s_d)% && ~ismember([x_q,y_q],b_xy,'rows')%&& ~ismember([x_q,y_q],s_xy,'rows')
        r_o(i1) = true;
    else
        r_o(i1) = false;
    end
    if mod(i1,100000) == 0
        disp(i1/numel(xr)*100);
    end
end
xy_q = [xr(:),y_q*ones(numel(xr),1)];
i_m = ismember(xy_q,b_xy,'rows');
r_o(i_m) = false;
t1 = toc(t0)

sum(r_o)






%% functions
function rc = xy_to_rc(xy,xy_ranges)
rc = cat(2,xy(:,2)- xy_ranges(3)+1,xy(:,1)- xy_ranges(1)+1 );
end