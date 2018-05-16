bs=1.2; %ש���С
% Area 1
area=1; % ������
rows=3; % ש������
columns=[9]; % ש������
gap=0; % �����еļ�϶
margin=[0.53 0.62 0 0]; % �������ұ߽�
origin=[0 0]; % ԭ��
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap); % ��
N=bs*rows+margin(1)+margin(2); % ��

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+[0:bs:bs*(rows)];
folderList=0:2:6;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+[bs/2:bs:bs*(rows-0.5)];
folderList=1:2:5;
gridmesh(2)=create_gridmesh(row_index,column_index,folderList,'0');

row_index=create_mid_row(bs,gap,margin(3)+bs/2,columns,false,false);
column_index=margin(2)+[0:bs:bs*(rows)];
folderList=7:10;
gridmesh(3)=create_gridmesh(row_index,column_index,folderList,'1');

setting=set_area(1,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{1}=setting;

% Area 2
area=2;
rows=20;
columns=[3];
gap=0;
margin=[0.53 0.20 0.505 1.125];
origin=[10.295 -19.98];
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap);
N=bs*rows+margin(1)+margin(2);

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+[0:bs:bs*(rows)];
folderList=0:2:40;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+[bs/2:bs:bs*(rows-0.5)];
folderList=1:2:40;
gridmesh(2)=create_gridmesh(row_index,column_index,folderList,'0');

row_index=create_mid_row(bs,gap,margin(3)+bs/2,columns,false,false);
column_index=margin(2)+[0:bs:bs*(rows)];
folderList=41:61;
gridmesh(3)=create_gridmesh(row_index,column_index,folderList,'1');

setting=set_area(area,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{2}=setting;
