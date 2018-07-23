function [timestamp,BSSID,RSSI,Frequency] = loadWiFiDataTimeDown(filename, freq)
% ����ʱ���²������WiFi����
% ����: �ļ���������Ƶ��
%       ����Ƶ��Ϊ1��ʾÿһ��ʱ�̲�һ����2��ʾÿ����ʱ�̲�һ����...
% ���: ͬloadWiFiData
% Author: S.E.Wei
    [timestamp,BSSID,RSSI,Frequency]=loadWiFiData(filename);    
    indexs = mod(timestamp,freq)==0;
    timestamp = timestamp(indexs);
    BSSID = BSSID(indexs);
    RSSI = RSSI(indexs);
    Frequency = Frequency(indexs);
end
