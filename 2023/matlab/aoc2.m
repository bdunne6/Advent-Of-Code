input_path = fullfile(get_input_root,'day_2.txt');

x = read_txt(input_path);
x = strip(x);
lines = strsplit(x,newline);

g = cell(numel(lines),1);

%part1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
max_vals = zeros(numel(lines),3);
for i1 = 1:numel(lines)
    line_i1 = lines{i1};
    reveals = strsplit(extractAfter(line_i1,':'),';');
    r = cell(numel(reveals),1);
    m = containers.Map({'red','green','blue'},[0,0,0]);
    for i2 = 1:numel(reveals)
        sets = strsplit(reveals{i2},',');
        s = cell(numel(sets),1);
        for i3 =  1:numel(sets)
            s{i3} = strsplit(strip(sets{i3}),' ');
            ni3 = str2double(s{i3}{1});
            m(s{i3}{2}) = max(m(s{i3}{2}),ni3 );
        end
        r{i2} = s;
    end
    v  = m.values;
    max_vals(i1,:) =[v{:}];
    g{i1} = r;
end
check = [14,13,12];

p1 = sum(find(~any(max_vals > check,2)));
disp(p1)

%part2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sum(max_vals(:,1).*max_vals(:,2).*max_vals(:,3))

