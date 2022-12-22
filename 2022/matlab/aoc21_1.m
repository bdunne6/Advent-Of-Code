input_path = fullfile(get_input_root,'day_21_sample.txt');
txt = read_txt(input_path);
lines = strsplit(txt,'\r\n');

% x = cellfun(@(x)(strsplit(x,': ')),lines,'UniformOutput' ,false);
% x = cat(1,x{:});
x = readcell(input_path,"Delimiter",':',"TextType",'char');

i_root = strcmp(x(:,1),'root');

m = containers.Map(x(:,1),x(:,2));

letters = num2cell(char(97:122));

e_r0 = x{i_root,2};

v_r = regexp(e_r0, '[\*\+\-\/]', 'split');
e_r1 = e_r0;
%x = x(~i_root,:);
x1 = x;

k = m.keys;
while any(contains(m.values,letters))
    for i1 = 1:numel(k)
        if ~contains(x1{i1,2},letters)
            x1{i1,2}
        end
    end
end
eval(e_r1)



