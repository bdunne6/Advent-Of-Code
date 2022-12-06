input_path = fullfile(get_input_root,'day_6.txt');
x = read_txt(input_path);
%parts 1,2
for n = [4,14]
    for i1 = 1:numel(x)
        if numel(unique(x(i1:i1+n-1))) == n
            disp(i1 + n-1);
            break
        end
    end
end