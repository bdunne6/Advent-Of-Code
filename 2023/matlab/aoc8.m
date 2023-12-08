clear;
input_path = fullfile(get_input_root,'day_8.txt');
%input_path = fullfile(get_input_root,'day_8_sample.txt');

x = read_txt(input_path);

lines = strsplit(x,crlf);

d = lines{1};

m = containers.Map();
for i1 = 2:numel(lines)
    lp = strsplit(lines{i1},'=');
    LR = strsplit(strip(erase(erase(lp{2},'('),')')),',');
    for i2 = 1:numel(LR)
       LR{i2} = strip(LR{i2}); 
    end
    
    m(strip(lp{1})) = LR;
end

ks = 'AAA';

N_max = 10e6;
for i1 = 1:N_max
   i_m = mod(i1-1,numel(d))+1; 
   ks
   c = m(ks);
   if d(i_m) == 'L'
        ks = c{1};
   elseif d(i_m) == 'R'
       ks = c{2};
   end
   if ks == 'ZZZ'
       break;
   end
   
   
end
disp(i1)