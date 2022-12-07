input_path = fullfile(get_input_root,'day_7.txt');
x = read_txt(input_path);

lines = strsplit(x,'\r\n');

%% part 1
current_path = [];
file_list = [];
dir_list = [];
i1 = 1;
while (i1<= numel(lines))
    if startsWith(lines{i1},'$ cd')
        ndir = extractAfter(lines{i1},'$ cd ');
        if strcmp(ndir,'..')
            current_path = fileparts(current_path);
        else
            current_path = fullfile(current_path, ndir);
        end
        dir_list = cat(1,dir_list,{current_path});
    end
    if contains(lines{i1},'$ ls')
        ls_out = [];
        i1 = i1 + 1;
        while (i1<=numel(lines))&&(~contains(lines{i1},'$'))
            ls_out = cat(1,ls_out,lines(i1));
            i1 = i1 + 1;
        end
        i1 = i1 - 1;
        for i2 = 1:numel(ls_out)
            ls_parts = strsplit(ls_out{i2},' ');
            if ~isnan(str2double(ls_parts{1}))
                current_file = fullfile(current_path,ls_parts{2});
                file_list = cat(1,file_list,{current_file,current_path,str2double(ls_parts{1})});
            end
        end
    end
    i1 = i1 + 1;
end

udir = unique(cat(1,file_list(:,2),dir_list));
dir_sizes = nan(size(udir));
for i1 = 1:numel(udir)
    i_dir = startsWith(file_list(:,2),udir{i1});
    dir_sizes(i1) = sum([file_list{i_dir,3}]);
end

p1 = sum(dir_sizes(dir_sizes<=100000));
disp(p1);

%% part 2 
disk_space = 70000000;
used_space = sum([file_list{:,3}]);
free_space = disk_space - used_space;
minimum_deletion = 30000000 - free_space;

p2 = min(dir_sizes(dir_sizes >= minimum_deletion));
disp(p2)


