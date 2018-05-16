vars.plot01='1';
bs=0.60; %ש���С
% Area 1
area=1; % ������
rows=1; % ש������
columns=6; % ש������
gap=[0]; % �����еļ�϶
margin=[0 1 1.95 1.2]; % �������ұ߽�
origin=[0 0]; % ԭ��
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap); % ��
N=bs*rows+margin(1)+margin(2); % ��

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+0;
folderList=0;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'0');

setting=set_area(1,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;

% Area 2
area=2; % ������
rows=3; % ש������
columns=7; % ש������
gap=[0]; % �����еļ�϶
margin=[0 0 1.95 0.6]; % �������ұ߽�
origin=[0 1.6]; % ԭ��
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap); % ��
N=bs*rows+margin(1)+margin(2); % ��

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+[0:bs:bs*rows];
folderList=0:3;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'0');

setting=set_area(1,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;

% Area 3
area=3; % ������
rows=4; % ש������
columns=6; % ש������
gap=[0]; % �����еļ�϶
margin=[1.2 0 2.55 0.6]; % �������ұ߽�
origin=[0 3.4]; % ԭ��
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap); % ��
N=bs*rows+margin(1)+margin(2); % ��

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+[bs:bs:bs*rows];
folderList=0:3;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'0');

setting=set_area(1,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;