input_path = fullfile(get_input_root,'day_5.txt');
x = read_txt(input_path);

is_sample = 0;

lines = strsplit(x,'\r\n');

if is_sample
    char_stacks = lines(1:3);
else
    char_stacks = lines(1:9);
end

char_stacks = cat(1,char_stacks{:});

if is_sample
    char_stacks = char_stacks(:,2:4:end);
else
    char_stacks = char_stacks(1:end-1,2:4:end);
end
char_stacks = flipud(char_stacks);

if is_sample
    moves = lines(5:end);
else
    moves = lines(10:end);
end

rexp = 'move (\d+) from (\d) to (\d)';

moves1 = regexp(moves,rexp,'tokens');
moves1 = [moves1{:}];
moves1 = cat(1,moves1{:});
moves1 = cellfun(@str2double,moves1);

clear('stacks');
for i1 = 1:size(char_stacks,2)
    stacks(i1)= java.util.Stack();
    for i2 = 1:size(char_stacks,1)
        ci2 = strip(char_stacks(i2,i1));
        if ~isempty(ci2)
            stacks(i1).push(ci2) ;
        end
    end
end

%execute moves
for i1 = 1:size(moves1,1)
    n_pop = moves1(i1,1);
    
    c_i1 = [];
    for i2 = 1:n_pop
        c_i1 = cat(1,c_i1,stacks(moves1(i1,2)).pop());
    end
    
    c_i1 = flipud(c_i1);
    for i2 = 1:n_pop
    stacks(moves1(i1,3)).push(c_i1(i2));
    end
end

p1 = '';
for i1 = 1:numel(stacks)
    p1 = [p1,stacks(i1).pop()];
end
p1

