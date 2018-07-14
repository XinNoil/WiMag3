clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
load(['data/fingerprints' data_version '.mat']);
Areas(1).aid=1;
Areas(1).aName='天津大学第55教学楼';
Areas(1).aAddress='';
Areas(1).aGeographicLocation=[0 0];
Areas(1).aLocateEngineConf.Method='RADAR';
Areas(1).aLocateEngineConf.K=3;

AreaSlices(1).asId=1;
AreaSlices(1).aId=1;
AreaSlices(1).asName='四层';
AreaSlices(1).asFloor='4';
AreaSlices(1).asAltitude=25;
AreaSlices(1).asRelativeCoordinate=[0 0];
AreaSlices(1).asSize=[55 4.91];
AreaSlices(1).asFloorplanFilename='55_5.svg';
AreaSlices(1).asPFSList=[1,2];

PFS(1).pId=1;
PFS(1).asId=1;
PFS(1).pType='rssi';
PFS(1).pRelativeCoordinates=fps{1}.cdns;
PFS(1).pRssis=cell2mat(fps{1}.rssis);
PFS(1).pBssids=keys(fps{1}.bssid_map);

PFS(2).pId=1;
PFS(2).asId=1;
PFS(2).pType='mag';
PFS(2).pRelativeCoordinates=fps{1}.cdns;
PFS(2).pMags=fps{1}.magnetics;

save server_data.mat Areas AreaSlices PFS

