input_path = fullfile(get_input_root,'day_11.txt');
txt = read_txt(input_path);

monkeys = strsplit(txt,'\r\n\r\n');
n_rounds = 20;

clear('m');
for i1 = 1:numel(monkeys)
    mi1 = monkeys{i1};
    mi1 = strsplit(mi1,'\r\n');
    
    m(i1).id = str2double(extractBetween(mi1{1},'Monkey',':'));
    m(i1).items = str2double(strsplit(extractAfter(mi1{2},'Starting items: '),','));
    m(i1).operation = extractAfter(mi1{3},'Operation: ');
    m(i1).test = extractAfter(mi1{4},'Test: ');
    m(i1).if_true = extractAfter(mi1{5},'If true: ');
    m(i1).if_false = extractAfter(mi1{6},'If false: ');
    m(i1).count = 0;
end

for i0 = 1:n_rounds
    for i1 = 1:numel(m)
        items = m(i1).items;
        for i2 = 1:numel(items)
            item_i2 = items(i2);
            m(i1).count = m(i1).count + 1;
            wn = apply_operation(item_i2,m(i1).operation);
            wn = floor(wn/3);
            
            if apply_test(wn,m(i1).test)
                m_id = get_target_monkey(m(i1).if_true);
            else
                m_id = get_target_monkey(m(i1).if_false);
            end
            m(i1).items = m(i1).items(2:end);
            
            mt_ind = [m.id] == m_id;
            m(mt_ind).items = [m(mt_ind).items,wn];
        end
    end
end

for i1 = 1:numel(m)
    m(i1).items
end
scount = sort([m.count],'descend');
p1 = prod(scount(1:2));
disp(p1)

function wn = apply_operation(w,op)
old = w;
evalc(op);
wn = new;
end

function r = apply_test(w,test)
d = str2double(extractAfter(test,'divisible by '));
r = mod(w,d) == 0;
end
function id = get_target_monkey(s)
id = str2double(extractAfter(s,'throw to monkey '));
end
