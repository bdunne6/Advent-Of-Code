fid = fopen(fullfile('inputs','day 2.txt'));
txt = fread(fid,'char=>char')';
fclose(fid);
lines = strsplit(txt,newline);
flines = lines(contains(lines,"forward"));
dlines = lines(contains(lines,"down"));
ulines = lines(contains(lines,"up"));
f = cellfun(@(x) (str2double(extractAfter(x,' '))),flines);
d = cellfun(@(x) (str2double(extractAfter(x,' '))),dlines);
u = cellfun(@(x) (str2double(extractAfter(x,' '))),ulines);
y = sum(d) + sum(-u);
x = sum(f);

%part 1
y*x

aim = 0;
h = 0;
d = 0;
for i1 = 1:numel(lines)
    x = str2double(extractAfter(lines{i1},' '));
    if contains(lines{i1},"down")
        %d = d + x;
        aim = aim + x;
    end
    
    if contains(lines{i1},"up")
        %d = d - x;
        aim = aim - x;
    end
    
    if contains(lines{i1},"forward")
        h = h + x;
        d = d  + aim*x;
    end
end

%part 2
int32(h*d)