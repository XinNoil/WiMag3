function tmp_rssi=get_rssis_timesequence(timestamp,BSSID,RSSI,bssid_map,origin_timestamp,rssi_mask)
mask=timestamp<origin_timestamp;
timestamp=timestamp(mask);
BSSID=BSSID(mask);
RSSI=RSSI(mask);
RecordsNum=length(unique(timestamp));
ApNum=length(bssid_map);
if nargin<6
    rssi_mask=true(1,ApNum);
end
tmp_rssi=-100*ones(RecordsNum,ApNum);
row=size(timestamp,1);
for i=1:row
    if(isKey(bssid_map,BSSID(i)))
        tmp_rssi(timestamp(i)+1,bssid_map(cell2mat(BSSID(i))))=RSSI(i);
    end
end
tmp_rssi=tmp_rssi(:,rssi_mask);