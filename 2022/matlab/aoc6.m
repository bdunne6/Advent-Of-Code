input_path = fullfile(get_input_root,'day_6.txt');
x = read_txt(input_path);

%part 1
for i1 = 1:numel(x)
    i_end = i1+3;
    if i_end > numel(x)
        break;
    end
    
    xi1 = x(i1:i_end);
    if numel(unique(xi1)) ==4
        istart = i1;
        istart + 3
        %xi1
        break
    end
    
end

%part 2
for i1 = 1:numel(x)
    i_end = i1+13;
    if i_end > numel(x)
        break;
    end
    
    xi1 = x(i1:i_end);
    if numel(unique(xi1)) ==14
        istart = i1;
        istart + 13
        %xi1
        break
    end
    
end

