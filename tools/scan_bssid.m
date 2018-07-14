function scan_bssid(i_area,RSSI_threshold)
load glo.mat area_table data_version
load(['data/' area_table{i_area} '/fingerprint' data_version '.mat']);
settings=fp.settings;
% BSSID_MAPππ‘Ï
bssids=[];
for i=1:length(settings)
    cd (['original_data/' area_table{i_area} '/long/' num2str(i)])
    gridmesh=settings{i}.gridmesh;
    for j=1:length(gridmesh)
        if strcmp(gridmesh(j).type,'0')
            tmp_bssids=select_gridmesh(gridmesh(j),RSSI_threshold);
            bssids=unique([bssids;tmp_bssids]);
        end
    end
    cd ../../../..
end

bssid_map=containers.Map(bssids,num2cell(1:length(bssids)));
fp.bssid_map=bssid_map;
disp(bssid_map);
save(['data/' area_table{i_area} '/fingerprint' data_version '.mat'],'fp');
disp(['save to: data/' area_table{i_area} '/fingerprint' data_version '.mat']);