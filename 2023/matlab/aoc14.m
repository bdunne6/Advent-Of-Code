clear; close all;
input_path = fullfile(get_input_root,'day_14.txt');
txt = read_txt(input_path);

d = txt;

lines = strsplit(d,crlf);
x = cat(1,lines{:});
x = arrayfun(@(x)(strrep(strrep(strrep(x,'.','0'),'#','1'),'O','2')),x,'Uniformoutput',false);
x = str2double(x);

y = zeros(size(x));
for i1 = 1:size(x,2)
   c = x(:,i1);
   is = find(c==1);
   ir = find(c==2);
   is = cat(1,is,size(x,1)+1);
   for i2 = 1:numel(is)
        if i2 == 1
           i_low = 1; 
        else
           i_low = is(i2-1)+1; 
        end
        i_high = is(i2)-1;
        %sum(ir>i_low&ir<i_high)
        y(i_low:i_high,i1) = sort( x(i_low:i_high,i1),'descend');
       
   end
end
y(x==1) = x(x==1);


y_pos = (size(x,1):-1:1)'*ones(1,size(x,2));
load = sum(y_pos.*(y==2),'all');
load