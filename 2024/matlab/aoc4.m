input_path = fullfile(get_input_root,'day_4.txt');

lines = strsplit(read_txt(input_path),crlf);
X = cat(1,lines{:});

%part 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = [];
base = 'XMAS';
for i1 = 0:3
    k = cat(1,k,{rot90(base,i1),rot90(diag(base),i1)});
end
disp(conv_count(X,k))

%part 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k_base = max(diag(double('MAS')),fliplr(diag(double('MAS'))));
k = cell(4,1);
for i1 = 0:3
    k{i1+1} = rot90(k_base,i1);
end
disp(conv_count(X,k))

%functions%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function count = conv_count(X,k)
count = 0;
for i1 = 1:numel(k)
    ki1 = double(k{i1});
    m  = conv2(double(X),ki1,'valid')/sum(ki1(:).*ki1(:)) == 1;
    count = count + sum(m(:));
end
end