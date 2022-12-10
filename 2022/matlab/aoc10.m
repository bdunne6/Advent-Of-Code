input_path = fullfile(get_input_root,'day_10.txt');
lines = strsplit(read_txt(input_path),'\r\n');

%% part 1
x = 1;
i1 = 0;
next_op = 1;
i0 = 0;
clear('xv');
while true
    if next_op
        i1 = i1 + 1;
        c = strsplit(lines{i1},' ');
        op = c{1};
        if op == 'addx'
            xc = x + str2double(c{2});
            n = 2;
        elseif op == 'noop'
            xc = x;
            n = 1;
        end
        next_op = 0;
    else
        i0 = i0 + 1;
        xv(i0) = x;
        n = n - 1;
        if n == 0
            x = xc;
            next_op = 1;
            if (i1 == numel(lines))
                xv(i0+1) = x;
                break;
            end
        end        
    end
end
ind = [1:numel(xv)];
p1 = sum(xv(20:40:end).*ind(20:40:end));
disp(p1)

%% part 2
img_x = reshape(xv(1:240),[40,6])';
img_c = ones(6,1)*(0:39);
figure;
imagesc(abs(img_x-img_c)<=1)


