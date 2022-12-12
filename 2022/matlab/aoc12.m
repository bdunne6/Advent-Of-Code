clear;
input_path = fullfile(get_input_root,'day_12.txt');
txt = read_txt(input_path);
lines = strsplit(txt,'\r\n');

letters_upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
letters_lower = lower(letters_upper);

d = [-1,0;1,0;0,-1;0,1];

m = zeros(numel(lines),numel(lines{1}));
for i1 = 1:numel(lines)
    line_i1 = lines{i1};
    for i2 = 1:numel(line_i1)
        ci2 = line_i1(i2);
        if strcmp('S',ci2)
            pos = [i1,i2];
            m(i1,i2) = 0;
        elseif strcmp('E',ci2)
            pos_e = [i1,i2];
            m(i1,i2) = 26;
        elseif ismember(ci2,letters_lower)
            m(i1,i2)= find(ci2 == letters_lower);
        end
    end
end
best_cnt = nan(size(m));
best_cnt(pos(1),pos(2)) = 0;
cnt = 0;
cnt = find_path(m,pos,best_cnt,cnt,d,pos_e);
disp(cnt)

function [n_out] = find_path(m,pos,best_cnt,cnt,d,pos_e)
    persistent n 
    n_out = [];
    
    cnt = cnt + 1;    
    if all(pos == pos_e)
        n = [n,cnt];
        n_out = n
        return
    end

    %add current move to visted location
    moves = get_valid_moves(m,pos,d);
    for i1 = 1:size(moves,1)
        posi1 = moves(i1,:);
        %find_path(m,posi1,best_cnt,cnt,d);
        %cnt < best_cnt(posi1(1),posi1(2))
        if isnan(best_cnt(posi1(1),posi1(2)))||cnt < best_cnt(posi1(1),posi1(2))
            best_cnt(posi1(1),posi1(2)) = cnt;
            n_out = find_path(m,posi1,best_cnt,cnt,d,pos_e);
        end
    end
end

function cmoves = get_valid_moves(m,pos,d)
cmoves = pos + d;
i_valid = (cmoves(:,1)<=size(m,1))&(cmoves(:,2)<=size(m,2))&(cmoves(:,1)>0)&(cmoves(:,2)>0);
cmoves = cmoves(i_valid,:);
i_valid = ((m(sub2ind(size(m),cmoves(:,1),cmoves(:,2))) - m(pos(1),pos(2)))<=1)|m(sub2ind(size(m),cmoves(:,1),cmoves(:,2)))==Inf;
cmoves = cmoves(i_valid,:);
end