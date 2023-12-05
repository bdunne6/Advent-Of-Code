clear;
input_path = fullfile(get_input_root,'day_5.txt');
input_path = fullfile(get_input_root,'day_5.txt');

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

for i0 = 1:numel(s)
x = s(i0);
for i1 = 1:numel(map_keys)
    mi1 = maps(map_keys{i1});
    mapped = false;
    for i2 = 1:size(mi1,1)
        mr = mi1(i2,:);
        s_lower = mr(2);
        s_upper = mr(2)+mr(3)-1;
        
        d_lower = mr(1);
        d_upper = mr(2)+mr(3)-1;
        
        if (x >= s_lower)&&(x <= s_upper)
            d = x - s_lower + d_lower;
            mapped = true;
        end
    end
    if ~mapped
       d = x; 
    end
    d
    x = d;
end
l(i0) = d;
end
p1 = min(l);

% function d = apply_map(m,s)
%     for i1 = 1:
%
% end
% seed2soil =
%
% seed2soil = extractBetween(x,'seed-to-soil map:', [crlf,crlf]);
%
% soil2fertilizer = extractBetween(x,'soil-to-fertilizer map:', [crlf,crlf]);
%
% fertilizer2water = extractBetween(x,'fertilizer-to-water map:', [crlf,crlf]);
%
% water2light = extractBetween(x,'water-to-light map:', [crlf,crlf]);
%
% light2temperature = extractBetween(x,'light-to-temperature map:', [crlf,crlf]);
%
% temperature2humidity = extractBetween(x,'temperature-to-humidity map:', [crlf,crlf]);
%
% humidity2location = extractBetween(x,'humidity-to-location map:', [crlf,crlf]);


