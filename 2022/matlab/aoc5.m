input_path = fullfile(get_input_root,'day_5.txt');
x = read_txt(input_path);

fparts = strsplit(x,'\r\n\r\n');
stack_state = fparts{1};
moves_char = fparts{2};

is_sample = 0;

char_stacks = strsplit(stack_state,'\r\n');
char_stacks = cat(1,char_stacks{:});
char_stacks = char_stacks(1:end-1,:);


char_stacks = char_stacks(:,2:4:end);
char_stacks = flipud(char_stacks);

moves = strsplit(moves_char,'\r\n');

rexp = 'move (\d+) from (\d) to (\d)';

moves1 = regexp(moves,rexp,'tokens');
moves1 = [moves1{:}];
moves1 = cat(1,moves1{:});
moves1 = cellfun(@str2double,moves1);

clear('stacks1');
for i1 = 1:size(char_stacks,2)
    stacks1(i1)= java.util.Stack();
    stacks2(i1)= java.util.Stack();
    for i2 = 1:size(char_stacks,1)
        ci2 = strip(char_stacks(i2,i1));
        if ~isempty(ci2)
            stacks1(i1).push(ci2) ;
             stacks2(i1).push(ci2) ;
        end
    end
end

%execute moves
stacks1 = execute_moves_part1(stacks1,moves1);

p1 = '';
for i1 = 1:numel(stacks1)
    p1 = [p1,stacks1(i1).pop()];
end
p1


stacks2 = execute_moves_part2(stacks2,moves1);
p2 = '';
for i1 = 1:numel(stacks2)
    p2 = [p2,stacks2(i1).pop()];
end
p2

function stacks = execute_moves_part2(stacks,moves1)
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
end

function stacks = execute_moves_part1(stacks,moves1)
%execute moves
for i1 = 1:size(moves1,1)
    n_pop = moves1(i1,1);
    for i2 = 1:n_pop
        stacks(moves1(i1,3)).push(stacks(moves1(i1,2)).pop());
    end
end
end

