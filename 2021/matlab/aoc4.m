clear;
[n,b] = load_input(fullfile(get_input_root(),'day_4.txt'));

for i1 = 1:numel(n)
    s = ismember(b,n(1:i1));
    [c_ind,bw] = find(squeeze(all(s,1)));
    if isempty(bw)
        [r_ind,bw] = find(squeeze(all(s,2)));
    end
    w = any(all(s,1),'all')|any(all(s,2),'all');
    if w
        break;
    end
end
b_w = b(:,:,bw);

snum = sum(~s(:,:,bw).*b_w,'all');

p1 = snum*n(i1);
%part1 answer
disp(p1)
assert(p1 == 41503)

%start part2 
for i1 = 1:numel(n)
    s = ismember(b,n(1:i1));
    c_w = any(squeeze(all(s,1)),1);
    r_w = any(squeeze(all(s,2)),1);

    w_last = w;
    w = c_w|r_w;
    
    w_new = w&(~w_last);
    if all(w)
        break;
    end
    
end
b_w = b(:,:, w_new);

snum = sum((~s(:,:,w_new)).*b_w,'all');

p2 = snum*n(i1);
disp(p2)
assert(p2 == 3178)



function [n,b] = load_input(file_path)
txt = read_txt(file_path);
% txt_parts = strsplit(txt,['\r\n\r\n']);
txt_parts = strsplit(txt,['\n\n']);
n  = str2double(strsplit(txt_parts{1},','));
b_txt = txt_parts(2:end);

b = [];
for i1 = 1:numel(b_txt)
    bi1  = str2double(strsplit(b_txt{i1},{' ','\n'}));
    bi1 = bi1(~isnan(bi1));
    bi1 = reshape(bi1,[5,5])';
    b = cat(3,b,bi1);
end

% run(fullfile('inputs','day_4_test.m'));
% n = x.n;
% b1 = x.b1;
% b2 = x.b2;
% b3 = x.b3;
% b = cat(3,b1,b2,b3);
end