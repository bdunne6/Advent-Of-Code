clear; close all;
input_path = fullfile(get_input_root,'day_14.txt');
txt = read_txt(input_path);

%parse input6
lines = strsplit(txt,crlf);
x = cat(1,lines{:});
x = arrayfun(@(x)(strrep(strrep(strrep(x,'.','0'),'#','1'),'O','2')),x,'Uniformoutput',false);
x = str2double(x);

%% part 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y = tilt(x);
l = calc_load(y);
disp(l)

% part 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
spin = [0,-1,-2,-3];
y = x;

Nc = 1000;
yt = zeros(size(y,1),size(y,2),Nc);
L = zeros(Nc,1);
for i0 = 1:Nc
    for i1 = 1:4
        y = rot90(y,spin(i1));
        y = tilt(y);
        y = rot90(y,-spin(i1));
    end
end
l = calc_load(y);
%part 2
disp(l)

function y = tilt(x)
y = zeros(size(x));
for i1 = 1:size(x,2)
    c = x(:,i1);
    is = find(c==1);
    is = cat(1,is,size(x,1)+1);
    for i2 = 1:numel(is)
        if i2 == 1
            i_low = 1;
        else
            i_low = is(i2-1)+1;
        end
        i_high = is(i2)-1;
        y(i_low:i_high,i1) = sort( x(i_low:i_high,i1),'descend');
    end
end
y(x==1) = x(x==1);
end

function l = calc_load(y)
y_pos = (size(y,1):-1:1)'*ones(1,size(y,2));
l = sum(y_pos.*(y==2),'all');
end