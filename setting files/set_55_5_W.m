%%
vars.plot01='1';
bs=0.8; %砖块大小
%% Area 1
area=1; % 区域编号
rows=3; % 砖块行数
columns=[6 5 5]; % 砖块列数
gap=[0.15 0.15 0]; % 列于列的间隙
margin=[0.12 0.12 0.12 0.56]; % 上下左右边界
origin=[0 0]; % 原点
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap); % 长
N=bs*rows+margin(1)+margin(2); % 宽

row_index=create_row(bs,gap,margin(3),columns,true,true);
column_index=margin(2)+[bs/2:bs:bs*(rows-0.5)];
folderList=0:2:4;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_row(bs,gap,margin(3),columns,true,true);
column_index=margin(2)+[bs:bs:bs*(rows-0.5)];
folderList=1:2:3;
gridmesh(2)=create_gridmesh(row_index,column_index,folderList,'0');

setting=set_area(1,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;

%% Area 2
area=2;
rows=2;
columns=[2 11 1 9];
gap=[1.13 1.4 1.32 0];
margin=[0.05 0.05 0.78 0.15];
origin=[10.64 -2.24];
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap);
N=bs*rows+margin(1)+margin(2);
in_gap{1}=[0.32 0.47];
in_gap{2}=[0.75 0.90];
in_gap{3}=[0.50 0.65];
in_gap{4}=[];

row_index=create_row_2(bs,gap,margin(3),columns,in_gap,false,false);
column_index=margin(2)+[bs/2:bs:bs*(rows-0.5)];
folderList=0:2:2;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_row_2(bs,gap,margin(3),columns,in_gap,false,false);
column_index=margin(2)+[bs:bs:bs*(rows-0.5)];
folderList=1:2:1;
gridmesh(2)=create_gridmesh(row_index,column_index,folderList,'0');

setting=set_area(area,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
setting.in_gap=in_gap;
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;

% Area 3
area=3;
rows=8;
columns=3;
gap=0;
margin=[0.83 0.05 0.52 0.67];
origin=[33.82 -2.24];
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap);
N=bs*rows+margin(1)+margin(2);

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+[bs/2:bs:bs*(rows-0.5)];
folderList=0:2:14;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+[bs:bs:bs*(rows)];
folderList=1:2:15;
gridmesh(2)=create_gridmesh(row_index,column_index,folderList,'0');

setting=set_area(area,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;

% Area 4
area=4;
rows=3;
columns=[6 7 6];
gap=[0.15 0.15 0];
margin=[0.12 0.12 0 0];
origin=[37.41 0];
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap);
N=bs*rows+margin(1)+margin(2);

row_index=create_row(bs,gap,margin(3),columns,false,true);
column_index=margin(2)+[bs/2:bs:bs*(rows-0.5)];
folderList=0:2:4;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_row(bs,gap,margin(3),columns,false,true);
column_index=margin(2)+[bs:bs:bs*(rows-0.5)];
folderList=1:2:3;
gridmesh(2)=create_gridmesh(row_index,column_index,folderList,'0');

setting=set_area(area,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;