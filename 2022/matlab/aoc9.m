input_path = fullfile(get_input_root,'day_9.txt');
x = readcell(input_path);

%% part 1 
h_path = [0,0];
t_path = [0,0];

h = [0,0];
t = [0,0];

for i1 = 1:size(x,1)
    n_s = x{i1,2};
    s_h = get_xy_step(x{i1,1});
    for i2 = 1:n_s
        h = h + s_h;
        d = h - t;
        
        if max(abs(d))>1
            s_t = sign(d);
        else
            s_t = [0,0];
        end
        
        t = t + s_t;
        
        h_path = cat(1,h_path,h);
        t_path = cat(1,t_path,t);
    end
end
p1 = size(unique(t_path,'rows'),1);
disp(p1)

%% part 2
k = zeros(10,2);
t_path = [];
for i1 = 1:size(x,1)
    n_s = x{i1,2};
    s_h = get_xy_step(x{i1,1});
    for i2 = 1:n_s
        k(1,:) = k(1,:) + s_h;
        for i3 = 2:size(k,1)
        d = k(i3-1,:) - k(i3,:);
        
        if max(abs(d))>1
            s_t = sign(d);
        else
            s_t = [0,0];
        end
        
        k(i3,:) = k(i3,:) + s_t;
        end
        t_path = cat(1,t_path,k(end,:));
    end
end

p2 = size(unique(t_path,'rows'),1);
disp(p2)

function s = get_xy_step(c)
switch c
    case 'R'
        s= [1,0];
    case 'L'
        s= [-1,0];
    case 'U'
        s= [0,1];
    case 'D'
        s= [0,-1];
end
end