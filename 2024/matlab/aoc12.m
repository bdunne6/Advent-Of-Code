clear; close all;
input_path = fullfile(get_input_root,'day_12.txt');
x = strip(read_txt(input_path));
lines = strsplit(x,crlf);
X = double(cat(1,lines{:}));

ux = unique(X(:));
X1 = zeros(size(X,1)+2,size(X,2)+2);
X1(2:end-1,2:end-1) = X;
X = X1;

k = [0,1,0;1,1,1;0,1,0];
%part 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P = 0;
for i1 = 1:numel(ux)
    Xi = ux(i1) == X;
    XiL = bwlabel(Xi,4);
    uxi = unique(XiL);
    uxi = uxi(2:end);
    for i2 = 1:numel(uxi)
        Xi2 = uxi(i2) == XiL;
        Xe = imdilate(Xi2,k);
        Xes = conv2(Xi2,k,'same');
        Xp = Xe-Xi2;
        Xp = Xp.*Xes;
        P = P + sum(Xp(:))*sum(Xi2(:));
    end
end
disp(P)

%part 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ksb = [1,0;0,0];
kd = {[1,0;0,1];[0,1;1,0]};
ks = [];
for i1 = 1:4
    ks = cat(1,ks,{rot90(ksb,i1)});
    ks = cat(1,ks,{rot90(~ksb,i1)});
end
P = 0;
for i1 = 1:numel(ux)
    Xi = ux(i1) == X;
    XiL = bwlabel(Xi,4);
    uxi = unique(XiL);
    uxi = uxi(2:end);
    for i2 = 1:numel(uxi)
        Xi2 = uxi(i2) == XiL;
        sides = 0;
        for i3 = 1:numel(kd)
            i_match = abs(normxcorr2(kd{i3},Xi2) - 1)<10*eps;
            sides = sides + 2*sum(i_match(:));
        end
        for i3 = 1:numel(ks)
            i_match = abs(normxcorr2(ks{i3},Xi2) - 1)<10*eps;
            sides = sides + 1*sum(i_match(:));
        end
        P = P + sides*sum(Xi2(:));
    end
end
disp(P)