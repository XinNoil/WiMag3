%% set_55_4_W
clear gridmesh;
vars.plot_gridmesh='1';
bs=0.60; %砖块大小
%% Area 1
area=1; % 区域编号
rows=13; % 砖块行数
columns=[2]; % 砖块列数
gap=[0]; % 列于列的间隙
margin=[0 0.41 0.63 0.825]; % 上下左右边界
origin=[0 0]; % 原点
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap); % 长
N=bs*rows+margin(1)+margin(2); % 宽

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+[0:bs:bs*rows-bs];
folderList=0:12;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'0');

setting=set_area(1,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;
%% Area 2
area=2; % 区域编号
rows=5; % 砖块行数
columns=[20]; % 砖块列数
gap=[0]; % 列于列的间隙
margin=[0.21 0 0.63 0.465]; % 上下左右边界
origin=[0 8.21]; % 原点
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap); % 长
N=bs*rows+margin(1)+margin(2); % 宽

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+[0:bs:bs*rows];
folderList=0:5;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'0');

setting=set_area(1,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;
%% Area 3
area=3; % 区域编号
rows=5; % 砖块行数
columns=[11]; % 砖块列数
gap=[0]; % 列于列的间隙
margin=[0 0.6 0 0.465]; % 上下左右边界
origin=[6.03 4.61]; % 原点
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap); % 长
N=bs*rows+margin(1)+margin(2); % 宽

row_index=create_row(bs,gap,margin(3),columns,true,false);
column_index=margin(2)+[0:bs:bs*rows-bs];
folderList=0:4;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'0');

setting=set_area(1,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;
%% Area 4
area=4; % 区域编号
rows=13; % 砖块行数
columns=[4]; % 砖块列数
gap=[0]; % 列于列的间隙
margin=[0 0.41 0.545 0]; % 上下左右边界
origin=[3.085 0]; % 原点
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap); % 长
N=bs*rows+margin(1)+margin(2); % 宽

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+[0:bs:bs*rows-bs];
folderList=0:12;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'0');

setting=set_area(1,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;
%% Area 5
area=5; % 区域编号
rows=5; % 砖块行数
columns=[11]; % 砖块列数
gap=[0]; % 列于列的间隙
margin=[0.315 0.41 0 0.465]; % 上下左右边界
origin=[6.03 0]; % 原点
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap); % 长
N=bs*rows+margin(1)+margin(2); % 宽

row_index=create_row(bs,gap,margin(3),columns,true,false);
column_index=margin(2)+[0:bs:bs*rows];
folderList=0:5;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'0');

setting=set_area(1,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;