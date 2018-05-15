% 显示定位结果
clear
clc
load glo.mat
cd (work_path)
%% 载入数据
test_area=1;
data_version='1';
load(['data/' area_table{test_area} '/parameters' '.mat']);
load (['data/fingerprints' data_version '.mat']);
fp=fps{test_area};
load(['data/' area_table{test_area} '/testdata' data_version '.mat']);
load(['result/' area_table{test_area} '/result' data_version '_' get_resultName(parameters)]);
K=3;
save result/result_show.mat;
cdns=fp.cdns;
save result/fpcdns.mat cdns
cdns=td.cdns;
save result/tdcdns.mat cdns
test_cdns=reshape([results.test_cdns],2,length(results))';
%% WiFi定位结构
% cut=6;
% wifi_err=[results.wifi_err];
% wifi_err(wifi_err>cut)=cut;
% plot_floor_mark(fp.settings,test_cdns,wifi_err);
% setupdatefun(@myupdatefcn4);
%% 两阶段定位结构
cut=5;
result_err=[results.result_err]';
result_err(result_err>cut)=cut;
plot_floor_mark(fp.settings,test_cdns,result_err(:,K));
setupdatefun(@myupdatefcn);