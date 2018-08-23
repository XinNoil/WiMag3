%% set_55_4_W
clear gridmesh;
vars.plot_gridmesh='1';
bs=0.8; %砖块大小
%% Area 1
area=1; % 区域编号
rows=3; % 砖块行数
columns=[4 4 5]; % 砖块列数
gap=[0.15 0.15 0]; % 列于列的间隙
margin=[0.12 0.12 0.10 0.15]; % 上下左右边界
origin=[0 0]; % 原点
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap); % 长
N=bs*rows+margin(1)+margin(2); % 宽

row_index=create_row(bs,gap,margin(3),columns,true,false);%测试点-拉尺子
column_index=margin(2)+[bs/2:bs:bs*(rows-0.5)];
folderList=0:2:4;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_row(bs,gap,margin(3),columns,true,false);%参考点
column_index=margin(2)+[bs:bs:bs*(rows-0.5)];
folderList=0:1:1;
gridmesh(2)=create_gridmesh(row_index,column_index,folderList,'0');

row_index=create_mid_row(bs,gap,margin(3)+bs/2,columns,true,false);%测试点-中间点
column_index=margin(2)+[bs:bs:bs*(rows-0.5)];
folderList=1:2:3;
gridmesh(3)=create_gridmesh(row_index,column_index,folderList,'1');

setting=set_area(1,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;


%% Area 2
area=2;
rows=6;
columns=[5 6 5 5 5 5];
gap=[0.15 0.15 0.15 0.15 0.15 0];
margin=[0.12 0 0.43 0.50];
origin=[10.94 -2.27];
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap);
N=bs*rows+margin(1)+margin(2);

row_index=create_row(bs,gap,margin(3),columns,false,false);%测试点-拉尺子
column_index=margin(2)+[bs/2:bs:bs*(rows-0.5)];
folderList=0:2:10;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+[bs:bs:bs*(rows-0.5)];
folderList=0:1:4;
gridmesh(2)=create_gridmesh(row_index,column_index,folderList,'0');

row_index=create_mid_row(bs,gap,margin(3)+bs/2,columns,false,false);
column_index=margin(2)+[bs:bs:bs*(rows-0.5)];
folderList=1:2:9;
gridmesh(3)=create_gridmesh(row_index,column_index,folderList,'1');

setting=set_area(area,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;

%% Area 3
area=3;
rows=3;
columns=[6 5 5 5];
gap=[0.15 0.15 0.15 0];
margin=[0.12 0.12 0.15 0.12];
origin=[37.45 0];
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap);
N=bs*rows+margin(1)+margin(2);

row_index=create_row(bs,gap,margin(3),columns,false,true);
column_index=margin(2)+[bs/2:bs:bs*(rows-0.5)];
folderList=0:2:4;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_row(bs,gap,margin(3),columns,false,true);
column_index=margin(2)+[bs:bs:bs*(rows-0.5)];
folderList=0:1:1;
gridmesh(2)=create_gridmesh(row_index,column_index,folderList,'0');

row_index=create_mid_row(bs,gap,margin(3)+bs/2,columns,false,false);
column_index=margin(2)+[bs:bs:bs*(rows-0.5)];
folderList=1:2:3;
gridmesh(3)=create_gridmesh(row_index,column_index,folderList,'1');

setting=set_area(area,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;