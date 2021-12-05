function [txt] = read_txt(file_path)
%READ_TXT Summary of this function goes here
%   Detailed explanation goes here
fid = fopen(file_path);
txt = fread(fid,'char=>char')';
fclose(fid);
end

