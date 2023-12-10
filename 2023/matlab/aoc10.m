clear; close all;
input_path = fullfile(get_input_root,'day_10_sample3.txt');
x = read_txt(input_path);

lines = strsplit(x,crlf);

cmap = cat(1,lines{:});

cdict = containers.Map();
cdict('|') = ...
    [0,1,0;
    0,1,0;
    0,1,0];

cdict('-') = ...
    [0,0,0;
    1,1,1;
    0,0,0];

cdict('L') = ...
    [0,1,0;
    0,1,1;
    0,0,0];

cdict('J') = ...
    [0,1,0;
    1,1,0;
    0,0,0];

cdict('7') = ...
    [0,0,0;
    1,1,0;
    0,1,0];


cdict('F') = ...
    [0,0,0;
    0,1,1;
    0,1,0];

cdict('S') =  ...
    [1,1,1;
    1,2,1;
    1,1,1];

pmap = cell(size(cmap));

for i1 = 1:numel(cmap)
    if cdict.isKey(cmap(i1))
        pmap{i1} = cdict(cmap(i1));
    else
        pmap{i1} = zeros(3);
    end
end

pmap = cell2mat(pmap);

%[r,nr] = bwlabel(pmap);



[r0,c0] = find(pmap==2);
br = bwselect(pmap,c0,r0,4);



b0 = zeros(size(br));
b0(2:3:end,2:3:end) = 1;

% ru = unique(r(:));
[r,c] = find(br.*b0);
i_lin = find(br.*b0);


figure;
imagesc(b0+br)



figure;
imagesc(br);
hold on;
plot(c,r,'.r')

ds = ...
    [-1,0;
    0,-1;
    1,0;
    0,1;];

figure;


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

[~,i_dmax] = max(D);

G.Nodes.Name(i_dmax)

p1 = max(D);
disp(p1)

% 
% n_remove = 1:max(st(:));
% n_remove = n_remove(~ismember(n_remove,st(:)));
% 
% G1 = rmnode(G, n_remove) ;

% figure;
% plot(G)








