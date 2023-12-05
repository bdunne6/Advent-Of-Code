clear;
input_path = fullfile(get_input_root,'day_5.txt');
%input_path = fullfile(get_input_root,'day_5_sample.txt');

x = read_txt(input_path);
% lines = strsplit(x,newline);

crlf = [char(13),char(10)];

s = extractBetween(x,'seeds:',[crlf,crlf]);
s = s{1};
s = str2double(strsplit(strip(s),' '));

map_keys = {'seed-to-soil','soil-to-fertilizer','fertilizer-to-water','water-to-light','light-to-temperature','temperature-to-humidity','humidity-to-location'};

maps = containers.Map();
for i1 = 1:numel(map_keys)
    if i1 < numel(map_keys)
        txt_i1 = extractBetween(x,[map_keys{i1},' map:'], [crlf,crlf]);
        txt_i1 = txt_i1{1};
    else
        txt_i1 = extractAfter(x,[map_keys{i1},' map:']);
    end
    txt_i1 = strip(txt_i1);
    lines_i1 = strsplit(txt_i1, crlf);
    
    mi1 = [];
    for i2 = 1:numel(lines_i1)
        ei2 = strsplit(lines_i1{i2},' ');
        mi1 = cat(1,mi1,ei2);
    end
    mi1 = str2double(mi1);
    
    maps(map_keys{i1}) = mi1;
    
    
end

s0 = s;

sv = s(1:2:end);
sl = s(2:2:end);

sm = [sv(:),sl(:)];
% s = [];
% for i1 = 1 :numel(sv)
%     si1 = sv(i1):sv(i1)+sl(i1)-1;
%     s = cat(2,s,si1);
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% l_max = 10000000;
% l_min = 0;
% 
% N_max = 1e8;
% 
% 
% 
% map_keys_rev = fliplr(map_keys);
% for i0 = 1:N_max
%     
%     y = loc_in_seed(maps,map_keys_rev,sm,l(i0));
% 
% end
% disp(i0)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
l = 1:1000:1e9;

l = 108957001-5000:1:1e9;
map_keys_rev = fliplr(map_keys);
for i0 = 1:numel(l)
    y = loc_in_seed(maps,map_keys_rev,sm,l(i0));
    if y
        break;
    end
    if mod(i0,100000)==0
       disp(i0) 
    end
end
disp(l(i0))

function y = loc_in_seed(maps,map_keys,sm,x)

for i1 = 1:numel(map_keys)
    mi1 = maps(map_keys{i1});
    mapped = false;
    for i2 = 1:size(mi1,1)
        mr = mi1(i2,:);
        s_lower = mr(1);
        s_upper = mr(1)+mr(3)-1;
        
        d_lower = mr(2);
        d_upper = mr(2)+mr(3)-1;
        
        if (x >= s_lower)&&(x <= s_upper)
            d = x - s_lower + d_lower;
            mapped = true;
        end
    end
    if ~mapped
        d = x;
    end
    x = d;
    
    
end
s_found = false;
for i1 = 1:size(sm,1)
    mr = sm(i1,:);
    s_lower = mr(1);
    s_upper = mr(1)+mr(2)-1;
    
    if (x >= s_lower)&&(x <= s_upper)
        s_found = true;
        break;
    end
end
y = s_found;
end

% min(find((ismember(s_r,s))));
% min(find((ismember(s_r,s))))
% p1 = min(l);
% disp(p1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for i0 = 1:numel(s)
% x = s(i0);
% for i1 = 1:numel(map_keys)
%     mi1 = maps(map_keys{i1});
%     mapped = false;
%     for i2 = 1:size(mi1,1)
%         mr = mi1(i2,:);
%         s_lower = mr(2);
%         s_upper = mr(2)+mr(3)-1;
%
%         d_lower = mr(1);
%         d_upper = mr(1)+mr(3)-1;
%
%         if (x >= s_lower)&&(x <= s_upper)
%             d = x - s_lower + d_lower;
%             mapped = true;
%         end
%     end
%     if ~mapped
%        d = x;
%     end
%     x = d;
% end
% l(i0) = d;
% end
% p1 = min(l);
% disp(p1)


