%% parse input
input_path = fullfile(get_input_root,'day_12.txt');
txt = read_txt(input_path);
[m,s_pos,e_pos] = parse_input(txt);

%% part 1
[cnts,paths] = find_paths(m,s_pos,e_pos);
p1 = min(cnts);
disp(p1);

%% part 2
[is,js] = find(m == 1);
a_pos = [is,js];
mb = inf(size(m));
for i1 = 1:numel(paths)
    pi1 = paths{i1};
    for i2 = 1:size(a_pos,1)
        im = find(all(pi1==a_pos(i2,:),2));
        if ~isempty(im)
            pd = size(pi1,1) - im;
            if pd < mb(a_pos(1),a_pos(1))
                mb(a_pos(i2,1),a_pos(i2,2)) = pd;
            end
        end
    end
end
p2 = min(mb(:));
disp(p2);

%% local functions 
function [m,s_pos,e_pos] = parse_input(txt)
lines = strsplit(txt,'\r\n');
letters = 'abcdefghijklmnopqrstuvwxyz';
m = zeros(numel(lines),numel(lines{1}));
for i1 = 1:numel(lines)
    line_i1 = lines{i1};
    for i2 = 1:numel(line_i1)
        ci2 = line_i1(i2);
        if strcmp('S',ci2)
            s_pos = [i1,i2];
            m(i1,i2) = 1;
        elseif strcmp('E',ci2)
            e_pos = [i1,i2];
            m(i1,i2) = 26;
        elseif ismember(ci2,letters)
            m(i1,i2)= find(ci2 == letters);
        end
    end
end
end

function [cnts,paths] = find_paths(m,s_pos,e_pos)
m_cnt = nan(size(m));
m_cnt(s_pos(1),s_pos(2)) = 0;
d = [-1,0;1,0;0,-1;0,1];
cnts = [];
best_cnt = inf(size(m));
paths = [];
recurse_paths(s_pos,m_cnt,-1,[]);
    function recurse_paths(pos,m_cnt,cnt,pos_hist)
        cnt = cnt + 1;
        pos_hist = cat(1,pos_hist,pos);
        if all(pos == e_pos)
            cnts = [cnts,cnt];
            paths = [paths,{pos_hist}];
            return
        end
        moves = get_valid_moves(m,pos,d);
        for i1 = 1:size(moves,1)
            pos_i1 = moves(i1,:);
            if  isnan(m_cnt(pos_i1(1),pos_i1(2)))&&(cnt < best_cnt(pos_i1(1),pos_i1(2)))
                m_cnt(pos_i1(1),pos_i1(2)) = cnt;
                best_cnt(pos_i1(1),pos_i1(2)) = cnt;
                recurse_paths(pos_i1,m_cnt,cnt,pos_hist);
            end
        end
    end
end

function vm = get_valid_moves(m,pos,d)
vm = pos + d;
i_v = false(size(vm,1),1);
for i1 = 1:size(vm,1)
    i_v(i1) = (vm(i1,1)<=size(m,1))&&(vm(i1,2)<=size(m,2))&&(vm(i1,1)>0)&&(vm(i1,2)>0)&&(m(vm(i1,1),vm(i1,2))-m(pos(1),pos(2))<=1);
end
vm = vm(i_v,:);
end