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

%% parts 1 and 2
s = [500,0];
for p = [1,2]
    rp_xy = cat(1,s,rock_paths{:});
    if p == 1
        ymin = min(rp_xy(:,2));
        ymax = max(rp_xy(:,2));
        xmin = min(rp_xy(:,1));
        xmax = max(rp_xy(:,1));
    elseif p ==2
        ymin = min(rp_xy(:,2));
        ymax = max(rp_xy(:,2))+2;
        xmin = s(1) - (ymax-ymin+2);
        xmax = s(1) + (ymax-ymin+2);
        rock_paths = cat(1,rock_paths,{[xmin,ymax;xmax,ymax]});
    end
    
    m = zeros(ymax-ymin+1,xmax-xmin+1);
    
    xy_ranges = [xmin,xmax,ymin,ymax];
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
    
    void_loop = 0;
    plugged = 0;
    i1 = 0;
    rs = []; cs = [];
    while (~void_loop)&&(~plugged)
        if ~isempty(rs)
            for i2 = 1:numel(rs)
                rc_m = [[rs(i2)+1,cs(i2)];
                    [rs(i2)+1,cs(i2)-1];
                    [rs(i2)+1,cs(i2)+1]];
                i_v = get_valid_positions(rc_m,size(m));
                
                moved = 0;
                void_loop = 0;
                for i3 = 1:size(rc_m,1)
                    if i_v(i3)
                        if m(rc_m(i3,1),rc_m(i3,2)) == 0
                            m(rs(i2),cs(i2)) = 0;
                            m(rc_m(i3,1),rc_m(i3,2)) = 2;
                            rs = rc_m(i3,1);
                            cs = rc_m(i3,2);
                            moved = 1;
                            break;
                        end
                    else
                        m(rs(i2),cs(i2)) = 0;
                        void_loop = 1;
                        break;
                    end
                end
                if (~moved)&&(~void_loop)
                    m(rs(i2),cs(i2)) = 2;
                    rs = [];
                    cs = [];
                end
                break;
            end
        else
            if m(s_rc(1),s_rc(2)) == 2
                plugged = 1;
            else
                rs = s_rc(1);
                cs = s_rc(2);
            end
        end
        i1 = i1+1;
    end
    %print answer for part
    answer = sum(m==2,'all');
    disp(answer);
    
    %plot
    figure(p);
    imagesc(m)
    drawnow();
end

%% functions
function cr = xy_to_rc(xy,xy_ranges)
cr = cat(2,xy(:,2)- xy_ranges(3)+1,xy(:,1)- xy_ranges(1)+1 );
end

function i_v = get_valid_positions(rc,m_s)
i_v = rc(:,1)<=m_s(1)&rc(:,2)<=m_s(2)&rc(:,1)>0&rc(:,2)>0;
end
