input_path = fullfile(get_input_root,'day_10.txt');
x = read_txt(input_path);
lines = strsplit(x,'\r\n');

cc = 0;
x = 1;

clear('xv');
iv = [];
i = 0;
i1 = 0;
next_op = 1;
i0 = 0;
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

img1 = nan([6,40]);
is = 1;
for i1 = 1:size(img1,1)
    ir = is:is+size(img1,2)-1;
    b = abs(xv(ir) - (0:39))<=1;
    img1(i1,:) = b;

    is = ir(end)+1;
end
figure;
imagesc(img1)

% %part 2
% img1 = reshape(xv(1:240),[40,6])';
% img2 = 


