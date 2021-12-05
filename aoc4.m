clear;
% run(fullfile('inputs','day_4_test.m'));
% n = x.n;
% b1 = x.b1;
% b2 = x.b2;
% b3 = x.b3;
%b = cat(3,b1,b2,b3);

txt = read_txt('inputs\day_4.txt');
txt_parts = strsplit(txt,['\r\n\r\n']);

n  = str2double(strsplit(txt_parts{1},','));
b_txt = txt_parts(2:end);

b = [];
for i1 = 1:numel(b_txt)
    bi1  = str2double(strsplit(b_txt{i1},{' ','\r\n'}));
    bi1 = bi1(~isnan(bi1));
    bi1 = reshape(bi1,[5,5])';
    b = cat(3,b,bi1);
end



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

answer = snum*n(i1);
answer