%% Test
clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
test_area=1;
load(['data/' area_table{test_area} '/parameters.mat']);
load (['data/fingerprints' data_version '.mat']);
fp=fps{test_area};
plot_floor_mark(fp.settings);
plot(fp.cdns(:,1),fp.cdns(:,2),'b*');