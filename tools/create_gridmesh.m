function gridmesh=create_gridmesh(row_index,column_index,folderList,type)
% Date:     2018/08/22
% Auther:   WJK
% Function: This function is used for creating a new gridmesh.
%           �ú������ڴ���һ���µ�gridmesh��
% Contact:  jiankunwang@tju.edu.cn
gridmesh.row_index=row_index;
gridmesh.column_index=column_index;
gridmesh.folderList=folderList;
gridmesh.folderNum=length(folderList);
gridmesh.fileNum=length(row_index);
gridmesh.num=length(0:gridmesh.folderNum-1)*gridmesh.fileNum;
gridmesh.type=type;
if (length(folderList)~=length(column_index))
    disp('�ļ���������һ��')
end