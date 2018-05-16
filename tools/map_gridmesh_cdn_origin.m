function [wfiles,sfiles]=map_gridmesh_cdn_origin(path,gridmesh)
[~,~,folderList,folderNum,fileNum,~,~]=get_gridmesh(gridmesh);
num=folderNum*fileNum;
J_range=0:fileNum-1;
wfiles=cell(num,1);
sfiles=cell(num,1);
c=1;
for I=1:folderNum
    for J=J_range
        filename=[path num2str(folderList(I)) '/W' num2str(J) '.txt'];
        wfiles{c}=filename;
        filename=[path num2str(folderList(I)) '/S' num2str(J) '.txt'];
        sfiles{c}=filename;
        c=c+1;
    end
end