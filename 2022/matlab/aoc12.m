clear all;
%% parse input
input_path = fullfile(get_input_root,'day_12.txt');
txt = read_txt(input_path);
[m,s_pos,e_pos] = parse_input(txt);

%% part 1
m_cnt = nan(size(m));
m_cnt(s_pos(1),s_pos(2)) = 0;
[n,bc,ph] = search_all_paths(m,s_pos,m_cnt,0,e_pos);
p1 = min(n);
disp(p1);

%% part 2
[is,js] = find(m == 1);

pos_s = [is,js];

mb = inf(size(m));
for i1 = 1:numel(ph)
    pi1 = ph{i1};
    for i2 = 1:size(pos_s,1)
        %im = find(ismember(pi1,pos_s(i2,:),'rows'));
        im = find(all(pi1==pos_s(i2,:),2));
        if ~isempty(im)
            pd = size(pi1,1) - im;
            if pd < mb(pos_s(1),pos_s(1))
                mb(pos_s(i2,1),pos_s(i2,2)) = pd;
            end
        end
    end
end
p2 = min(mb(:));
disp(p2);


%% helper functions 
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
            m(i1,i2) = 0;
        elseif strcmp('E',ci2)
            e_pos = [i1,i2];
            m(i1,i2) = 26;
        elseif ismember(ci2,letters)
            m(i1,i2)= find(ci2 == letters);
        end
    end
end
end

function [n,best_cnt,p_all] = search_all_paths(m,pos,m_cnt,cnt,pos_e)
d = [-1,0;1,0;0,-1;0,1];
n = [];
best_cnt = inf(size(m));
p_all = [];
find_path(pos,m_cnt,cnt,[]);
n = n-1;
    function find_path(pos,m_cnt,cnt,pos_hist)
        cnt = cnt + 1;
        pos_hist = cat(1,pos_hist,pos);
        if all(pos == pos_e)
            n = [n,cnt];
            p_all = [p_all,{pos_hist}];
            return
        end
        moves = get_valid_moves(m,pos,d);
        for i1 = 1:size(moves,1)
            posi1 = moves(i1,:);
            if  isnan(m_cnt(posi1(1),posi1(2)))&&(cnt < best_cnt(posi1(1),posi1(2)))
                m_cnt(posi1(1),posi1(2)) = cnt;
                best_cnt(posi1(1),posi1(2)) = cnt;
                find_path(posi1,m_cnt,cnt,pos_hist);
            end
        end
    end
end

function vm = get_valid_moves(m,pos,d)
vm = pos + d;
i_valid = false(size(vm,1),1);
for i1 = 1:size(vm,1)
    i_valid(i1) = (vm(i1,1)<=size(m,1))&&(vm(i1,2)<=size(m,2))&&(vm(i1,1)>0)&&(vm(i1,2)>0)&&(m(vm(i1,1),vm(i1,2))-m(pos(1),pos(2))<=1);
end
vm = vm(i_valid,:);
end