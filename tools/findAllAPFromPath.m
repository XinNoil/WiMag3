function bssids = findAllAPFromPath(pathName, threshold)
% ��ָ����·�����������ļ����ҳ�����RSSI>=threshold��AP��BSSID
% ����: ·����RSSI��ֵ
% ���: BSSID�б�
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
