input_path = fullfile(get_input_root,'day_14.txt');
txt = read_txt(input_path);
lines = strsplit(txt,'\r\n');


%% parse input
rock_paths = cell(numel(lines),1);
for i1 = 1:numel(lines)
    line_i1 = lines{i1};
    line_i1 = ['[', strrep(line_i1,'->',';'),'];'];
    eval(['x_i1 = ',line_i1]);
    rock_paths{i1} = x_i1;
end

s = [500,0];

all_points = cat(1,s,rock_paths{:});

xmin = min(all_points(:,1));
xmax = max(all_points(:,1));
ymin = min(all_points(:,2));
ymax = max(all_points(:,2));
xy_ranges = [xmin,xmax,ymin,ymax];

x = xmin:xmax;
y = ymin:ymax;
m = zeros(numel(y),numel(x));

s_rc = xy_to_rc(s,xy_ranges);
m(s_rc(1),s_rc(2)) = 3;

for i1 = 1:numel(rock_paths)
    xy = rock_paths{i1};
    rc = xy_to_rc(xy,xy_ranges);
    for i2 = 1:size(rc,1)-1
        r = sort([rc(i2,1),rc(i2+1,1)]);
        c = sort([rc(i2,2),rc(i2+1,2)]);
        m(r(1):r(2),c(1):c(2)) = 1;
    end
end
figure(1);
imagesc(m)
ir = false(size(m)); %positions at rest

%% part 1
void = 0;
while (~void)
    s_ind = m==2;
    s_m = s_ind&(~ir);
    
    [rs,cs] = find(s_m);
    if ~isempty(rs)
        for i2 = 1:numel(rs)
            rc_m = [[rs(i2)+1,cs(i2)];
                [rs(i2)+1,cs(i2)-1];
                [rs(i2)+1,cs(i2)+1]];
            i_v = get_valid_positions(rc_m,size(m));
            
            moved = 0;
            void = 0;
            for i3 = 1:size(rc_m,1)
                if i_v(i3)
                    if m(rc_m(i3,1),rc_m(i3,2)) == 0
                        m(rs(i2),cs(i2)) = 0;
                        m(rc_m(i3,1),rc_m(i3,2)) = 2;
                        moved = 1;
                        break;
                    end
                else
                    m(rs(i2),cs(i2)) = 0;
                    void = 1;
                    break;
                end
            end
            if (~moved)&&(~void)
                ir(rs(i2),cs(i2)) = true;
            end
            break;
        end
    else
        m(s_rc(1)+1,s_rc(2)) = 2;
    end
    
%     figure(1);
%     imagesc(m+2*(~ir&m==2))
%     drawnow();
end

    figure(1);
    imagesc(m+2*(~ir&m==2))
    drawnow();
p1 = sum(ir(:));
disp(p1);


function cr = xy_to_rc(xy,xy_ranges)
cr = cat(2,xy(:,2)- xy_ranges(3)+1,xy(:,1)- xy_ranges(1)+1 );
end

function i_v = get_valid_positions(rc,m_s)
i_v = rc(:,1)<=m_s(1)&rc(:,2)<=m_s(2)&rc(:,1)>0&rc(:,2)>0;
end