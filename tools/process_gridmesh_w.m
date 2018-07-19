function [cdns,rssis,bssid_maps,bssid_indexs,wfiles,duties]=process_gridmesh_w(gridmesh,bssid_map,origin,head,tail,type,check_file_mode)
% head,tail表示是否去掉头和尾 true表示去掉
i_area=gridmesh.i_area;
i_subarea=gridmesh.i_subarea;
[row_index,column_index,folderList,folderNum,fileNum,~,~]=get_gridmesh(gridmesh);
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
load glo.mat
switch type
    case '0'
        path=get_dpath(i_area,i_subarea,'long');
        freq=fps_rssi_freq(i_area);
    case '1'
        path=get_dpath(i_area,i_subarea,'short');
        freq=tds_rssi_freq(i_area);
end
test_time=1;
c=1;
for I=1:folderNum
    disp(['WiFi     data:' path n2s(folderList(I))]);
    for J=J_range
        filename=[path num2str(folderList(I)) '/W' num2str(J) '.txt'];
        if ~exist(filename,'file')
            disp(['file not found:' filename]);
            pause;
        end
        wfiles{c}=filename;
        cdns(c,1)=row_index(J+1);
        cdns(c,2)=column_index(I);
        if ~check_file_mode
            [timestamp,BSSID,RSSI,~]=loadWiFiData(filename);
            if freq>0
                mask=true(size(timestamp));
                if type=='0'&&max(timestamp)>2*freq %参考点
                    mask=timestamp>2*freq&timestamp<(max(timestamp)-test_time*freq+1);
                elseif type=='1'
                    mask=timestamp>max(timestamp)-test_time*freq;
                end
                timestamp=timestamp(mask);
                timestamp=timestamp-min(timestamp);
                BSSID=BSSID(mask);
                RSSI=RSSI(mask);
            end
            row=size(timestamp,1);
            RecordsNum=max(timestamp)+1;
            bssid=unique(BSSID);
            bssid_maps{c}=containers.Map(bssid,num2cell(1:length(bssid)));
            bssid_indexs{c}=zeros(1,length(bssid_maps{c}));
            ApNum=length(bssid_map);
            tmp_rssi=-100*ones(RecordsNum,ApNum);
            for i=1:length(bssid_maps{c})
                if(isKey(bssid_map,bssid{i}))
                    bssid_indexs{c}(i)=bssid_map(bssid{i});
                end
            end
            for i=1:row
                if(isKey(bssid_map,BSSID(i)))
                    tmp_rssi(timestamp(i)+1,bssid_map(cell2mat(BSSID(i))))=RSSI(i);
                end
            end
            rssis{c}=mean(tmp_rssi);
            duties(c,:)=get_duty(timestamp,BSSID,bssid_map);
        end
        c=c+1;
    end
end
cdns(:,1)=cdns(:,1)+origin(1);
cdns(:,2)=cdns(:,2)+origin(2);