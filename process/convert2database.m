%% ��������
clear
clc
load glo.mat
cd (work_path)
data_version='1';
load(['data/fingerprints' data_version '.mat']);
%% 55¥
building=1;
Buildings(building).id=building;
Buildings(building).name='����ѧ��55��ѧ¥';
Buildings(building).address='����н��������ӽ���԰���Ź�·135��';
Buildings(building).geographicLocation=[39.0057055878,117.3206219345];

%% 55¥4��
area=1;
area_i=1;
Buildings(building).Areas(area).no=area;
Buildings(building).Areas(area).name='�Ĳ�';
Buildings(building).Areas(area).floor=4;
Buildings(building).Areas(area).altitude=21;
Buildings(building).Areas(area).relativeCoordinate=[0 0];
Buildings(building).Areas(area).size=[113.380 19.180];
Buildings(building).Areas(area).floorplanFilename='55_4.svg';
Buildings(building).Areas(area).locationDatabases=[1,2];
Buildings(building).Areas(area).locateEngineConf.Method='RADAR';
Buildings(building).Areas(area).locateEngineConf.K=3;

LDB_i=Buildings(building).Areas(area).locationDatabases(1);
type='rssi';
LDB(LDB_i)=createPFS(LDB_i,building,area,type,fps,area_i);
Buildings(building).Areas(area).stations=createStation(LDB_i,fps,area_i);
LDB(LDB_i).relativeCoordinates=[LDB(LDB_i).relativeCoordinates(:,1)+1.34 11-LDB(LDB_i).relativeCoordinates(:,2)];

LDB_i=Buildings(building).Areas(area).locationDatabases(2);
type='mag';
LDB(LDB_i)=createPFS(LDB_i,building,area,type,fps,area_i);
LDB(LDB_i).relativeCoordinates=[LDB(LDB_i).relativeCoordinates(:,1)+1.34 11-LDB(LDB_i).relativeCoordinates(:,2)];

%% 55¥5��
area=2;
area_i=2;
Buildings(building).Areas(area).no=area;
Buildings(building).Areas(area).name='���';
Buildings(building).Areas(area).floor=5;
Buildings(building).Areas(area).altitude=25;
Buildings(building).Areas(area).relativeCoordinate=[0 0];
Buildings(building).Areas(area).size=[113.380 19.180];
Buildings(building).Areas(area).floorplanFilename='55_5.svg';
Buildings(building).Areas(area).locationDatabases=[3,4];
Buildings(building).Areas(area).locateEngineConf.Method='RADAR';
Buildings(building).Areas(area).locateEngineConf.K=3;

LDB_i=Buildings(building).Areas(area).locationDatabases(1);
type='rssi';
LDB(LDB_i)=createPFS(LDB_i,building,area,type,fps,area_i);
Buildings(building).Areas(area).stations=createStation(LDB_i,fps,area_i);
LDB(LDB_i).relativeCoordinates=[LDB(LDB_i).relativeCoordinates(:,1)+1.34 11-LDB(LDB_i).relativeCoordinates(:,2)];

LDB_i=Buildings(building).Areas(area).locationDatabases(2);
type='mag';
LDB(LDB_i)=createPFS(LDB_i,building,area,type,fps,area_i);
LDB(LDB_i).relativeCoordinates=[LDB(LDB_i).relativeCoordinates(:,1)+1.34 11-LDB(LDB_i).relativeCoordinates(:,2)];

%% 55¥2��
area=3;
area_i=5;
Buildings(building).Areas(area).no=area;
Buildings(building).Areas(area).name='����';
Buildings(building).Areas(area).floor=2;
Buildings(building).Areas(area).altitude=13;
Buildings(building).Areas(area).relativeCoordinate=[0,0];
Buildings(building).Areas(area).size=[141.380 70.755];
Buildings(building).Areas(area).floorplanFilename='55_2.svg';
Buildings(building).Areas(area).locationDatabases=[5,6];
Buildings(building).Areas(area).locateEngineConf.Method='RADAR';
Buildings(building).Areas(area).locateEngineConf.K=3;

LDB_i=Buildings(building).Areas(area).locationDatabases(1);
type='rssi';
LDB(LDB_i)=createPFS(LDB_i,building,area,type,fps,area_i);
Buildings(building).Areas(area).stations=createStation(LDB_i,fps,area_i);

LDB_i=Buildings(building).Areas(area).locationDatabases(2);
type='mag';
LDB(LDB_i)=createPFS(LDB_i,building,area,type,fps,area_i);

