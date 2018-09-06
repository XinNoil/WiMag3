%% show_floor_map
clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
test_area=4;
load (['data/fingerprints' data_version '.mat']);
load (['data/testdatas' data_version '.mat']);
fp=fps{test_area};
td=tds{test_area};
plot_floor_mark(fp.settings);
plot(fp.cdns(:,1),fp.cdns(:,2),'r*');
plot(td.cdns(:,1),td.cdns(:,2),'b*');