input_path = fullfile(get_input_root,'day_3.txt');
x = read_txt(input_path);

%part1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(sum(get_mul(x)));

%part2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i_do = strfind(x,'do()');
i_dont = strfind(x,'don''t()');

r = [];
i_start = 1;
complete = 0;
while ~complete
    i_stop = get_next(i_start,i_dont);
    if isnan(i_stop)
        x_i1 = x(i_start:end);
        complete = 1;
    else
        x_i1 = x(i_start:i_stop);
    end
    r = cat(1,r,get_mul(x_i1));
    i_start = get_next(i_stop,i_do);
end
disp(sum(r));

function r = get_mul(x)
    m = regexp(x,'mul\((\d+,\d+)\)','tokens');
    m = [m{:}];
    r = zeros(numel(m),1);
    for i1 = 1:numel(m)
        r(i1) = prod(str2double(strsplit(m{i1},',')));
    end
end

function i_next = get_next(i,a)
    delta = a-i;
    delta(delta<=0) = Inf;
    [dmin,i_a]= min(delta);
    if isinf(dmin)
        i_next = NaN;
    else
        i_next = a(i_a);
    end
end