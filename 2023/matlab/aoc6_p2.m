clear;
input_path = fullfile(get_input_root,'day_6.txt');
%input_path = fullfile(get_input_root,'day_6_sample.txt');

x = read_txt(input_path);
lines = strsplit(x,newline);

time = strrep(strip(extractAfter(lines{1},'Time:')),' ','');

distance = strrep(strip(extractAfter(lines{2},'Distance:')),' ','');

time = str2double(time);
distance = str2double(distance);

time
distance

n_ways = zeros(numel(time),1);
for i1 = 1:numel(time)
   for i2 = 1:time(i1)
       t_charge = i2-1;
       t_left = time(i1)-t_charge;
       
       v = t_charge;
       d = v*t_left;
       if d > distance(i1)
           n_ways(i1) = n_ways(i1) + 1;
       end
   end
end
prod(n_ways)