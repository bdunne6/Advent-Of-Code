input_path = fullfile(get_input_root,'day_18.txt');
x = readmatrix(input_path);

nb = 2;
x = x + nb;
d = zeros(max(x(:,1))+nb,max(x(:,2))+nb,max(x(:,3))+nb);
for i1 = 1:size(x)
   d(x(i1,1),x(i1,2),x(i1,3)) = 1;
end
k = zeros(3,3,3);
k(2,2,:) = 1;
k(:,2,2) = 1;
k(2,:,2) = 1;
k(2,2,2) = 0;

%% part 1
p1 = sum(convn(~d,k,'same').*d,'all');
disp(p1)

%% part 2
p2 = sum(convn(~imfill(d),k,'same').*d,'all');
disp(p2)