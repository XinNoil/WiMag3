function gridmesh=create_gridmesh(row_index,column_index,folderList,type)
gridmesh.row_index=row_index;
gridmesh.column_index=column_index;
gridmesh.folderList=folderList;
gridmesh.folderNum=length(folderList);
gridmesh.fileNum=length(row_index);
gridmesh.num=length(0:gridmesh.folderNum-1)*gridmesh.fileNum;
gridmesh.type=type;
if (length(folderList)~=length(column_index))
    disp('文件夹数量不一致')
end