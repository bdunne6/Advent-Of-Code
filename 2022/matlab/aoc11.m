%% parse input 
input_path = fullfile(get_input_root,'day_11.txt');
txt = read_txt(input_path);
monkeys = strsplit(txt,'\r\n\r\n');
clear('m');
for i1 = 1:numel(monkeys)
    mi1 = monkeys{i1};
    mi1 = strsplit(mi1,'\r\n');
    m(i1).id = str2double(extractBetween(mi1{1},'Monkey',':'));
    m(i1).items = str2double(strsplit(extractAfter(mi1{2},'Starting items: '),','));
    m(i1).operation = extractAfter(mi1{3},'Operation: ');
    m(i1).test = str2double(extractAfter(mi1{4},'Test: divisible by '));
    m(i1).if_true = str2double(extractAfter(mi1{5},'If true: throw to monkey '));
    m(i1).if_false = str2double(extractAfter(mi1{6},'If false: throw to monkey '));
    m(i1).count = uint64(0);
end
cm = prod([m.test]);

%% parts 1 and 2
n_rounds = [20,10000];
m0 = m;
for ip = [1,2]
    m = m0;
    for i0 = 1:n_rounds(ip)
        for i1 = 1:numel(m)
            items = m(i1).items;
            for i2 = 1:numel(items)
                item_i2 = items(i2);
                m(i1).count = m(i1).count + 1;
                wn = apply_operation(item_i2,m(i1).operation);
                if ip == 1
                    wn = floor(wn/3);
                elseif ip == 2
                    wn = mod(wn,tv);
                end
                if mod(wn,m(i1).test) == 0
                    m_id = m(i1).if_true;
                else
                    m_id = m(i1).if_false;
                end
                m(i1).items = m(i1).items(2:end);
                mt_ind = [m.id] == m_id;
                m(mt_ind).items = [m(mt_ind).items,wn];
            end
        end
    end
    scount = sort([m.count],'descend');
    answer = scount(1)*scount(2);
    disp(answer)
end

function wn = apply_operation(w,op)
old = w;
eval([op,';']);
wn = new;
end