function [timestamp,BSSID,RSSI,Frequency] = loadWiFiDataTimeDown(filename, freq)
% 加载时间下采样后的WiFi数据
% 输入: 文件名，采样频率
%       采样频率为1表示每一个时刻采一个，2表示每两个时刻采一个，...
% 输出: 同loadWiFiData
% Author: S.E.Wei
    [timestamp,BSSID,RSSI,Frequency]=loadWiFiData(filename);    
    indexs = mod(timestamp,freq)==0;
    timestamp = timestamp(indexs);
    BSSID = BSSID(indexs);
    RSSI = RSSI(indexs);
    Frequency = Frequency(indexs);
end
