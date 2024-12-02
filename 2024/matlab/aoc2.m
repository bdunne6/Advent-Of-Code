input_path = fullfile(get_input_root,'day_2.txt');

x = read_txt(input_path);
x = strip(x);
lines = strsplit(x,crlf);

%part1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s = zeros(numel(lines),1);
for i1 = 1:numel(lines)
   v = lines{i1};
   ns = strsplit(v,' ');
   n = str2double(ns);
   dn = diff(n);
   if all(sign(dn) >0)||all(sign(dn) <0)
       if min(abs(dn))>=1&&max(abs(dn))<=3
           s(i1) = 1;
       end
   end
end
sum(s)

%part2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s = zeros(numel(lines),1);
for i1 = 1:numel(lines)
    v = lines{i1};
    ns = strsplit(v,' ');
    n = str2double(ns);
    for i2 = 1:numel(n)
        ni2 = n;
        ni2(i2) = [];
        dn = diff(ni2);
        if all(sign(dn) >0)||all(sign(dn) <0)
            if min(abs(dn))>=1&&max(abs(dn))<=3
                s(i1) = 1;
            end
        end
    end
end
sum(s)