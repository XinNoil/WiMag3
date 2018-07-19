function [tmp_rssi,bssid_maps,bssid_indexs,RecordsNum]=process_wifi_old(filename,bssid_map)
[timestamp,BSSID,RSSI,~]=loadWiFiData(filename);
row=size(timestamp,1);
RecordsNum=max(timestamp)+1;
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