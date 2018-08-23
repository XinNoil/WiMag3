%% set_55_4_W
clear gridmesh;
vars.plot_gridmesh='1';
bs=0.60; %ש���С
%% Area 1
area=1; % ������
rows=13; % ש������
columns=[2]; % ש������
gap=[0]; % �����еļ�϶
margin=[0 0.41 0.63 0.825]; % �������ұ߽�
origin=[0 0]; % ԭ��
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap); % ��
N=bs*rows+margin(1)+margin(2); % ��

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+[0:bs:bs*rows-bs];
folderList=0:12;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'0');

setting=set_area(1,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;
%% Area 2
area=2; % ������
rows=5; % ש������
columns=[20]; % ש������
gap=[0]; % �����еļ�϶
margin=[0.21 0 0.63 0.465]; % �������ұ߽�
origin=[0 8.21]; % ԭ��
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap); % ��
N=bs*rows+margin(1)+margin(2); % ��

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+[0:bs:bs*rows];
folderList=0:5;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'0');

setting=set_area(1,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;
%% Area 3
area=3; % ������
rows=5; % ש������
columns=[11]; % ש������
gap=[0]; % �����еļ�϶
margin=[0 0.6 0 0.465]; % �������ұ߽�
origin=[6.03 4.61]; % ԭ��
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap); % ��
N=bs*rows+margin(1)+margin(2); % ��

row_index=create_row(bs,gap,margin(3),columns,true,false);
column_index=margin(2)+[0:bs:bs*rows-bs];
folderList=0:4;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'0');

setting=set_area(1,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;
%% Area 4
area=4; % ������
rows=13; % ש������
columns=[4]; % ש������
gap=[0]; % �����еļ�϶
margin=[0 0.41 0.545 0]; % �������ұ߽�
origin=[3.085 0]; % ԭ��
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap); % ��
N=bs*rows+margin(1)+margin(2); % ��

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+[0:bs:bs*rows-bs];
folderList=0:12;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'0');

setting=set_area(1,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;
%% Area 5
area=5; % ������
rows=5; % ש������
columns=[11]; % ש������
gap=[0]; % �����еļ�϶
margin=[0.315 0.41 0 0.465]; % �������ұ߽�
origin=[6.03 0]; % ԭ��
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap); % ��
N=bs*rows+margin(1)+margin(2); % ��

row_index=create_row(bs,gap,margin(3),columns,true,false);
column_index=margin(2)+[0:bs:bs*rows];
folderList=0:5;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'0');

setting=set_area(1,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;