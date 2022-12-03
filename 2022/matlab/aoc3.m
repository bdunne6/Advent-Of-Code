tic
input_path = fullfile(get_input_root,'day_3.txt');

x = read_txt(input_path);
lines = strsplit(x);

letters_upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
letters_lower = lower(letters);
%part 1
compartments = cell(numel(lines),2);
intersection_chars = cell(size(lines));

score = nan(size(lines));
for i1 = 1:numel(lines)
    line_i1 = lines{i1};
    n_char = numel(line_i1)/2;
    %n_char
    compartments{i1,1} = line_i1(1:n_char);
    compartments{i1,2} = line_i1(n_char+1:end);
    
    intersection_chars{i1} = intersect(compartments{i1,1},compartments{i1,2});
    i_lower = find(letters_lower == intersection_chars{i1});
    i_upper = find(letters_upper == intersection_chars{i1});
    if ~isempty(i_lower)
        score(i1) = i_lower;
    elseif ~isempty(i_upper)
        score(i1) = i_upper+26;
    end
end
sum(score)

%% part 2 
intersection_chars = cell(size(lines));

group_inds = [1:3:numel(lines)-2];
score = nan(size(group_inds));
for i1 = 1:numel(group_inds)
    group_i1 = lines(group_inds(i1):group_inds(i1)+2);
    c_intersect = intersect(intersect(group_i1{1},group_i1{2}),group_i1{3});
    i_lower = find(letters_lower == c_intersect);
    
    i_upper = find(letters_upper == c_intersect);
    if ~isempty(i_lower)
        score(i1) = i_lower;
    elseif ~isempty(i_upper)
        score(i1) = i_upper+26;
    end
%         
end
sum(score)






