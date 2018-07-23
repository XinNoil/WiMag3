%% bofore
vars.plot01='1';
bs=0.8; %ש���С
%% Area 1
area=1; % ������
rows=[8 5 5 6 6 6]; % ש������
columns=3; % ש������
gap=[0.15 0.15 0.15 0.15 0.15 0]; % �����еļ�϶
margin=[0 0 0.2 0.185]; % �������ұ߽�
origin=[0 0]; % ԭ��
N=bs*sum(rows)+margin(1)+margin(2)+sum(gap); % ��
M=bs*columns+margin(3)+margin(4); % ��

column_index=[0.4:0.8:0.8*7.5...
    8*0.8+0.15+0.4:0.8:12.5*0.8+gap(1)...
    (rows(1)+rows(2))*0.8+gap(1)+gap(2)+0.4:0.8:(rows(1)+rows(2)+rows(3)-0.5)*0.8+gap(1)+gap(2)...
    (rows(1)+rows(2)+rows(3))*0.8+gap(1)+gap(2)+gap(3)+0.4:0.8:(rows(1)+rows(2)+rows(3)+rows(4)-0.5)*0.8+gap(1)+gap(2)+gap(3)...
    (rows(1)+rows(2)+rows(3)+rows(4))*0.8+gap(1)+gap(2)+gap(3)+gap(4)+0.4:0.8:(rows(1)+rows(2)+rows(3)+rows(4)+rows(5)-0.5)*0.8+gap(1)+gap(2)+gap(3)+gap(4)...
    (rows(1)+rows(2)+rows(3)+rows(4)+rows(5))*0.8+gap(1)+gap(2)+gap(3)+gap(4)+gap(5)+0.4:0.8:(rows(1)+rows(2)+rows(3)+rows(4)+rows(5)+rows(6)-1.5)*0.8+gap(1)+gap(2)+gap(3)+gap(4)+gap(5)];%���Ե�
row_index=margin(4)+[0:bs:bs*(columns)];
folderList=[1:2:15 18:2:26 29:2:37 40:2:50 53:2:63 66:2:74];
gridmesh(1)=create_gridmesh(row_index,column_index,folderList,'1');

column_index=[0:0.8:0.8*8 ...
    rows(1)*0.8+gap(1):0.8:(rows(1)+rows(2))*0.8+gap(1) ...
    (rows(1)+rows(2))*0.8+gap(1)+gap(2):0.8:(rows(1)+rows(2)+rows(3))*0.8+gap(1)+gap(2) ...
    (rows(1)+rows(2)+rows(3))*0.8+gap(1)+gap(2)+gap(3):0.8:(rows(1)+rows(2)+rows(3)+rows(4))*0.8+gap(1)+gap(2)+gap(3) ...
    (rows(1)+rows(2)+rows(3)+rows(4))*0.8+gap(1)+gap(2)+gap(3)+gap(4):0.8:(rows(1)+rows(2)+rows(3)+rows(4)+rows(5))*0.8+gap(1)+gap(2)+gap(3)+gap(4) ...
    (rows(1)+rows(2)+rows(3)+rows(4)+rows(5))*0.8+gap(1)+gap(2)+gap(3)+gap(4)+gap(5):0.8:(rows(1)+rows(2)+rows(3)+rows(4)+rows(5)+rows(6)-1)*0.8+gap(1)+gap(2)+gap(3)+gap(4)+gap(5)];%���Ե�
row_index=margin(4)+[bs/2:bs:bs*(columns-0.5)];
folderList=[0:2:16 17:2:27 28:2:38 39:2:51 52:2:64 65:2:75];
gridmesh(2)=create_gridmesh(row_index,column_index,folderList,'1');

column_index=[0:0.8:0.8*8 ...
    rows(1)*0.8+gap(1):0.8:(rows(1)+rows(2))*0.8+gap(1) ...
    (rows(1)+rows(2))*0.8+gap(1)+gap(2):0.8:(rows(1)+rows(2)+rows(3))*0.8+gap(1)+gap(2) ...
    (rows(1)+rows(2)+rows(3))*0.8+gap(1)+gap(2)+gap(3):0.8:(rows(1)+rows(2)+rows(3)+rows(4))*0.8+gap(1)+gap(2)+gap(3) ...
    (rows(1)+rows(2)+rows(3)+rows(4))*0.8+gap(1)+gap(2)+gap(3)+gap(4):0.8:(rows(1)+rows(2)+rows(3)+rows(4)+rows(5))*0.8+gap(1)+gap(2)+gap(3)+gap(4) ...
    (rows(1)+rows(2)+rows(3)+rows(4)+rows(5))*0.8+gap(1)+gap(2)+gap(3)+gap(4)+gap(5):0.8:(rows(1)+rows(2)+rows(3)+rows(4)+rows(5)+rows(6)-1)*0.8+gap(1)+gap(2)+gap(3)+gap(4)+gap(5)];%���Ե�
row_index=margin(4)+[0:bs:bs*(columns)];%�ο���
folderList=0:40;
gridmesh(3)=create_gridmesh(row_index,column_index,folderList,'0');

setting=set_area(1,bs,rows,columns,gap,margin,origin,M,N,gridmesh);
plot_floor(setting,true,vars);
settings{area}=setting;
clear gridmesh;