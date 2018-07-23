clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);

load(['data/fingerprints' data_version '.mat']);
load(['data/testdatas' data_version '.mat']);

num_thredhold=5;
RSSI_min=-100;

for area_i=[1 2 4 5]
    fp=fps{area_i};
    td=tds{area_i};
    BSSIDs={};
    fprssis=cell2mat(fp.rssis);
    tdrssis=cell2mat(td.rssis);
    nums=fprssis>-100;
    if isfield(fp,'rssi_mask')
        fp.rssi_mask=rssi_mask;
    else
        fp.rssi_mask=rssi_mask&fp.rssi_mask;
    end
    fps{area_i}=fp;
end
% save(['data/fingerprints' data_version '.mat'],'fps');