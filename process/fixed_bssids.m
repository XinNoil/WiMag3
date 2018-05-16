clear
clc
load glo.mat
cd (work_path)
% ²ÎÊıÉèÖÃ
i_area=7;
data_version='1';
load(['data/' area_table{i_area} '/fingerprint' data_version '.mat']);
bssids={'68:db:54:b9:99:ce','70:ba:ef:c6:bc:40','b0:95:8e:16:5d:35'};
bssid_map=containers.Map(bssids,num2cell(1:length(bssids)));
fp.bssid_map=bssid_map;
save(['data/' area_table{i_area} '/fingerprint' data_version '.mat'],'fp');