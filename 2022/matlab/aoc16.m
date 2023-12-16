clear; close all;

%% parse input
input_path = fullfile(get_input_root,'day_16_sample.txt');
txt = read_txt(input_path);
lines = strsplit(txt,'\r\n');

expr = 'Valve (\w+) has flow rate=(\d+); tunnels? leads? to valves? ([\w, ]+)';
m = regexp(txt,expr,'tokens');
m = cat(1,m{:});

node_names = m(:,1);

[node_names,i_s] = sort(node_names);
m = m(i_s,:);

edge_cell = [];

n = numel(node_names);
g.e = zeros(n);
g.n = zeros(n,1);

for i1 = 1:size(m,1)
    src_node = find(strcmp(m{i1,1},node_names));
        src_node_char = m{i1,1};
    g.n(i1) = str2double(m{i1,2});
    dest_nodes = strsplit(m{i1,3},', ');
    for i2 = 1:numel(dest_nodes)
        edge_cell = cat(1,edge_cell, {src_node_char,dest_nodes{i2}});
        dest_node = find(strcmp(dest_nodes{i2},node_names));
        g.e(src_node,dest_node) = 1;
    end
end


r = find(strcmp('AA',node_names));
ng = NaN;
bft = bfs(g, r, ng,node_names);


edge_table = table(edge_cell,'VariableNames',{'EndNodes'});
g = graph(edge_table);

pressures = cellfun(@str2double,m(:,2));

node_table = table(m(:,1),pressures,'VariableNames',{'Name','pressure'});

g = graph(edge_cell(:,1),edge_cell(:,2),1,node_table);
g = g.simplify();

figure;
plot(g)

function  [bft,so] = bfs(g, r, ng,node_names)

bft = struct();
q = [];
ex = false(size(g.n));
ex(r) = true;
q = cat(1,q,r);

so = struct();
clist = [];
while numel(q)>0
    n = q(end);
    clist = cat(1,clist,node_names(n));
    q(end,:) = [];
    if n == ng
        return
    end
    
    w = find(g.e(n,:));
    
    for i1 = 1:numel(w)
        if ~ex(w(i1))
            ex(w(i1)) = true;
            so(w(i1)).p = n;
            
            c = struct();
            c.p = n;
            c.d = w(i1);
            %c.name = node_names(w(i1));
            
            bft = setfield(bft,clist{:},node_names{w(i1)},c);
            
            q = cat(1,q,w(i1));
        end
    end
%     bft.c = q;
%     bft.p
%     bft.d
   % bft = setfield(bft,clist{:},c);
end
end


