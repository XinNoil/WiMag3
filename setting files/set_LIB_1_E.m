vars.plot01='1';
bs=0.75; %砖块大小
%% Area 1
area=1; % 区域编号
rows=2; % 砖块行数
columns=[40]; % 砖块列数
gap=[0]; % 列于列的间隙
margin=[0.215 0.73 0 0.73]; % 上下左右边界
origin=[0 0]; % 原点
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap); % 长
N=bs*rows+margin(1)+margin(2); % 宽

row_index=create_row(bs,gap,margin(3),columns,false,true);
column_index=margin(2)+[-bs/2:bs:bs*(rows-0.5)];
folderList=0:2:4;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_row(bs,gap,margin(3),columns,false,true);
column_index=margin(2)+[0:bs:bs*(rows-0.5)];
folderList=0:1:1;
gridmesh(2)=create_gridmesh(row_index,column_index,folderList,'0');

row_index=create_mid_row(bs,gap,margin(3)+bs/2,columns,false,true);
column_index=margin(2)+[0:bs:bs*(rows-0.5)];
folderList=6:7;%文件夹数量不对
gridmesh(3)=create_gridmesh(row_index,column_index,folderList,'1');

setting=set_area(1,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;

%% Area 2
area=2; % 区域编号
rows=11; % 砖块行数
columns=[4]; % 砖块列数
gap=[0]; % 列于列的间隙
margin=[0.3 0 0 0]; % 上下左右边界
origin=[12.75 2.25]; % 原点
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap); % 长
N=bs*rows+margin(1)+margin(2); % 宽

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+[bs/2:bs:bs*(rows-0.5)];
folderList=1:2:21;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+[0:bs:bs*rows];
folderList=0:1:11;
gridmesh(2)=create_gridmesh(row_index,column_index,folderList,'0');

row_index=create_mid_row(bs,gap,margin(3)+bs/2,columns,false,false);
column_index=margin(2)+[0:bs:bs*rows];
folderList=23:34;
gridmesh(3)=create_gridmesh(row_index,column_index,folderList,'1');

setting=set_area(1,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;

%% Area 3
area=3; % 区域编号
rows=9; % 砖块行数
columns=[18]; % 砖块列数
gap=[0]; % 列于列的间隙
margin=[0.3 0 0 0.75]; % 上下左右边界
origin=[15.75 3.75]; % 原点
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap); % 长
N=bs*rows+margin(1)+margin(2); % 宽

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+[bs/2:bs:bs*(rows-0.5)];
folderList=1:2:17;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+[0:bs:bs*rows];
folderList=0:1:9;
gridmesh(2)=create_gridmesh(row_index,column_index,folderList,'0');

row_index=create_mid_row(bs,gap,margin(3)+bs/2,columns,false,false);
column_index=margin(2)+[0:bs:bs*rows];
folderList=19:28;
gridmesh(3)=create_gridmesh(row_index,column_index,folderList,'1');

setting=set_area(1,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;