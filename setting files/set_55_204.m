vars.plot01='1';
bs=0.60; %砖块大小
% Area 1
area=1; % 区域编号
rows=18; % 砖块行数
columns=[4]; % 砖块列数
gap=[0]; % 列于列的间隙
margin=[0.725 1.09 1 0.6]; % 上下左右边界
origin=[0 0]; % 原点
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap); % 长
N=bs*rows+margin(1)+margin(2); % 宽

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+[bs/2:bs:bs*(rows-0.5)];
folderList=1:2:35;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+[0:2*bs:bs*rows];
folderList=0:4:36;
gridmesh(4)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+[bs:2*bs:bs*rows];
folderList=2:4:36;
gridmesh(2)=create_gridmesh(row_index,column_index,folderList,'0');

row_index=create_mid_row(bs,gap,margin(3)+bs/2,columns,false,false);
column_index=margin(2)+[0:bs:bs*rows];
folderList=37:55;
gridmesh(3)=create_gridmesh(row_index,column_index,folderList,'1');

setting=set_area(1,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;

% Area 2
area=2; % 区域编号
rows=9; % 砖块行数
columns=[13]; % 砖块列数
gap=[0]; % 列于列的间隙
margin=[0.6 1.09 0 0.78]; % 上下左右边界
origin=[3.4 0]; % 原点
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap); % 长
N=bs*rows+margin(1)+margin(2); % 宽

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+[bs/2:bs:bs*(rows-0.5)];
folderList=1:2:17;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+[0:2*bs:bs*rows];
folderList=0:4:18;
gridmesh(4)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+[bs:2*bs:bs*rows];
folderList=2:4:18;
gridmesh(2)=create_gridmesh(row_index,column_index,folderList,'0');

row_index=create_mid_row(bs,gap,margin(3)+bs/2,columns,false,false);
column_index=margin(2)+[0:bs:bs*rows];
folderList=19:28;
gridmesh(3)=create_gridmesh(row_index,column_index,folderList,'1');

setting=set_area(1,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;