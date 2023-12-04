clear;
input_path = fullfile(get_input_root,'day_4.txt');

x = read_txt(input_path);
lines = strsplit(x,newline);

%% part 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p1 = 0;
nw = zeros(numel(lines,1));
for i1 = 1:numel(lines)
    lp = strsplit(lines{i1},'|');
    wn = str2double(strsplit(strip(extractAfter(lp{1},':')),' '));
    cn = str2double(strsplit(strip(lp{2}),' '));
    nw(i1) = sum(ismember(cn,wn));
    p1 = (2^(nw(i1)-1))*(nw(i1) > 0) + p1;
end
disp(p1)

%% part 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n_cards = zeros(numel(lines),1);
for i1 = 1:numel(lines)
    c_won = i1+1:i1+nw(i1);
    n_cards(i1) = n_cards(i1) + 1;
    for i2 = 1:numel(c_won)
        n_cards(c_won(i2)) = n_cards(c_won(i2))+n_cards(i1);
    end
end
p2 = sum(n_cards);
disp(p2)