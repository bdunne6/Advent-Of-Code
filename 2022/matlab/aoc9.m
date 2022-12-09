input_path = fullfile(get_input_root,'day_9.txt');
x = readcell(input_path);

h_path = [0,0];
t_path = [0,0];

h = [0,0];
t = [0,0];
figure;
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
        
%         hold off;
%         plot(h(1),h(2),'.r');
%         hold on;
%         plot(t(1),t(2),'ob');
%         pause(0.5)
%         
        
        h_path = cat(1,h_path,h);
        t_path = cat(1,t_path,t);
    end
end
size(unique(t_path,'rows'))


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