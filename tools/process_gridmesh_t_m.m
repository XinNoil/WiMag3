function [cdns,magnetics,types]=process_gridmesh_t_m(paths,gridmesh,mag_cols,origin)
[row_index,column_index,folderList,folderNum,fileNum,~,~]=get_gridmesh(gridmesh);
disp(['Magnetic data:' paths{1}]);
num=folderNum*(fileNum-2);
cdns=zeros(num,2);
magnetics=zeros(num,2);
types=ones(num,1);
test_time=2;
c=1;
for I=1:folderNum
    for J=1:fileNum-2
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
        c=c+1;
    end
end
cdns(:,1)=cdns(:,1)+origin(1);
cdns(:,2)=cdns(:,2)+origin(2);