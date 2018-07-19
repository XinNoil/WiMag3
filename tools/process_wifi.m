function [tmp_rssi,bssid_maps,bssid_indexs,RecordsNum]=process_wifi(filename,bssid_map,type,freq,test_time)
if nargin<3
    [tmp_rssi,bssid_maps,bssid_indexs,RecordsNum]=process_wifi_old(filename,bssid_map);
    return;
end
% �ο���ȡ2:end-test_time������ݣ����Ե�ȡend-test_time�������:end�������
[timestamp,BSSID,RSSI,~]=loadWiFiData(filename);
if freq>0
    if type=='0' %�ο���
        mask=timestamp>2*freq&timestamp<(max(timestamp)-test_time*freq+1);
    else
        mask=timestamp>max(timestamp)-test_time*freq;
    end
    timestamp=timestamp(mask);
    timestamp=timestamp-min(timestamp);
    BSSID=BSSID(mask);
    RSSI=RSSI(mask);
end
row=size(timestamp,1);
RecordsNum=length(unique(timestamp));
bssid=unique(BSSID);
bssid_maps=containers.Map(bssid,num2cell(1:length(bssid)));
bssid_indexs=zeros(1,length(bssid_maps));
ApNum=length(bssid_map);
tmp_rssi=-100*ones(RecordsNum,ApNum);
for i=1:length(bssid_maps)
    if(isKey(bssid_map,bssid{i}))
        bssid_indexs(i)=bssid_map(bssid{i});
    end
end
for i=1:row
    if(isKey(bssid_map,BSSID(i)))
        tmp_rssi(timestamp(i)+1,bssid_map(cell2mat(BSSID(i))))=RSSI(i);
    end
end