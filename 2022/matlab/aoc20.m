input_path = fullfile(get_input_root,'day_20.txt');
x0 = readmatrix(input_path);

n = numel(x0);
x = int64(x0);

i = (1:numel(x))';
format longg

%% part 1
i0 = i;
for i1 = 1:n
    i_o = find(i0(i1) == i);
    xv = x(i_o);
    iv = i(i_o);
    i_nu = i_o+xv;
    i_n = wrap(i_nu,n-1);
    if (i_n == 1)&&xv<0
        i_n = n;
    end
    ir = 1:n-1;
    x(i_o) = [];
    i(i_o) = [];
    x = [ x(ir(ir<i_n)) ; xv; x(ir(ir>=i_n))];
    i = [ i(ir(ir<i_n)) ; iv ;i(ir(ir>=i_n))];
end
iz = find(x == 0);
i_sum = wrap(iz + [1000,2000,3000],n);
disp(sum(x(i_sum)))

%% part 2
x = int64(x0)*811589153;
i0 = i;
for k = 1:10
    for i1 = 1:n
        i_o = find(i0(i1) == i);
        xv = x(i_o);
        iv = i(i_o);
        i_nu = i_o+xv;
        i_n = wrap(i_nu,n-1);
        if (i_n == 1)&&xv<0
            i_n = n;
        end
        ir = 1:n-1;
        x(i_o) = [];
        i(i_o) = [];
        x = [ x(ir(ir<i_n)) ; xv; x(ir(ir>=i_n))];
        i = [ i(ir(ir<i_n)) ; iv ;i(ir(ir>=i_n))];
    end
end
iz = find(x == 0);
i_sum = wrap(iz + [1000,2000,3000],n);
disp(sum(x(i_sum)))

function j = wrap(i,n)
j = mod(i-1,n)+1;
end