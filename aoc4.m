clear;
run(fullfile('inputs','day_4_test.m'));

n = x.n;
b1 = x.b1;
b2 = x.b2;
b3 = x.b3;

b = cat(3,b1,b2,b3);
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