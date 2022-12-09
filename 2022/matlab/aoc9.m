input_path = fullfile(get_input_root,'day_9.txt');
x = readcell(input_path);
step_lookup = struct('R',[1,0],'L',[-1,0],'U',[0,1],'D',[0,-1]);

%% parts 1,2
for n = [2,10]
    k = zeros(n,2);
    t_path = nan(sum(cat(1,x{:,2})),2);
    ip = 0;
    for i1 = 1:size(x,1)
        for i2 = 1:x{i1,2}
            k(1,:) = k(1,:) + step_lookup.(x{i1,1});
            for i3 = 2:size(k,1)
                d = k(i3-1,:) - k(i3,:);
                if max(abs(d))>1
                    s_t = sign(d);
                else
                    s_t = [0,0];
                end
                k(i3,:) = k(i3,:) + s_t;
            end
            ip = ip+1;
            t_path(ip,:) = k(end,:);
        end
    end
    p2 = size(unique(t_path,'rows'),1);
    disp(p2)
end