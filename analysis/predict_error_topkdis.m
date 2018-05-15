%% Ô¤²â¶¨Î»Îó²î
clear
clc
load glo.mat
cd (work_path)
test_area=5;
load(['data/' area_table{test_area} '/parameters.mat']);
data_version='1';
load(['result/' area_table{test_area} '/result' data_version '_' get_resultName(parameters)]);
load (['data/fingerprints' data_version '.mat']);
fp=fps{test_area};
simulation_parameter=parameters.simulation_parameter;
mag_vaild=[results.wifi_err]<simulation_parameter;
test_cdns=reshape([results.test_cdns],2,length(results))';
%% RSSI
valid_avgpd_k_r=[results.avgpd_k_r];
valid_avgpd_3_r=valid_avgpd_k_r;
% valid_avgpd_10_r=valid_avgpd_k_r(10,:);
% valid_avgpd_3b10_r=valid_avgpd_3_r./valid_avgpd_10_r;
valid_wifi_err=[results.wifi_err];

newfig;
plot(valid_avgpd_3_r,valid_wifi_err,'b*');
ylim([0 5]);
% newfig;
% plot(valid_avgpd_3b10_r,valid_wifi_err,'b*');

my_predict_error(valid_avgpd_3_r,valid_wifi_err,{'Dwk','Average WiFi Error'});
% my_predict_error(valid_avgpd_3b10_r,valid_wifi_err,{'Pw','Average WiFi Error'});
savegcf(['figures/' area_table{test_area} '/avgpd_3_err_w']);

%% Mag
mag_err=[results.result_err];
valid_mag_err=mag_err(3,mag_vaild);

valid_avgpd_k=[results.avgpd_k];
valid_avgpd_3=valid_avgpd_k(3,mag_vaild);
valid_avgpd_10=valid_avgpd_k(10,mag_vaild);
valid_avgpd_3b10=valid_avgpd_3./valid_avgpd_10;

newfig;
plot(valid_avgpd_3,valid_mag_err,'b*');
newfig;
plot(valid_avgpd_3b10,valid_mag_err,'b*');

my_predict_error(valid_avgpd_3,valid_mag_err,{'Dmk','Average Magnetic Error'});
savegcf(['figures/' area_table{test_area} '/avgpd_3_err_m']);
my_predict_error(valid_avgpd_3b10,valid_mag_err,{'Pm','Average Magnetic Error'});
savegcf(['figures/' area_table{test_area} '/avgpd_3b10_err_m']);

getCdfError(mag_err(3,:),0.5)
