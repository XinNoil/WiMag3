vars.plot01='1';
bs=0.8; %ש���С
%% Area 1
area=1; % ������
rows=3; % ש������
columns=[4 4 5]; % ש������
gap=[0.15 0.15 0]; % �����еļ�϶
margin=[0.12 0.12 0.10 0.15]; % �������ұ߽�
origin=[0 0]; % ԭ��
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap); % ��
N=bs*rows+margin(1)+margin(2); % ��
row_index=create_row(bs,gap,margin(3),columns,true,false);
column_index=margin(2)+[bs/2:bs:bs*(rows-0.5)];
folderList=0:2:4;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_row(bs,gap,margin(3),columns,true,false);
column_index=margin(2)+[bs:bs:bs*(rows-0.5)];
folderList=1:2:3;
gridmesh(2)=create_gridmesh(row_index,column_index,folderList,'0');

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

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+[bs/2:bs:bs*(rows-0.5)];
folderList=0:2:10;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_row(bs,gap,margin(3),columns,false,false);
column_index=margin(2)+[bs:bs:bs*(rows-0.5)];
folderList=1:2:10;
gridmesh(2)=create_gridmesh(row_index,column_index,folderList,'0');

setting=set_area(area,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;

%% Area 3
area=3;
rows=3;
columns=[6 5 5 5];
gap=[0.15 0.15 0.15 0];
margin=[0.12 0.12 0.15 0.23];
origin=[37.45 0];
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

%% Area 4
area=4; % ������
rows=3; % ש������
columns=[5 5 6 6]; % ש������
gap=[0.15 0.15 0.15 0]; % �����еļ�϶
margin=[0.13 0.115 0 0.5]; % �������ұ߽�
origin=[55.08 0]; % ԭ��
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap); % ��
N=bs*rows+margin(1)+margin(2); % ��

row_index=create_row(bs,gap,margin(3),columns,true,false);%���Ե�
column_index=margin(2)+[bs/2:bs:bs*(rows-0.5)];
folderList=0:2:4;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_mid_row(bs,gap,margin(3)+bs/2,columns,true,false);%���Ե�
column_index=margin(2)+[bs:bs:bs*(rows-0.5)];
folderList=1:2:3;
gridmesh(2)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_row(bs,gap,margin(3),columns,true,false);%�ο���
column_index=margin(2)+[bs:bs:bs*(rows-0.5)];
folderList=0:1:1;
gridmesh(3)=create_gridmesh(row_index,column_index,folderList,'0');

setting=set_area(1,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;

%% Area 5
area=5;
rows=8;
columns=[3];
gap=[0];
margin=[0.22 0.775 0 0.43];
origin=[73.63 -2.27];
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap);
N=bs*rows+margin(1)+margin(2);

row_index=create_row(bs,gap,margin(3),columns,false,false);%�����ӵĲ��Ե�
column_index=margin(2)+[bs/2:bs:bs*(rows-0.5)];
folderList=0:2:14;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_mid_row(bs,gap,margin(3)+bs/2,columns,false,false);%���Ե�-�м��
column_index=margin(2)+[bs:bs:bs*(rows-0.5)];
folderList=1:2:13;
gridmesh(2)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_row(bs,gap,margin(3),columns,false,false);%�ο���
column_index=margin(2)+[bs:bs:bs*(rows-0.5)];
folderList=0:1:6;
gridmesh(3)=create_gridmesh(row_index,column_index,folderList,'0');

setting=set_area(area,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;

%% Area 6
area=6;
rows=5;
columns=[1 6 5 5 5 3];
gap=[0.15 0.15 0.15 0.15 0.15 0];
margin=[0.13 0.775 0.37 0.80];
origin=[76.46 -2.27];
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap);
N=bs*rows+margin(1)+margin(2);

row_index=create_row(bs,gap,margin(3),columns,false,false);%�����ӵĲ��Ե�
column_index=margin(2)+[bs/2:bs:bs*(rows-0.5)];
folderList=0:2:8;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_mid_row(bs,gap,margin(3)+bs/2,columns,false,false);%���Ե�-�м��
column_index=margin(2)+[bs:bs:bs*(rows-0.5)];
folderList=1:2:7;
gridmesh(2)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_row(bs,gap,margin(3),columns,false,false);%�ο���
column_index=margin(2)+[bs:bs:bs*(rows-0.5)];
folderList=0:1:3;
gridmesh(3)=create_gridmesh(row_index,column_index,folderList,'0');

setting=set_area(area,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;

%% Area 7 by wjk
area=7;
rows=3;
columns=[1 5 4 3];
gap=[0.655 0.15 0.15 0];
margin=[0.13 0.115 0 0.87];
origin=[98.38 0]; % to do
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap);
N=bs*rows+margin(1)+margin(2);
in_gap{1}=[0.3275];
in_gap{2}=[];
in_gap{3}=[];
in_gap{4}=[];

row_index=create_row(bs,gap,margin(3),columns,false,false);%�����ӵĲ��Ե�
column_index=margin(2)+[bs/2:bs:bs*(rows-0.5)];
folderList=0:2:4;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_mid_row(bs,gap,margin(3)+bs/2,columns,false,false);%���Ե�-�м��
column_index=margin(2)+[bs:bs:bs*(rows-0.5)];
folderList=1:2:3;
gridmesh(2)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_row(bs,gap,margin(3),columns,false,false);%�ο���
column_index=margin(2)+[bs:bs:bs*(rows-0.5)];
folderList=0:1:1;
gridmesh(3)=create_gridmesh(row_index,column_index,folderList,'0');

setting=set_area(area,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;