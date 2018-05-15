function [cdns,magnetics,rssis,bssid_maps,bssid_indexs,types]=process_gridmesh_t(paths,gridmesh,mag_cols,bssid_map,origin,head,tail)
% head,tail表示是否去掉头和尾 true表示去掉
[row_index,column_index,folderList,folderNum,fileNum,~,~]=get_gridmesh(gridmesh);
disp(['Magnetic data:' paths{1}]);
disp(['WiFi     data:' paths{2}]);
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
cdns=zeros(num,2);
magnetics=zeros(num,2);
rssis=cell(num,1);
bssid_maps=cell(num,1);
bssid_indexs=cell(num,1);
types=ones(num,1);
test_time=2;
c=1;
for I=1:folderNum
    for J=J_range
        cdns(c,1)=row_index(J+1);
        cdns(c,2)=column_index(I);
        % 地磁 
%         disp(['Test: ' n2s(cdns(c,1)) ' ' n2s(cdns(c,2)) ' ' num2str(folderList(I)) '/S' num2str(J) '.txt ' num2str(folderList(I)) '/W' num2str(J) '.txt']);
        filename=[paths{1} num2str(folderList(I)) '/S' num2str(J) '.txt'];
        tmp=load(filename);
        tmp=tmp(floor(size(tmp,1)/10):end-floor(size(tmp,1)/10),:);
        t=(tmp(:,2)-tmp(1,2))/10e8-test_time;
        [~,b]=min(t);
        tmp_magnetics=tmp(:,mag_cols);
        tmp_magnetics=[sqrt(tmp_magnetics(:,1).*tmp_magnetics(:,1)+tmp_magnetics(:,2).*tmp_magnetics(:,2)) tmp_magnetics(:,3)];%二维
        magnetics(c,:)=mean(tmp_magnetics(1:b,:),1);
        %{
        tmp_magnitudes=sqrt(magnetics(:,1).*magnetics(:,1)+magnetics(:,2).*magnetics(:,2));%地磁强度
        if(max(magnitudes)-min(magnitudes)>3)
            figure;
            plot(1:length(magnitudes),magnitudes);
            disp(['Folder: ' num2str(folderList(I)) '  File: ' num2str(J) '  ' num2str(max(magnitudes)-min(magnitudes))]);
        end
        magnitudes(c)=mean(tmp_magnitudes);
        %}
        % WiFi
        filename=[paths{2} num2str(folderList(I)) '/W' num2str(J) '.txt'];
        [timestamp,BSSID,RSSI,~]=loadWiFiData(filename);
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
        c=c+1;
    end
end
cdns(:,1)=cdns(:,1)+origin(1);
cdns(:,2)=cdns(:,2)+origin(2);