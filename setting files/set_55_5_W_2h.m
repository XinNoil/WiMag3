%% set_55_5_W_2h
clear gridmesh;
vars.plot_gridmesh='1';
bs=0.8; %ש���С
%% Area 1
area=1; % ������
rows=3; % ש������
columns=[6 5 5]; % ש������
gap=[0.15 0.15 0]; % �����еļ�϶
margin=[0.12 0.12 0.12 0.56]; % �������ұ߽�
origin=[0 0]; % ԭ��
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap); % ��
N=bs*rows+margin(1)+margin(2); % ��

row_index=create_row(bs,gap,margin(3),columns,true,true);
column_index=margin(2)+[bs:bs:bs*(rows-0.5)];
folderList=0:1;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'0');

row_index=create_row(bs,gap,margin(3),columns,true,true);
column_index=margin(2)+[bs/2:bs:bs*(rows-0.5)];
folderList=0:2;
gridmesh(2)=create_gridmesh(row_index,column_index,folderList,'1');

setting=set_area(1,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;