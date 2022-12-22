input_path = fullfile(get_input_root,'day_20.txt');
x = readmatrix(input_path);

x = int64(x);
x = x*811589153;

i = [1:numel(x)]';
x0 = x;
i0 = i;

n = numel(x0);
for k = 1:10
for i1 = 1:numel(i0)
   i_m = find(i0(i1) == i);

   v = x(i_m);
   iv = i(i_m);
   x(i_m) = [];
   i(i_m) = [];
   ir = 1:numel(x0)-1;
   
   i_nu = i_m+v;
   i_n = wrap(i_nu,numel(x));
   
   if (i_n == 1)&&v<0
      i_n = numel(x0);
   end

   x = [ x(ir(ir<i_n)) ; v; x(ir(ir>=i_n))];
   i = [ i(ir(ir<i_n)) ; iv ;i(ir(ir>=i_n))];
end
end

iz = find(x == 0);
i_sum = wrap(iz + [1000,2000,3000],n);

disp(sum(x(i_sum)))



function j = wrap(i,n)
j = mod(i-1,n)+1;
end