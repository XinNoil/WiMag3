clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);

load(['data/fingerprints' data_version '.mat']);
load(['data/testdatas' data_version '.mat']);

areas=4;%1:length(area_table);

for area_i=areas
    fp=fps{area_i};
    fp=rm_field(fp,'rssi_mask');
    fp=set_rssi_mask(fp,tds{area_i},is_rssi(area_i));
    fps{area_i}=fp;
end
save(['data/fingerprints' data_version '.mat'],'fps');