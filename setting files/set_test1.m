%% bofore
vars.plot01='1';
bs=0.8; %ש���С
%% Area 1
area=1; % ������
rows=1; % ש������
columns=[7]; % ש������
gap=[0]; % �����еļ�϶
margin=[0.13 0.115 0 0.5]; % �������ұ߽�
origin=[0 0]; % ԭ��
M=bs*sum(columns)+margin(3)+margin(4)+sum(gap); % ��
N=bs*rows+margin(1)+margin(2); % ��

% row_index=create_row(bs,gap,margin(3),columns,true,false);%���Ե�
% column_index=margin(2)+[bs/2:bs:bs*(rows-0.5)];
% folderList=0:2:4;
% gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'1');
% 
% row_index=create_mid_row(bs,gap,margin(3)+bs/2,columns,true,false);%���Ե�
% column_index=margin(2)+[bs:bs:bs*(rows-0.5)];
% folderList=1:2:3;
% gridmesh(2)=create_gridmesh(row_index,column_index,folderList,'1');

row_index=create_row(bs,gap,margin(3),columns,true,false);%�ο���
column_index=margin(2)+[bs:bs:bs*(rows)];
folderList=0;
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'0');

setting=set_area(1,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;