clear;
input_path = fullfile(get_input_root,'day_7.txt');
%input_path = fullfile(get_input_root,'day_7_sample.txt');


strength ='AKQJT98765432';
code = fliplr('abcdefghijklm');



x = read_txt(input_path);
crlf = [char(13),char(10)];
lines = strsplit(x,crlf);

x = [];
for i1 = 1:numel(lines)
   x = cat(1,x,strsplit(lines{i1},' '));
   
end

hands = x(:,1);

for i1 = 1:numel(hands)
    hi1 = hands{i1};
   for i2 = 1:numel(strength)
        hi1 = strrep(hi1,strength(i2),code(i2));
   end
   hands{i1} = hi1;
end

bids = str2double(x(:,2));

for i1 = 1:numel(hands)
r(i1) = get_hand_rank(hands{i1});
end


[r,i_s] = sort(r);
bids = bids(i_s);
hands = hands(i_s);

[c,ia,ic] = unique(r);

i_n = 1:numel(hands);
for i1 = 1:numel(c)
   im = (c(i1) == r);
   if sum(im)>1
       [~,i_s] = sort(hands(im));
       i_t = i_n(im);
       i_t = i_t(i_s);
       i_n(im) = i_t;
       %bids(im) = bids(i_s);
       %hands(im) = hands(i_s);
   end
end
bids = bids(i_n);

p1 = sum(bids'.*(1:numel(bids)));
p1


% r = r - min(r)+1;
% sum(r.*bids')

% 
% c = unique(h);
% h = sort(h);

function rank = get_hand_rank(h)

hu = unique(h);
cu = zeros(size(hu));

for i1 = 1:numel(hu)
    cu(i1) = sum(hu(i1) == h);
end

% rank = 0
if sum(cu == 5) == 1
   rank = 7;
elseif sum(cu == 4) == 1
   rank = 6;
elseif sum(cu == 3) == 1&&sum(cu == 2) == 1
   rank = 5;
elseif sum(cu == 3) == 1&&sum(cu == 2) == 0
   rank = 4;
elseif sum(cu == 2) == 2
   rank = 3;
elseif sum(cu == 2) == 1
   rank = 2;
elseif numel(cu) == 5 
   rank = 1;
end
end
