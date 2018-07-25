function bssids = findAllAPFromPath(pathName, threshold)
% 从指定的路径遍历所有文件，找出所有RSSI>=threshold的AP的BSSID
% 输入: 路径，RSSI阈值
% 输出: BSSID列表
% Author: S.E.Wei
if pathName(length(pathName))~='\'
    pathName = [pathName '\'];
end
subdir = dir(pathName);
bssids = {};
for m=1:length(subdir)
    if(isequal(subdir(m).name, '.')||isequal(subdir(m).name, '..'))
        continue;
    elseif subdir(m).isdir
        bssids = unique(union(bssids, findAllAPFromPath([pathName subdir(m).name '\'], threshold)));
    elseif subdir(m).name(1)=='W'
        [~,bssids_tmp,rssi,~] = loadWiFiData([pathName subdir(m).name]);
        indexs = rssi>=threshold;
        bssids = unique(union(bssids, bssids_tmp(indexs)));
    end
end
end
