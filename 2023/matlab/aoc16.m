clear; close all;
input_path = fullfile(get_input_root,'day_16.txt');
txt = read_txt(input_path);
%parse input
lines = strsplit(txt,crlf);
x = cat(1,lines{:});

%% part 1
b = {[1,0;0,1]};
p1 = count_energized(x,b,0);
disp(p1);

%% part 2
%build starting states
bs = [];
for i1 = 1:size(x,1)
    bs = cat(1,bs,{[i1,0;0,1]});
end
for i1 = 1:size(x,1)
    bs = cat(1,bs,{[i1,size(x,2)+1;0,-1]});
end
for i1 = 1:size(x,2)
    bs = cat(1,bs,{[0,i1;1,0]});
end
for i1 = 1:size(x,2)
    bs = cat(1,bs,{[size(x,1)+1,i1;-1,0]});
end

%run through all starting states
e = zeros(size(bs));
for i1 = 1:numel(bs)
    b0 = bs(i1);
    e(i1) = count_energized(x,b0,0);
end
p2 = max(e);
disp(p2);


function y = count_energized(x,b,p)
%b_past = containers.Map(1,1);%remove beam states that already existed
b_past = false([110,110,3,3]);
%remove(b_past,1);
xe = zeros(size(x));
while ~isempty(b)
    i_rem = cellfun(@isempty,b);
    b(i_rem) = [];
    for i2 = 1:numel(b)
        b1 = b{i2};
        d = b1(2,:);
        if b1(1,2)>0&&b1(1,1)>0&&b1(1,1)<=size(x,1)&&b1(1,2)<=size(x,2)
            xe(b1(1,1),b1(1,2)) = 1;
        end
        pn = sum(b1,1);
        if (pn(1)<1)||(pn(1)>size(x,1))||(pn(2)<1)||(pn(2)>size(x,2))
            b{i2} = [];
            continue;
        end
        
        ne = x(pn(1),pn(2));
        b1(1,:) = b1(1,:)+d;
        b{i2} = b1;
        if (ne == '|'&&abs(d(2)) == 1)||(ne == '-'&&abs(d(1)) == 1)
            d1 = fliplr(b1(2,:));
            b{i2} = [b1(1,:);d1];
            
            bt = [b1(1,:);-d1];
            c_key = get_key(bt);
            if ~b_past(c_key)
                b{end+1} = [b1(1,:);-d1];
                b_past(c_key) = true;
            end
        elseif ne ==  '\'
            b1(2,:) = fliplr(d);
            b{i2} = b1;
        elseif ne ==  '/'
            b1(2,:) = -fliplr(d);
            b{i2} = b1;
        end
    end
    if isempty(b)
        break;
    end
    if ~isempty(b{i2})
        c_key = get_key(b{i2});
        if b_past(c_key)
            b{i2} = [];
        else
            b_past(c_key) = true;
        end
    end
    %plot
    if p
        bm = xe;
        for i2 = 1:numel(b)
            if ~isempty(b{i2})
                bm(b{i2}(1,1),b{i2}(1,2)) = 2;
            end
        end
        figure(101)
        imagesc(bm);
        caxis([0 2])
        drawnow();
    end
end
y= sum(xe(:));
end

function k = get_key(bt)
%k = num2str(bt(:)');
i1 = sub2ind([110,110,3,3],bt(1,1),bt(1,2),bt(2,1)+2,bt(2,2)+2);
% i2 = sub2ind([110,110],bt(2,1)+2,bt(2,2)+2);
% k = i1+1i*i2;
k = i1;
end
