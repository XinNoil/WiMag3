%%
vars.plot01='1';
bs=0.8; %砖块大小
%% Area 1
area=1; % 区域编号
rows=3; % 砖块行数
columns=[6]; % 砖块列数
gap=[0]; % 列于列的间隙
margin=[0.12 0.12 0.12 0]; % 上下左右边界
origin=[0 0]; % 原点
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap); % 长
N=bs*rows+margin(1)+margin(2); % 宽

row_index=create_row(bs,gap,margin(3),columns,true,false);
column_index=margin(2)+[bs/2:bs:bs*(rows-0.5)];
folderList=0:1:2;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_row(bs,gap,margin(3),columns,true,false);
column_index=margin(2)+[bs:bs:bs*(rows-0.5)];
folderList=0:1:1;
gridmesh(2)=create_gridmesh(row_index,column_index,folderList,'0');

setting=set_area(1,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;