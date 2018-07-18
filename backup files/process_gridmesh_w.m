function [cdns,rssis,bssid_maps,bssid_indexs,wfiles,duties]=process_gridmesh_w(gridmesh,bssid_map,origin,head,tail,type)
% head,tail表示是否去掉头和尾 true表示去掉
i_area=gridmesh.i_area;
i_subarea=gridmesh.i_subarea;
[row_index,column_index,folderList,folderNum,fileNum,~,~]=get_gridmesh(gridmesh);
load glo.mat is_together
num=folderNum*fileNum;
J_range=0:fileNum-1;
if head
    num=num-folderNum;
    J_range=J_range(2:end);
end
if tail
    num=num-folderNum;
    J_range=J_range(1:end-1);
end
ApNum=length(bssid_map);
cdns=zeros(num,2);
rssis=cell(num,1);
bssid_maps=cell(num,1);
bssid_indexs=cell(num,1);
wfiles=cell(num,1);
duties=zeros(num,ApNum);
switch type
    case '0'
        path=get_dpath(i_area,i_subarea,'long');
        if(~is_together{i_area})
            folderList=0:folderNum-1;
        end
    case '1'
        path=get_dpath(i_area,i_subarea,'short');
end
c=1;
for I=1:folderNum
    disp(['WiFi     data:' path n2s(folderList(I))]);
%     for J=J_range
%         cdns(c,1)=row_index(J+1);
%         cdns(c,2)=column_index(I);
%         filename=[path num2str(folderList(I)) '/W' num2str(J) '.txt'];
%         wfiles{c}=filename;
%         [timestamp,BSSID,RSSI,~]=loadWiFiData(filename);
%         row=size(timestamp,1);
%         RecordsNum=max(timestamp)+1;
%         bssid=unique(BSSID);
%         bssid_maps{c}=containers.Map(bssid,num2cell(1:length(bssid)));
%         bssid_indexs{c}=zeros(1,length(bssid_maps{c}));
%         ApNum=length(bssid_map);
%         tmp_rssi=-100*ones(RecordsNum,ApNum);
%         for i=1:length(bssid_maps{c})
%             if(isKey(bssid_map,bssid{i}))
%                 bssid_indexs{c}(i)=bssid_map(bssid{i});
%             end
%         end
%         for i=1:row
%             if(isKey(bssid_map,BSSID(i)))
%                 tmp_rssi(timestamp(i)+1,bssid_map(cell2mat(BSSID(i))))=RSSI(i);
%             end
%         end
%         rssis{c}=mean(tmp_rssi);
%         duties(c,:)=get_duty(timestamp,BSSID,bssid_map);
%         c=c+1;
%     end
end
cdns(:,1)=cdns(:,1)+origin(1);
cdns(:,2)=cdns(:,2)+origin(2);