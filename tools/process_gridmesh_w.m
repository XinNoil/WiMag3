function [cdns,rssis,bssid_maps,bssid_indexs,wfiles,rssis_statics]=process_gridmesh_w(gridmesh,bssid_map,origin,head,tail,type)
% head,tail表示是否去掉头和尾 true表示去掉
i_area=gridmesh.i_area;
i_subarea=gridmesh.i_subarea;
[row_index,column_index,folderList,folderNum,fileNum,~,~]=get_gridmesh(gridmesh);
load glo.mat is_together
if(~is_together{i_area})
    folderList=0:folderNum-1;
end
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
switch type
    case '0'
        path=get_dpath(i_area,i_subarea,'long');
    case '1'
        path=get_dpath(i_area,i_subarea,'short');
end
disp(['WiFi     data:' path]);
c=1;
for I=1:folderNum
    for J=J_range
        cdns(c,1)=row_index(J+1);
        cdns(c,2)=column_index(I);
        filename=[path num2str(folderList(I)) '/W' num2str(J) '.txt'];
        wfiles{c}=filename;
        [timestamp,BSSID,RSSI,~]=loadWiFiData(filename);
        row=size(timestamp,1);
        RecordsNum=max(timestamp)+1;
        bssid=unique(BSSID);
        bssid_maps{c}=containers.Map(bssid,num2cell(1:length(bssid)));
        bssid_indexs{c}=zeros(1,length(bssid_maps{c}));
        for i=1:length(bssid_maps{c})
            if(isKey(bssid_map,bssid{i}))
                bssid_indexs{c}(i)=bssid_map(bssid{i});
            end
        end
        tmp_rssis=cell(1,ApNum);
        for i=1:row
            if(isKey(bssid_map,BSSID(i)))
                ti=bssid_map(BSSID{i});
                tmp_rssi=tmp_rssis{ti};
                tmp_rssi(end+1)=RSSI(i);
                tmp_rssis{ti}=tmp_rssi;
            end
        end
        rssi_mean=zeros(1,ApNum)-100;
        rssi_per=zeros(1,ApNum);
        rssi_max=zeros(1,ApNum);
        rssi_min=zeros(1,ApNum);
        rssi_var=zeros(1,ApNum);
        for i=1:ApNum
            rssi_per(i)=length(tmp_rssis{i})/RecordsNum;
            if(rssi_per(i)>0)
                rssi_mean(i)=mean(tmp_rssis{i});
                rssi_max(i)=max(tmp_rssis{i});
                rssi_min(i)=min(tmp_rssis{i});
                rssi_var(i)=var(tmp_rssis{i});
            end
        end
        rssis{c}=rssi_mean;
        rssis_statics(c).per=rssi_per;
        rssis_statics(c).max=rssi_max;
        rssis_statics(c).min=rssi_min;
        rssis_statics(c).var=rssi_var;
        c=c+1;
    end
end
cdns(:,1)=cdns(:,1)+origin(1);
cdns(:,2)=cdns(:,2)+origin(2);