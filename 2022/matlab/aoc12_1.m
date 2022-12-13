%% parse input
input_path = fullfile(get_input_root,'day_12.txt');
txt = read_txt(input_path);
[m,s_pos,e_pos] = parse_input(txt);
s_i = sub2ind(size(m),s_pos(1),s_pos(2));
e_i = sub2ind(size(m),e_pos(1),e_pos(2));

g = construct_graph(m);

%% part 1
[s_p,p1] = shortestpath(g,s_i,e_i);
disp(p1)

%% part 2
r_g = digraph(g.Edges.EndNodes(:,2),g.Edges.EndNodes(:,1));
[n_ids,n_d] = nearest(r_g, e_i, p1+1);
n_a = n_d(m(n_ids)==1);

p2 = n_a(1);
disp(p2)

figure;
imagesc(m);
[r,c] = ind2sub(size(m),s_p);
hold on;
plot(c,r,'.-r')

%% local functions
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
            m(i1,i2) = 1;
        elseif strcmp('E',ci2)
            e_pos = [i1,i2];
            m(i1,i2) = 26;
        elseif ismember(ci2,letters)
            m(i1,i2)= find(ci2 == letters);
        end
    end
end
end
function g = construct_graph(m)
d = [-1,0;1,0;0,-1;0,1];
s = [];
t = [];
for i1 = 1:size(m,1)
    for i2 = 1:size(m,2)
        moves = get_valid_moves(m,[i1,i2],d);
        t_i2 = sub2ind(size(m),moves(:,1),moves(:,2));
        s_i2 = sub2ind(size(m),i1,i2)*ones(size(t_i2,1),1);
        s = cat(1,s,s_i2);
        t = cat(1,t,t_i2);
    end
end
g = digraph(s,t);
end

function vm = get_valid_moves(m,pos,d)
vm = pos + d;
i_v = false(size(vm,1),1);
for i1 = 1:size(vm,1)
    i_v(i1) = (vm(i1,1)<=size(m,1))&&(vm(i1,2)<=size(m,2))&&(vm(i1,1)>0)&&(vm(i1,2)>0)&&(m(vm(i1,1),vm(i1,2))-m(pos(1),pos(2))<=1);
end
vm = vm(i_v,:);
end
