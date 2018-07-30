function duties=get_duties_data(timestamp,BSSID,bssid_map,rssi_mask)
if nargin<4
    rssi_mask=true(1,ApNum);
end
duties=zeros(1,length(bssid_map));
BSSIDs=unique(BSSID);
max_num=max(timestamp)+1;
index_s=get_bssid_index(bssid_map,BSSIDs);
index=get_bssid_index(bssid_map,BSSID);%����BSSID��Ӧ�ı��
index_s(index_s==0)=[];%����0�ĵط�ȥ��
%��ÿ������ÿ��AP��duty
for j=1:length(index_s)
    index_sum=sum(index==index_s(j));%index_s()����ȡ��Ӧ��ֵ
    duties(index_s(j))=index_sum/max_num;
end
duties=duties(:,rssi_mask);