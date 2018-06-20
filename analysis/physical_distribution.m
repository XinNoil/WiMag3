%% 定位误差与空间位置关系
clear
clc
load glo.mat
cd (work_path)
test_area=1;
load(['data/' area_table{test_area} '/parameters.mat']);
disp(['data_version:' data_version]);
load(['result/' area_table{test_area} '/result' data_version '_' get_resultName(parameters)]);
load (['data/fingerprints' data_version '.mat']);
load (['data/' area_table{test_area} '/testdata' data_version '.mat']);
fp=fps{test_area};
save result/result_show.mat;
cdns=fp.cdns;
save result/fpcdns.mat cdns
cdns=td.cdns;
save result/tdcdns.mat cdns

simulation_parameter=parameters.simulation_parameter;
mag_vaild=[results.wifi_err]<simulation_parameter;
test_cdns=reshape([results.test_cdns],2,length(results))';
test_magnitudes=td.magnitudes;
test_distance_center=td.distance_center;
Per=0.75;

%% 平面图
% plot_floor_mark(fp.settings);
plot_floor_mark(fp.settings,test_cdns,test_magnitudes);
plot_floor_mark(fp.settings,test_cdns,test_distance_center);

%% 定位误差
mag_err=[results.result_err]';
% plot_floor_mark(fp.settings,test_cdns,mag_vaild);
plot_floor_mark(fp.settings,test_cdns(mag_vaild,:),mag_err(mag_vaild,3));

tmp=getCdfError(mag_err(mag_vaild,3),Per);
mask=mag_err(mag_vaild,3)>tmp;
plot_floor_mark(fp.settings,test_cdns(mag_vaild,:),mask);
setupdatefun(@myupdatefcn);