%% 55¥2��չ��
area=4;
area_i=6;
Buildings(building).Areas(area).no=area;
Buildings(building).Areas(area).name='����';
Buildings(building).Areas(area).floor=2;
Buildings(building).Areas(area).altitude=13;
Buildings(building).Areas(area).relativeCoordinate=[0,0];
Buildings(building).Areas(area).size=[141.380 70.755];
Buildings(building).Areas(area).floorplanFilename='55_2.svg';
Buildings(building).Areas(area).locationDatabases=[9,10];
Buildings(building).Areas(area).locateEngineConf.Method='RADAR';
Buildings(building).Areas(area).locateEngineConf.K=3;

LDB_i=Buildings(building).Areas(area).locationDatabases(1);
type='rssi';
LDB(LDB_i)=createPFS(LDB_i,building,area,type,fps,area_i);
Buildings(building).Areas(area).stations=createStation(LDB_i,fps,area_i);
LDB(LDB_i).relativeCoordinates=[LDB(LDB_i).relativeCoordinates(:,1)+0.8 13.315-LDB(LDB_i).relativeCoordinates(:,2)];

LDB_i=Buildings(building).Areas(area).locationDatabases(2);
type='mag';
LDB(LDB_i)=createPFS(LDB_i,building,area,type,fps,area_i);
LDB(LDB_i).relativeCoordinates=[LDB(LDB_i).relativeCoordinates(:,1)+0.8 13.315-LDB(LDB_i).relativeCoordinates(:,2)];

%% 55¥2��չ����210
area=5;
area_i=7;
Buildings(building).Areas(area).no=area;
Buildings(building).Areas(area).name='����210';
Buildings(building).Areas(area).floor=2;
Buildings(building).Areas(area).altitude=13;
Buildings(building).Areas(area).relativeCoordinate=[0,0];
Buildings(building).Areas(area).size=[141.380 70.755];
Buildings(building).Areas(area).floorplanFilename='55_2.svg';
Buildings(building).Areas(area).locationDatabases=[11,12];
Buildings(building).Areas(area).locateEngineConf.Method='RADAR';
Buildings(building).Areas(area).locateEngineConf.K=3;

LDB_i=Buildings(building).Areas(area).locationDatabases(1);
type='rssi';
LDB(LDB_i)=createPFS(LDB_i,building,area,type,fps,area_i);
Buildings(building).Areas(area).stations=createStation(LDB_i,fps,area_i);
new_cdn=zeros(size(LDB(LDB_i).relativeCoordinates));
LDB(LDB_i).relativeCoordinates=[15.34-LDB(LDB_i).relativeCoordinates(:,2) 32.215-LDB(LDB_i).relativeCoordinates(:,1)];

LDB_i=Buildings(building).Areas(area).locationDatabases(2);
type='mag';
LDB(LDB_i)=createPFS(LDB_i,building,area,type,fps,area_i);
LDB(LDB_i).relativeCoordinates=[15.34-LDB(LDB_i).relativeCoordinates(:,2) 32.215-LDB(LDB_i).relativeCoordinates(:,1)];

%% ͼ���
building=2;
Buildings(building).id=building;
Buildings(building).name='����ѧͼ���';
Buildings(building).address='����н��������ӽ���԰���Ź�·135��';
Buildings(building).geographicLocation=[39.0030847114,117.3206531946];

%% ͼ��ݱ���1�㶫��
area=1;
area_i=4;
Buildings(building).Areas(area).no=area;
Buildings(building).Areas(area).name='����1�㶫��';
Buildings(building).Areas(area).floor=1;
Buildings(building).Areas(area).altitude=9;
Buildings(building).Areas(area).relativeCoordinate=[0 0];
Buildings(building).Areas(area).size=[0 0];
Buildings(building).Areas(area).floorplanFilename='lib_1_ne.svg';
Buildings(building).Areas(area).locationDatabases=[7,8];
Buildings(building).Areas(area).locateEngineConf.Method='RADAR';
Buildings(building).Areas(area).locateEngineConf.K=3;

LDB_i=Buildings(building).Areas(area).locationDatabases(1);
type='rssi';
LDB(LDB_i)=createPFS(LDB_i,building,area,type,fps,area_i);
Buildings(building).Areas(area).stations=createStation(LDB_i,fps,area_i);

LDB_i=Buildings(building).Areas(area).locationDatabases(2);
type='mag';
LDB(LDB_i)=createPFS(LDB_i,building,area,type,fps,area_i);

save server_data.mat Buildings LDB
BuildingsJson=jsonencode(Buildings);
LDBJson=jsonencode(LDB);
fid = fopen('Buildings.json', 'w','n','UTF-8');
fprintf(fid,'%s',BuildingsJson); 
fclose(fid);
fid = fopen('LDB.json', 'w','n','UTF-8');
fprintf(fid,'%s',LDBJson); 
fclose(fid);
% need to be converted to UTF8 format.