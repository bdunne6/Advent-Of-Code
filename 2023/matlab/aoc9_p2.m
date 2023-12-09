clear;
input_path = fullfile(get_input_root,'day_9.txt');
x = read_txt(input_path);

lines = strsplit(x,crlf);

lines = cellfun(@(x)(strsplit(x,' ')),lines,'UniformOutput',false);

lines = cat(1,lines{:});

d = str2double(lines);

di1 = d;

N = size(d,2);

da = [];

y = 0;
for i1 = 1:size(d,1)
    di1 = d(i1,:);
    dd = [];
    dd = cat(1,dd,{di1});
    for i2 = 1:N
        di1 = diff(di1);
        dd = cat(1,dd,{di1});
        if all(di1 == 0)
            break;
        end
    end
    
    for i2 = numel(dd):-1:1
        if i2 == numel(dd)
            dd{i2} = [0,dd{i2}]; 
        else
            dd{i2} = [dd{i2}(1)-dd{i2+1}(1) ,dd{i2}]; 
        end
    end
    
    y = y + dd{1}(1);
    
    da = cat(1,da,{dd});
end
disp(int64(y))
% y = cellfun(@(x) (x(end)),da)