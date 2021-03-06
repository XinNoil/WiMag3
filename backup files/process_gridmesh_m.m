function [cdns,magnetics,types,sfiles]=process_gridmesh_m(gridmesh,mag_cols,origin,head,tail,type)
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
cdns=zeros(num,2);
magnetics=zeros(num,2);
sfiles=cell(num,1);
switch type
    case '0'
        path=get_dpath(i_area,i_subarea,'long');
        if ~exist([path num2str(folderList(1)) '/S' num2str(J_range(1)) '.txt'],'file')
            path=get_dpath(i_area,i_subarea,'short');
        end
        types=zeros(num,1);
    case '1'
        path=get_dpath(i_area,i_subarea,'short');
        types=ones(num,1);
end
test_time=1;
c=1;
for I=1:folderNum
    disp(['Magnetic data:' path n2s(folderList(I))]);
%     for J=J_range
%         cdns(c,1)=row_index(J+1);
%         cdns(c,2)=column_index(I);
%         filename=[path num2str(folderList(I)) '/S' num2str(J) '.txt'];
%         sfiles{c}=filename;
%         tmp=load(filename);
%         tmp=tmp(floor(size(tmp,1)/10):end-floor(size(tmp,1)/10),:);
%         t=(tmp(:,2)-tmp(1,2))/1e9-test_time;
%         [~,b]=min(abs(t));
%         tmp_magnetics=tmp(:,mag_cols);
%         tmp_magnetics=[sqrt(tmp_magnetics(:,1).*tmp_magnetics(:,1)+tmp_magnetics(:,2).*tmp_magnetics(:,2)) tmp_magnetics(:,3)];%二维
%         switch type
%             case '0'
%                 magnetics(c,:)=mean(tmp_magnetics(b:end,:),1);
%             case '1'
%                 magnetics(c,:)=mean(tmp_magnetics(1:b,:),1);
%         end
%         c=c+1;
%     end
end
cdns(:,1)=cdns(:,1)+origin(1);
cdns(:,2)=cdns(:,2)+origin(2);