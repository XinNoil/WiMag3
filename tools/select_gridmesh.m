function BSSID_table=select_gridmesh(gridmesh,RSSI_threshold)
[~,~,~,folderNum,fileNum,~,~]=get_gridmesh(gridmesh);
BSSID_table=[];

for I=1:folderNum
    for J=0:fileNum-1
        filename=[num2str(I-1) '/W' num2str(J) '.txt'];
        [~,BSSID,RSSI,~]=loadWiFiData(filename);
        rssi_mask=RSSI>RSSI_threshold;
        BSSID_table=unique([BSSID_table;BSSID(rssi_mask)]);
    end
end
% 
% RSSI_table=zeros(length(BSSID_table),folderNum,fileNum);
% bssid_map=containers.Map(BSSID_table,num2cell(1:length(BSSID_table)));
% for I=1:folderNum
%     for J=0:fileNum-1
%         for 
%         RSSI_table(bssid_map())
%     end
% end