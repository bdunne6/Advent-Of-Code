input_path = fullfile(get_input_root,'day_4.txt');

x = read_txt(input_path);
x = strip(x);
lines = strsplit(x,crlf);

%part1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X1 = cat(1,lines{:});
X3 = char(imrotate(uint16(X1),90));

X = {X1,X3};

count = 0;
for i0 = 1:numel(X)
  Xi0 = X{i0};
    for i1 = 1:size(Xi0,1)
        count = count + numel((strfind(Xi0(i1,:),'XMAS')));
        count = count + numel((strfind(Xi0(i1,:),'SAMX')));
    end
end

for d = -(size(X1,1)-1):size(X1,1)-1
    count = count + numel((strfind(diag(X1,d)','XMAS')));
    count = count + numel((strfind(diag(X1,d)','SAMX')));
end

X1 = fliplr(X1);
for d = -(size(X1,1)-1):size(X1,1)-1
    count = count + numel((strfind(diag(X1,d)','XMAS')));
    count = count + numel((strfind(diag(X1,d)','SAMX')));
end
count

%part 2 
count = 0;
X = uint16(cat(1,lines{:}));
k1 = uint16(['M.S';
             '.A.';
             'M.S';]);
k1(k1==46) = 0;
      

k2 = uint16(['S.M';
             '.A.';
             'S.M';]);      
k2(k2==46) = 0;

k3 = uint16(['M.M';
             '.A.';
             'S.S';]);      
k3(k3==46) = 0;

k4 = uint16(['S.S';
             '.A.';
             'M.M';]);      
k4(k4==46) = 0;

count = count + sum(sum(29861 == conv2(X,k1,'same')));
count = count + sum(sum(29861 == conv2(X,k2,'same')));
count = count + sum(sum(29861 == conv2(X,k3,'same')));
count = count + sum(sum(29861 == conv2(X,k4,'same')));

count



