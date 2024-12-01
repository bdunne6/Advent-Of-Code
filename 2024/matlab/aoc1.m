input_path = fullfile(get_input_root,'day_1.txt');

x = read_txt(input_path);
x = strip(x);
lines = strsplit(x,crlf);

%part1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = [];
for i1 = 1:numel(lines)
    v = strsplit(lines{i1},' ');
    x = cat(1,x,str2double(v));
end

L1 = sort(x(:,1));
L2 = sort(x(:,2));

disp(sum(abs(L1 - L2)))

%part 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s = 0;
for i1 = 1:size(x,1)
   si1 = sum(x(i1,1) == x(:,2))*x(i1,1);
   s = s + si1; 
end

disp(s)
