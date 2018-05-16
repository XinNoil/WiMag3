vars.plot01='1';
bs=0.8; %ש���С
% Area 1
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
settings{1}=setting;

% Area 2
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
settings{2}=setting;

% Area 3
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
folderList=1:2:3;
gridmesh(2)=create_gridmesh(row_index,column_index,folderList,'0');

setting=set_area(area,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{3}=setting;

settings{1}.magnetic_object_cdns=[
    0 3.5*0.8
    4*0.8+0.075 3.5*0.8
    4*0.8+0.075 -0.5*0.8
    10.85 3.5*0.8
    10.85 -0.5*0.8];
settings{1}.magnetic_object_type=[1 0 1 1 1 1];
settings{1}.magnetic_room(1).x=4*0.8+0.075+0.3;
settings{1}.magnetic_room(1).y=3*0.8+0.12+0.12;
settings{1}.magnetic_room(1).width=3.05;
settings{1}.magnetic_room(1).height=1.25;
settings{1}.magnetic_room(1).text='���羮';
settings{1}.magnetic_room(2).x=0;
settings{1}.magnetic_room(2).y=0.63;
settings{1}.magnetic_room(2).width=0.3;
settings{1}.magnetic_room(2).height=1.17;
settings{1}.magnetic_room(2).text='ů��';
settings{2}.magnetic_object_cdns=[
    2.87 6.5*0.8
    8.5*0.8+0.15 6.5*0.8
    8.5*0.8+0.15 -0.5*0.8
    17.5*0.8+0.45 6.5*0.8
    17.5*0.8+0.45 -0.5*0.8
    27*0.8+0.75 6.5*0.8
    27*0.8+0.75 -0.5*0.8];
settings{2}.magnetic_object_type=[2 3 1 2 1 2 1];
settings{2}.magnetic_room(1).x=0;
settings{2}.magnetic_room(1).y=6*0.8+0.12;
settings{2}.magnetic_room(1).width=3.3;
settings{2}.magnetic_room(1).height=1.45;
settings{1}.magnetic_room(1).text='ǿ�羮';
settings{3}.magnetic_object_cdns=[
    0 3.5*0.8
    0 -0.5*0.8
    5.5*0.8 3.5*0.8
    5.5*0.8 -0.5*0.8
    14.5*0.8+0.3 3.5*0.8];
settings{3}.magnetic_object_type=[1 1 1 1 1];