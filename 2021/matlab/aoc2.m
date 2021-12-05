txt = read_txt(fullfile(get_input_root(),'day_2.txt'));
lines = strsplit(txt,'\n');

parse_moves = @(lines,key) (str2double(extractAfter(lines(contains(lines,key)),' ')));
f = parse_moves(lines,"forward"); 
d = parse_moves(lines,"down"); 
u = parse_moves(lines,"up"); 

d_m = sum(d) - sum(u);
f_m = sum(f);

%part 1
p1 = d_m*f_m;
disp(p1)
assert(p1 == 1459206)

aim = 0;
h = 0;
d = 0;
for i1 = 1:numel(lines)
    x = str2double(extractAfter(lines{i1},' '));
    if contains(lines{i1},"down")
        aim = aim + x;
    end
    
    if contains(lines{i1},"up")
        aim = aim - x;
    end
    
    if contains(lines{i1},"forward")
        h = h + x;
        d = d  + aim*x;
    end
end

%part 2
p2 = h*d;
disp(int32(p2))
assert(p2 == 1320534480)