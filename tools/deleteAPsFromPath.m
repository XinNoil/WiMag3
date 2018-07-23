function deleteAPsFromPath(pathName, bssids)
% 从指定的路径遍历所有文件，删除文件中包含bssids列表中bssid的行
% 输入: 路径，要删除的bssid列表
% 输出: 无
% Example:
% dir_ref = 'original_data\55-4-W\long';
% dir_test = 'original_data\55-4-W\short';
% bssid_ref = FindAllAPFromDir(dir_ref, -80);
% bssid_test = FindAllAPFromDir(dir_test, -80);
% bssid_intersect = unique(intersect(bssid_ref, bssid_test));
% bssidr_ref = setdiff(bssid_ref, bssid_intersect);
% bssidr_test = setdiff(bssid_test, bssid_intersect);
% deleteAPsFromDir(dir_ref, bssidr_ref);
% deleteAPsFromDir(dir_test, bssidr_test);
if pathName(length(pathName))~='\'
    pathName = [pathName '\'];
end
subdir = dir(pathName);
for m=1:length(subdir)
    if(isequal(subdir(m).name, '.')||isequal(subdir(m).name, '..'))
        continue;
    elseif subdir(m).isdir
        deleteRm([pathName subdir(m).name '\'], bssids);
    elseif subdir(m).name(1)=='W'
        deleteAPsFromFile([pathName subdir(m).name], bssids);
    end
end
end

function flag = deleteAPsFromFile(filename, bssids)
fid = fopen(filename, 'r');
fidt = fopen('tmpfile.tmpfile', 'w');
flag = 0;
while ~feof(fid)
    aline=fgetl(fid);
    bssid = regexp(aline, '[0-9a-fA-F:]{17}', 'match');
    if numel(bssid)==1
        if ~ismember(bssid{1}, bssids)
            fprintf(fidt,'%s\n',aline);
        else
%         aline = regexprep(aline,['(\d+ +[0-9a-fA-F:]{17} +)[-0-9]+( +\d+)'],
%         '$1-100$2'); %若改成-100加上此行
%         fprintf(fidt,'%s\n',aline); %若改成-100加上此行
            flag = 1;
        end
    end
end
fclose(fid);
fclose(fidt);
movefile('tmpfile.tmpfile',filename);
end
