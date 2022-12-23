input_path = fullfile(get_input_root,'day_15_sample.txt');
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

xr = xmin:xmax;
yr = ymin:ymax;

xy_ranges = [xmin,xmax,ymin,ymax];

m = zeros(ymax-ymin+1,xmax-xmin+1);

s_cr = xy_to_rc(s_xy,xy_ranges);
i_s = sub2ind(size(m),s_cr(:,1),s_cr(:,2));

b_cr = xy_to_rc(b_xy,xy_ranges);
i_b = sub2ind(size(m),b_cr(:,1),b_cr(:,2));

m(i_s) = 1;
m(i_b) = 2;

figure;
imagesc(xr,yr,m)

b_m = false(size(m));

[Xg,Yg] = meshgrid(xr,yr);
for i1 = 1:size(s_xy,1)
    d_th = sum(abs(s_xy(i1,:) - b_xy(i1,:)));
    
    xd = Xg - s_xy(i1,1);
    yd = Yg - s_xy(i1,2);
    d_m = abs(xd) + abs(yd);
    
    i_m = (d_m <= d_th);
    b_m = b_m|i_m;
end
b_m(m==2) = false;

sum(b_m(yr==10,:))


figure;
imagesc(xr,yr,b_m)



%% functions
function rc = xy_to_rc(xy,xy_ranges)
rc = cat(2,xy(:,2)- xy_ranges(3)+1,xy(:,1)- xy_ranges(1)+1 );
end