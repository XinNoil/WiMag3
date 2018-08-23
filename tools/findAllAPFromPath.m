function bssids = findAllAPFromPath(pathName, threshold)
% Date:     2018/08/22
% Auther:   S.E.Wei
% Function: ��ָ����·�����������ļ����ҳ�����RSSI>=threshold��AP��BSSID��
% input:    ·����RSSI��ֵ
% output:   BSSID�б�
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
