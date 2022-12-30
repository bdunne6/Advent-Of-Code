clear; close all;

%% parse input
input_path = fullfile(get_input_root,'day_16_sample.txt');
txt = read_txt(input_path);
lines = strsplit(txt,'\r\n');

expr = 'Valve (\w+) has flow rate=(\d+); tunnels? leads? to valves? ([\w, ]+)';
m = regexp(txt,expr,'tokens');
m = cat(1,m{:});

node_names = m{:,1};

edge_cell = [];
for i1 = 1:size(m,1)
    src_node = m{i1,1};
    dest_nodes = strsplit(m{i1,3},', ');
    for i2 = 1:numel(dest_nodes)
        edge_cell = cat(1,edge_cell, {src_node,dest_nodes{i2}});
    end
end
edge_table = table(edge_cell,'VariableNames',{'EndNodes'});
g = graph(edge_table);

pressures = cellfun(@str2double,m(:,2));

node_table = table(m(:,1),pressures,'VariableNames',{'Name','pressure'});

g = graph(edge_cell(:,1),edge_cell(:,2),1,node_table);


