function duties=get_duties_data(timestamp,BSSID,bssid_map,rssi_mask)
if nargin<4
    rssi_mask=true(1,ApNum);
end
duties=zeros(1,length(bssid_map));
BSSIDs=unique(BSSID);
max_num=max(timestamp)+1;
index_s=get_bssid_index(bssid_map,BSSIDs);
index=get_bssid_index(bssid_map,BSSID);%所有BSSID对应的编号
index_s(index_s==0)=[];%把是0的地方去掉
%求每个点上每个AP的duty
for j=1:length(index_s)
    index_sum=sum(index==index_s(j));%index_s()就是取对应的值
    duties(index_s(j))=index_sum/max_num;
end
duties=duties(:,rssi_mask);