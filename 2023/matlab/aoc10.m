clear; close all;
input_path = fullfile(get_input_root,'day_10.txt');
x = read_txt(input_path);

lines = strsplit(x,crlf);

cmap = cat(1,lines{:});
cdict = connectivity_dict();
pmap = cell(size(cmap));
for i1 = 1:numel(cmap)
    if cdict.isKey(cmap(i1))
        pmap{i1} = cdict(cmap(i1));
    else
        pmap{i1} = zeros(3);
    end
end

pmap = cell2mat(pmap);
[r0,c0] = find(pmap==2);
br = bwselect(pmap,c0,r0,4);

b0 = zeros(size(br));
b0(2:3:end,2:3:end) = 1;

[r,c] = find(br.*b0);
i_lin = find(br.*b0);

ds = [-1,0;0,-1;1,0;0,1;];

st = [];
for i1 = 1:numel(r)
    bb = br(r(i1)-1:r(i1)+1,c(i1)-1:c(i1)+1);
    for i2 = 1:size(ds,1)
        rt = r(i1)+3*ds(i2,1);
        ct = c(i1)+3*ds(i2,2);
        rep = sort([r(i1),rt]);
        cep = sort([c(i1),ct]);
        ri2 = [rep(1):rep(2)];
        ci2 = [cep(1):cep(2)];
        if (max(ri2)<=size(br,1))&&(min(ri2)>=1)&&(max(ci2)<=size(br,2))&&(min(ci2)>=1)
            if all(br(ri2,ci2))
                n1 = sub2ind(size(b0),r(i1),c(i1));
                n2 = sub2ind(size(b0),rt,ct);
                st = cat(1,st,[n1,n2]);
            end
        end
    end
end
st = unique(sort(st,2),'rows');
stc = arrayfun(@num2str,st,'UniformOutput',false);

G = graph(stc(:,1),stc(:,2));
s = num2str(sub2ind(size(b0),r0,c0));
D = distances(G,s);

p1 = max(D);
disp(p1)


%% part 2
am = imfill(br,'holes');
bf = am(2:3:end,2:3:end);
rf = br(2:3:end,2:3:end);
bf(rf) = 0;
p2 = sum(bf(:));
disp(p2)

%% visualization 
b_vis = br+br.*b0;
b_fill = imfill(b_vis,'holes');
b_fill(~b0) = 0;

figure;
imagesc(b_fill)

function m = connectivity_dict()
m = containers.Map();
m('|') = ...
    [0,1,0;
    0,1,0;
    0,1,0];

m('-') = ...
    [0,0,0;
    1,1,1;
    0,0,0];

m('L') = ...
    [0,1,0;
    0,1,1;
    0,0,0];

m('J') = ...
    [0,1,0;
    1,1,0;
    0,0,0];

m('7') = ...
    [0,0,0;
    1,1,0;
    0,1,0];


m('F') = ...
    [0,0,0;
    0,1,1;
    0,1,0];

m('S') =  ...
    [1,1,1;
    1,2,1;
    1,1,1];
end