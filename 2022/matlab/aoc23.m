clear; close all;

%% parse input
input_path = fullfile(get_input_root,'day_23.txt');
txt = read_txt(input_path);
lines = strsplit(txt,'\r\n');

x = zeros(numel(lines),numel(lines{1}));
for i1 = 1:numel(lines)
    i_e = uint8(lines{i1})==35;
    x(i1,i_e) = 1;
end

[y,x] = find(x);
xy = [x,max(y)-y];

%% set initial directions
m = [0,1;%N
    0,-1,;%S
    -1,0;%W
    1,0;];%E

n  = [1,0;%N
    -1,0;%S
    0,-1;%W
    0,1;
    1,1;%N
    -1,1;%S
    1,-1;%W
    -1,-1;];

mc = {[0,1; 1,1; -1,1],[0,-1; 1,-1; -1,-1],[-1,0;-1,1;-1,-1],[1,0;1,1;1,-1]};


%% execute

n_iter = 10;
for i0 = 1:n_iter
%     figure;
%     plot(xy(:,1),xy(:,2),'.');
%     title(num2str(i0-1));
    
    xy_p = zeros(size(xy));
    i_m = false(size(xy,1),1);
    for i1 = 1:size(xy)
        xy1 = xy(i1,:);
        if any(ismember(xy1 + n,xy,'rows'))
            for i2 = 1:size(m,1)
                xy_t = xy1 + mc{i2};
                if ~any(ismember(xy_t,xy,'rows'))
                    i_m(i1) = true;
                    xy_p(i1,:) = xy1 + m(i2,:);
                    break;
                end
            end
        end
    end
    rc_pc = xy_p(:,1) + xy_p(:,2)*1i;
    up = unique(rc_pc);
    for i1 = 1:numel(up)
        imu = up(i1) == rc_pc;
        if sum(imu) > 1
           i_m(imu) = false;
        end
    end

    xy(i_m,:) = xy_p(i_m,:);
    
    m = circshift(m,-1);
    mc = circshift(mc,-1);
    i0
end

xw = max(xy(:,1))- min(xy(:,1)) + 1;
yw = max(xy(:,2))- min(xy(:,2)) + 1;

et = xw*yw - size(xy,1);
et
