clear;
input_path = fullfile(get_input_root,'day_4.txt');

x = read_txt(input_path);
lines = strsplit(x,newline);

%% part 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p1 = 0;
for i1_card = 1:numel(lines)
    lp = strsplit(lines{i1_card},'|');
    wn = strsplit(strip(extractAfter(lp{1},':')),' ');
    cn = strsplit(strip(lp{2}),' ');
    wn = str2double(wn);
    cn = str2double(cn);
    
    nw = sum(ismember(cn,wn));
    if nw > 0
        v = 2^(nw-1);
        p1 = v + p1;
    end
end
disp(p1)

%% part 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
card_ids = 1:numel(lines);
m0 = containers.Map(card_ids,zeros(size(card_ids)));
for i1_card = 1:numel(lines)
    lp = strsplit(lines{i1_card},'|');
    wn = strsplit(strip(extractAfter(lp{1},':')),' ');
    cn = strsplit(strip(lp{2}),' ');
    wn = str2double(wn);
    cn = str2double(cn);
    
    nw = sum(ismember(cn,wn));
    
    cards_won = i1_card+1:i1_card+nw;
    m0(i1_card) = m0(i1_card) + 1;
    for i2 = 1:numel(cards_won)
        i2_card = cards_won(i2);
        m0(i2_card) = m0(i2_card)+m0(i1_card);
    end
end
vals = m0.values;
p2 = sum([vals{:}]);
disp(p2)



