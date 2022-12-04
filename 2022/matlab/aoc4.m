input_path = fullfile(get_input_root,'day_4.txt');
x = read_txt(input_path);

lines = strsplit(x,newline);

n_pairs_part1  = 0;
n_pairs_part2  = 0;
for i1 = 1:numel(lines)
    lines{i1} = strip(lines{i1});
    
    p =  strsplit(lines{i1},',');
    r1 =strsplit(p{1},'-');
    r2 =strsplit(p{2},'-');
    
    ri1 = str2double(r1{1}):str2double(r1{2});
    ri2 = str2double(r2{1}):str2double(r2{2});
    
    if all(ismember(ri1,ri2))||all(ismember(ri2,ri1))
        n_pairs_part1 = n_pairs_part1 + 1;
    end
    
    if any(ismember(ri1,ri2))
        n_pairs_part2 = n_pairs_part2 + 1;
    end
end

disp(n_pairs_part1)
disp(n_pairs_part2)