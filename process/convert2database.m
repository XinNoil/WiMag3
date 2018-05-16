%% 载入数据
clear
clc
load glo.mat
cd (work_path)
data_version='1';
load(['data/fingerprints' data_version '.mat']);
%% 55楼
building=1;
Buildings(building).id=building;
Buildings(building).name='天津大学第55教学楼';
Buildings(building).address='天津市津南区海河教育园区雅观路135号';
Buildings(building).geographicLocation=[39.0057055878,117.3206219345];

%% 55楼4层
area=1;
area_i=1;
Buildings(building).Areas(area).no=area;
Buildings(building).Areas(area).name='四层';
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

%% 55楼5层
area=2;
area_i=2;
Buildings(building).Areas(area).no=area;
Buildings(building).Areas(area).name='五层';
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

%% 55楼2层
area=3;
area_i=5;
Buildings(building).Areas(area).no=area;
Buildings(building).Areas(area).name='二层';
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

%% 55楼2层展厅
area=4;
area_i=6;
Buildings(building).Areas(area).no=area;
Buildings(building).Areas(area).name='二层';
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

%% 55楼2层展览室210
area=5;
area_i=7;
Buildings(building).Areas(area).no=area;
Buildings(building).Areas(area).name='二层210';
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

%% 图书馆
building=2;
Buildings(building).id=building;
Buildings(building).name='天津大学图书馆';
Buildings(building).address='天津市津南区海河教育园区雅观路135号';
Buildings(building).geographicLocation=[39.0030847114,117.3206531946];

%% 图书馆北栋1层东侧
area=1;
area_i=4;
Buildings(building).Areas(area).no=area;
Buildings(building).Areas(area).name='北栋1层东侧';
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